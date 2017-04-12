var express = require('express');
var session = require('express-session');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var http = require('http');
var app = express();
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

app.use(cookieParser());
//app.use(session({ secret: 'lostmydata', resave: true, saveUninitialized: true }));

app.options('*', cors());
app.use(cors());
//support parsing of application/json type post data
app.use(bodyParser.json());

//support parsing of application/x-www-form-urlencoded post data
app.use(bodyParser.urlencoded({ extended: false }));

var logger = new (winston.Logger)({
	level: 'debug',
	transports: [
		new (winston.transports.Console)({ colorize: true }),
	]
});

// *******************************************************
//  Start the server
// *******************************************************
var server = http.createServer(app).listen(port, function () { });
logger.info('****************** SERVER STARTED ************************');
logger.info('**************  http://'+host+':'+port+'  ******************');
server.timeout = 240000;

//SetupNetwork
/*helper.setupPeerForOrg('org1');
helper.setupPeerForOrg('org2')*/

/*var targets = helper.getTargets(['localhost:7051','localhost:7056'],'org1');
helper.print(targets);
targets = helper.getTargets(['localhost:8051','localhost:8056'],'org2');
helper.print(targets);*/
//helper.setupOrderer('localhost:7050');
//helper.setupOrderer('localhost:7050');
/*app.get('/', function(req, res) {
    logger.info('app started');
    res.send('app started');
});*/

/**
 Register and enroll user
*/
app.post('/users', function(req, res) {
	  logger.debug('End point : /users');
    logger.debug('User name : ' +req.body.username);
    logger.debug('Org name  : ' +req.body.orgName);
    //var promise = helper.enrollUser(req.body.username, req.body.orgName);
		var promise = helper.getAdminUser(req.body.orgName);
		promise.then(function (value){
			 //if (value === true){
			 if (value != null){
				res.send('Successfully enrolled user \"'+req.body.username+'\"');
			 } else {
				res.send('Failed to enroll and register user "'+req.body.username+'"');
			 }
		 });
});
/*
  Channel creation
*/
app.post('/channels', function(req, res) {
	  logger.debug('End point : /channels');
		logger.debug('Channel name : ' +req.body.channelName);
		logger.debug('orderer : '+req.body.orderer); // grpcs://localhost:7050,
		logger.debug('channelConfigPath : '+req.body.channelConfigPath);//../artifacts/channel/mychannel.tx
		logger.debug('User name : ' +req.body.username);
		logger.debug('Org name  : ' +req.body.orgName);
    var promise = channels.createChannel(req.body.channelName, req.body.orderer, req.body.channelConfigPath, req.body.username, req.body.orgName);
		promise.then(function (message){
			res.send(message);
	  });
});

/*
  Join- channel on peers
*/
app.post('/channels/:channelName/peers', function(req, res) {
	  logger.debug('End point : /channels/'+req.params.channelName+'/peers');
		logger.debug('orderer : '+req.body.orderer); // grpcs://localhost:7050,
		logger.debug('peers : '+req.body.peers);// target peers list
		logger.debug('User name : ' +req.body.username);
		logger.debug('Org name  : ' +req.body.orgName);
		//res.send('received your request . will process it soon');
    var promise = join.joinChannel(req.params.channelName, req.body.orderer, req.body.peers, req.body.username, req.body.orgName);
		promise.then(function (message){
			res.send(message);
	  });
});


/*
  Install chaincode on target peers
*/
app.post('/chaincodes', function(req, res) {
	  logger.debug('End point : /channels');
		logger.debug('peers : '+req.body.peers);// target peers list
		logger.debug('chaincodeName : ' +req.body.chaincodeName);
		//TODO: should we download chaincode if it is http URL ?
		logger.debug('chaincodePath  : ' +req.body.chaincodePath);
		logger.debug('chaincodeVersion  : ' +req.body.chaincodeVersion);
		logger.debug('User name : ' +req.body.username);
		logger.debug('Org name  : ' +req.body.orgName);
		//res.send('received your request . will process it soon');
    var promise = install.installChaincode(req.body.orderer, req.body.peers, req.body.chaincodeName, req.body.chaincodePath, req.body.chaincodeVersion, req.body.username, req.body.orgName);
		promise.then(function (message){
			res.send(message);
	  });
});

/*
  instantiate chaincode on target peers
*/
app.post('/channels/:channelName/chaincodes', function(req, res) {
	  logger.debug('End point : /channels');
		logger.debug('peers : '+req.body.peers);// target peers list
		logger.debug('chaincodeName : ' +req.body.chaincodeName);
		//TODO: should we download chaincode if it is http URL ?
		logger.debug('chaincodePath  : ' +req.body.chaincodePath);
		logger.debug('chaincodeVersion  : ' +req.body.chaincodeVersion);
		logger.debug('User name : ' +req.body.username);
		logger.debug('Org name  : ' +req.body.orgName);
		//res.send('received your request . will process it soon');
    var promise = instantiate.instantiateChaincode(req.body.orderer, req.body.peers, req.params.channelName, req.body.chaincodeName, req.body.chaincodePath, req.body.chaincodeVersion, req.body.functionName, req.body.args, req.body.username, req.body.orgName);
		promise.then(function (message){
			res.send(message);
	  });
});

/*
  invoke transaction on chaincode on target peers
*/
app.post('/channels/:channelName/chaincodes/:chaincodeName', function(req, res) {
	  logger.debug('End point : /channels');
		logger.debug('peers : '+req.body.peers);// target peers list
		logger.debug('chaincodeName : ' +req.params.chaincodeName);

		logger.debug('Args : ' +req.body.args);
		//logger.debug('chaincodeVersion  : ' +req.body.chaincodeVersion);
		logger.debug('User name : ' +req.body.username);
		logger.debug('Org name  : ' +req.body.orgName);
		//res.send('received your request . will process it soon');
		let promise = null;
		let functionName = config.invokeQueryFcnName;

		promise = invoke.invokeChaincode(req.body.orderer, req.body.peers, req.params.channelName, req.params.chaincodeName, req.body.chaincodeVersion, functionName, req.body.args, req.body.username, req.body.orgName);
		/*if (req.query.functionName == undefined || req.query.functionName == ""){
			logger.debug('functionName : ' +req.body.functionName);
			promise = invoke.invokeChaincode(req.body.orderer, req.body.peers, req.params.channelName, req.params.chaincodeName, req.body.chaincodeVersion, req.body.functionName, req.body.args, req.body.username, req.body.orgName);
		} else {
			logger.debug('functionName : ' +req.query.functionName);
      promise = query.queryChaincode(req.body.peers, req.params.channelName, req.params.chaincodeName, req.body.chaincodeVersion, req.query.functionName, req.body.args, req.body.username, req.body.orgName);
		}*/

		promise.then(function (message){
			res.send(message);
	  });
});

/*
  Query on chaincode on target peers
*/
app.get('/channels/:channelName/chaincodes/:chaincodeName', function(req, res) {
	  logger.debug('End point : /channels');
		//logger.debug('peers : '+req.body.peers);// target peers list
		logger.debug('channelName : ' +req.params.channelName);
		logger.debug('chaincodeName : ' +req.params.chaincodeName);
		//logger.debug('chaincodeVersion  : ' +req.body.chaincodeVersion);

		let functionName = config.invokeQueryFcnName;
		//FIXME: HOW DO WE GET THESE DETAILS in GET ?
		let peers = ['localhost:7051'];
		let chaincodeVersion = 'v0';
		let username = 'binh';
		let orgName = 'org1'

		let args = req.query.args;
		console.log(args);
		args = args.replace(/'/g, '"');
		args = JSON.parse(args);
    var promise = query.queryChaincode(peers, req.params.channelName, req.params.chaincodeName, chaincodeVersion, functionName, args, username, orgName);
		promise.then(function (message){
			res.send(message);
	  });
});
