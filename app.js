/**
 * Copyright 2017 IBM All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the 'License');
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an 'AS IS' BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

//TODO:
// User login (register / enroll) --- login
// Code cleanup

var express = require('express');
var session = require('express-session');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var http = require('http');
var app = express();
var expressJWT = require('express-jwt');
var jwt = require('jsonwebtoken');
var cors = require('cors');
var winston = require('winston');
var config = require('./config.json');
var helper = require('./app/helper.js');
var channels = require('./app/create-channel.js');
var join = require('./app/join-channel.js');
var install = require('./app/install-chaincode.js');
var instantiate = require('./app/instantiate-chaincode.js');
var invoke = require('./app/invoke-transaction.js');
var query = require('./app/query.js');
var host = process.env.HOST || config.host;
var port = process.env.PORT || config.port;
//app.use(cookieParser());
//app.use(session({ secret: 'lostmydata', resave: true, saveUninitialized: true }));
app.options('*', cors());
app.use(cors());
//support parsing of application/json type post data
app.use(bodyParser.json());
//support parsing of application/x-www-form-urlencoded post data
app.use(bodyParser.urlencoded({
    extended: false
}));
app.set('secret', 'thisismysecret'); // set secret variable
app.use(expressJWT({
    secret: 'thisismysecret'
}).unless({
    path: ['/users'] //TODO: HOW about channels ?
}));
var logger = new(winston.Logger)({
    level: 'debug',
    transports: [
        new(winston.transports.Console)({
            colorize: true
        }),
    ]
});
// *******************************************************
//  Start the server
// *******************************************************
var server = http.createServer(app).listen(port, function() {});
logger.info('****************** SERVER STARTED ************************');
logger.info('**************  http://' + host + ':' + port + '  ******************');
server.timeout = 240000;
/**
 Register and enroll user
*/
app.post('/users', function(req, res) {
    logger.debug('End point : /users');
    logger.debug('User name : ' + req.body.username);
    logger.debug('Org name  : ' + req.body.orgName);
    //var promise = helper.enrollUser(req.body.username, req.body.orgName);
    var token = jwt.sign({
        username: req.body.username,
        //password: req.body.password, //Are we using existing user or new users register ?
        orgName: req.body.orgName
    }, app.get('secret'));
    var promise = helper.getAdminUser(req.body.orgName);
    promise.then(function(value) {
        //if (value === true){
        if (value != null) {
            res.json({
                success: true,
                message: 'Successfully enrolled user "' + req.body.username + '"',
                token: token
            });
        } else {
            res.json({
                success: false,
                message: 'Failed to enroll and register user "' + req.body.username + '"'
            });
        }
    });
});
/*
  Channel creation
*/
app.post('/channels', function(req, res) {
    logger.debug('End point : /channels');
    logger.debug('Channel name : ' + req.body.channelName);
    logger.debug('channelConfigPath : ' + req.body.channelConfigPath); //../artifacts/channel/mychannel.tx
    var token = req.body.token || req.query.token || req.headers['x-access-token'];
    jwt.verify(token, app.get('secret'), function(err, decoded) {
        if (err) {
            res.send({
                success: false,
                message: 'Failed to authenticate token.'
            });
        } else {
            //res.send(d);
            logger.debug('User name : ' + decoded.username);
            logger.debug('Org name  : ' + decoded.orgName);
            var promise = channels.createChannel(req.body.channelName, req.body.channelConfigPath, decoded.username, decoded.orgName);
            promise.then(function(message) {
                res.send(message);
            });
        }
    });
});
/*
  Join- channel on peers
*/
//FIXME: Should we take list of peers names as we save the urls of the peers in config ?
app.post('/channels/:channelName/peers', function(req, res) {
    logger.debug('End point : /channels/' + req.params.channelName + '/peers');
    logger.debug('peers : ' + req.body.peers); // target peers list
    var token = req.body.token || req.query.token || req.headers['x-access-token'];
		jwt.verify(token, app.get('secret'), function(err, decoded) {
				if (err) {
						res.send({
								success: false,
								message: 'Failed to authenticate token.'
						});
				} else {
						//res.send(d);
						logger.debug('User name : ' + decoded.username);
						logger.debug('Org name  : ' + decoded.orgName);
						var promise = join.joinChannel(req.params.channelName, req.body.peers, decoded.username, decoded.orgName);
						promise.then(function(message) {
								res.send(message);
						});
				}
		});
});
/*
  Install chaincode on target peers
*/

//FIXME: Change this enpoint to peers/peerX/chaincodes
app.post('/chaincodes', function(req, res) {
    logger.debug('End point : /channels');
    logger.debug('peers : ' + req.body.peers); // target peers list
    logger.debug('chaincodeName : ' + req.body.chaincodeName);
    //TODO: should we download chaincode if it is http URL ?
    logger.debug('chaincodePath  : ' + req.body.chaincodePath);
    logger.debug('chaincodeVersion  : ' + req.body.chaincodeVersion);

    //res.send('received your request . will process it soon');
		var token = req.body.token || req.query.token || req.headers['x-access-token'];
		jwt.verify(token, app.get('secret'), function(err, decoded) {
				if (err) {
						res.send({
								success: false,
								message: 'Failed to authenticate token.'
						});
				} else {
						//res.send(d);
						logger.debug('User name : ' + decoded.username);
						logger.debug('Org name  : ' + decoded.orgName);
						var promise = install.installChaincode(req.body.peers, req.body.chaincodeName, req.body.chaincodePath, req.body.chaincodeVersion, decoded.username, decoded.orgName);
						promise.then(function(message) {
								res.send(message);
						});
				}
		});
});
/*
  instantiate chaincode on target peers
*/
//FIXME: Should we take list of peers names as we save the urls of the peers in config ?
app.post('/channels/:channelName/chaincodes', function(req, res) {
    logger.debug('End point : /channels');
    logger.debug('peers : ' + req.body.peers); // target peers list
    logger.debug('chaincodeName : ' + req.body.chaincodeName);
    logger.debug('chaincodePath  : ' + req.body.chaincodePath);
    logger.debug('chaincodeVersion  : ' + req.body.chaincodeVersion);

		var token = req.body.token || req.query.token || req.headers['x-access-token'];
		jwt.verify(token, app.get('secret'), function(err, decoded) {
				if (err) {
						res.send({
								success: false,
								message: 'Failed to authenticate token.'
						});
				} else {
						//res.send(d);
						logger.debug('User name : ' + decoded.username);
						logger.debug('Org name  : ' + decoded.orgName);
						var promise = instantiate.instantiateChaincode(req.body.peers, req.params.channelName, req.body.chaincodeName, req.body.chaincodePath, req.body.chaincodeVersion, req.body.functionName, req.body.args, decoded.username, decoded.orgName);
						promise.then(function(message) {
								res.send(message);
						});
				}
		});
});
/*
  invoke transaction on chaincode on target peers
*/
//FIXME: Should we take list of peers names as we save the urls of the peers in config ?
app.post('/channels/:channelName/chaincodes/:chaincodeName', function(req, res) {
    logger.debug('End point : /channels');
    logger.debug('peers : ' + req.body.peers); // target peers list
    logger.debug('chaincodeName : ' + req.params.chaincodeName);
    logger.debug('Args : ' + req.body.args);
    logger.debug('chaincodeVersion  : ' + req.body.chaincodeVersion);

				var token = req.body.token || req.query.token || req.headers['x-access-token'];
				jwt.verify(token, app.get('secret'), function(err, decoded) {
						if (err) {
								res.send({
										success: false,
										message: 'Failed to authenticate token.'
								});
						} else {
								//res.send(d);
								logger.debug('User name : ' + decoded.username);
								logger.debug('Org name  : ' + decoded.orgName);
								let promise = invoke.invokeChaincode(req.body.peers, req.params.channelName, req.params.chaincodeName, req.body.chaincodeVersion, req.body.args, decoded.username, decoded.orgName);
								promise.then(function(message) {
										res.send(message);
								});
						}
				});
});
/*
  Query on chaincode on target peers
*/
//FIXME: Should we take list of peers names as we save the urls of the peers in config ?
// 1. Should we need to token stuff here ?
app.get('/channels/:channelName/chaincodes/:chaincodeName', function(req, res) {
    logger.debug('==================== QUERY ON CHAINCODE ==================');
    //logger.debug('peers : '+req.body.peers);// target peers list
    logger.debug('channelName : ' + req.params.channelName);
    logger.debug('chaincodeName : ' + req.params.chaincodeName);
    //logger.debug('chaincodeVersion  : ' +req.body.chaincodeVersion);
    //FIXME: HOW DO WE GET THESE DETAILS in GET ?
    let peer = req.query.peer;
    let args = req.query.args;
    console.log(args);
    args = args.replace(/'/g, '"');
    args = JSON.parse(args);
    let version = req.query.chaincodeVersion;

		var token = req.body.token || req.query.token || req.headers['x-access-token'];
		jwt.verify(token, app.get('secret'), function(err, decoded) {
				if (err) {
						res.send({
								success: false,
								message: 'Failed to authenticate token.'
						});
				} else {
						//res.send(d);
						logger.debug('User name : ' + decoded.username);
						logger.debug('Org name  : ' + decoded.orgName);
						var promise = query.queryChaincode(peer, req.params.channelName, req.params.chaincodeName, version, args, decoded.username, decoded.orgName);
						promise.then(function(message) {
								res.send(message);
						});
				}
		});
});

//getBlockByNumber
app.get('/channels/:channelName/blocks/:blockId', function(req, res) {
    logger.debug('==================== GET BLOCK BY NUMBER ==================');
    //logger.debug('peers : '+req.body.peers);// target peers list
    let blockId = req.params.blockId;
		let peer = req.query.participatingPeer;
		logger.debug('channelName : ' + req.params.channelName);
		logger.debug('BlockID : ' + blockId);
		logger.debug('PEER : ' + peer);
		var token = req.body.token || req.query.token || req.headers['x-access-token'];
		jwt.verify(token, app.get('secret'), function(err, decoded) {
				if (err) {
						res.send({
								success: false,
								message: 'Failed to authenticate token.'
						});
				} else {
						logger.debug('User name : ' + decoded.username);
						logger.debug('Org name  : ' + decoded.orgName);
						var promise = query.getBlockByNumber(peer, blockId, decoded.username, decoded.orgName);
						promise.then(function(message) {
								res.send(message);
						});
				}
		});
});


//GetTransactionByID
app.get('/channels/:channelName/transactions/:trxnId', function(req, res) {
    logger.debug('================ GET TRANSACTION BY TRANSACTION_ID ======================');
    //logger.debug('peers : '+req.body.peers);// target peers list
    logger.debug('channelName : ' + req.params.channelName);
    let trxnId = req.params.trxnId;
		let peer = req.query.participatingPeer;
		var token = req.body.token || req.query.token || req.headers['x-access-token'];
		jwt.verify(token, app.get('secret'), function(err, decoded) {
				if (err) {
						res.send({
								success: false,
								message: 'Failed to authenticate token.'
						});
				} else {
						logger.debug('User name : ' + decoded.username);
						logger.debug('Org name  : ' + decoded.orgName);
						var promise = query.getTransactionByID(peer, trxnId, decoded.username, decoded.orgName);
						promise.then(function(message) {
								res.send(message);
						});
				}
		});
});

//TODO: What hash value to be passed here ?
//GetBlockByHash
app.get('/channels/:channelName/blocks', function(req, res) {
    logger.debug('================ GET BLOCK BY HASH ======================');
    //logger.debug('peers : '+req.body.peers);// target peers list
    logger.debug('channelName : ' + req.params.channelName);
    let hash = req.query.hash;
		let peer = req.query.participatingPeer;
		var token = req.body.token || req.query.token || req.headers['x-access-token'];
		jwt.verify(token, app.get('secret'), function(err, decoded) {
				if (err) {
						res.send({
								success: false,
								message: 'Failed to authenticate token.'
						});
				} else {
						logger.debug('User name : ' + decoded.username);
						logger.debug('Org name  : ' + decoded.orgName);
						var promise = query.getBlockByHash(peer, hash, decoded.username, decoded.orgName);
						promise.then(function(message) {
								res.send(message);
						});
				}
		});
});

//Query for Channel Information
app.get('/channels/:channelName', function(req, res) {
    logger.debug('================ GET CHANNEL INFORMATION ======================');
    //logger.debug('peers : '+req.body.peers);// target peers list
    logger.debug('channelName : ' + req.params.channelName);
		let peer = req.query.participatingPeer;
		var token = req.body.token || req.query.token || req.headers['x-access-token'];
		jwt.verify(token, app.get('secret'), function(err, decoded) {
				if (err) {
						res.send({
								success: false,
								message: 'Failed to authenticate token.'
						});
				} else {
						logger.debug('User name : ' + decoded.username);
						logger.debug('Org name  : ' + decoded.orgName);
						var promise = query.getChainInfo(peer, decoded.username, decoded.orgName);
						promise.then(function(message) {
								res.send(message);
						});
				}
		});
});

// Query to fetch all Installed/instantiated chaincodes
app.get('/chaincodes', function(req, res) {

		var hostingPeer = req.query.hostingPeer;
		var isInstalled = req.query.installed;
		if (isInstalled === 'true'){
			logger.debug('================ GET INSTALLED CHAINCODES ======================');
		} else {
			logger.debug('================ GET INSTANTIATED CHAINCODES ======================');
		}

		//logger.debug('peers : '+req.body.peers);// target peers list
		logger.debug('hostingPeer: ' + req.query.hostingPeer);
		var token = req.body.token || req.query.token || req.headers['x-access-token'];
		jwt.verify(token, app.get('secret'), function(err, decoded) {
				if (err) {
						res.send({
								success: false,
								message: 'Failed to authenticate token.'
						});
				} else {
						logger.debug('User name : ' + decoded.username);
						logger.debug('Org name  : ' + decoded.orgName);
						var promise = query.getInstalledChaincodes(hostingPeer,isInstalled, decoded.username, decoded.orgName);
						promise.then(function(message) {
								res.send(message);
						});
				}
		});
});

// Query to fetch channels
app.get('/channels', function(req, res) {
	  logger.debug('================ GET CHANNELS======================');
    logger.debug('End point : /channels');
    //logger.debug('peers : '+req.body.peers);// target peers list
    logger.debug('participatingPeer: ' + req.query.participatingPeer);
		var participatingPeer = req.query.participatingPeer;
		var token = req.body.token || req.query.token || req.headers['x-access-token'];
		jwt.verify(token, app.get('secret'), function(err, decoded) {
				if (err) {
						res.send({
								success: false,
								message: 'Failed to authenticate token.'
						});
				} else {
						logger.debug('User name : ' + decoded.username);
						logger.debug('Org name  : ' + decoded.orgName);
						var promise = query.getChannels(participatingPeer, decoded.username, decoded.orgName);
						promise.then(function(message) {
								res.send(message);
						});
				}
		});
});
