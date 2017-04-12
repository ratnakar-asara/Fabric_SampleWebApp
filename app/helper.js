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
'use strict';

var log4js = require('log4js');
var logger = log4js.getLogger('Helper');

var path = require('path');
var util = require('util');
var fs = require('fs');
var User = require('fabric-client/lib/User.js');
var utils = require('fabric-client/lib/utils.js');
var Orderer = require('fabric-client/lib/Orderer.js');
var Peer = require('fabric-client/lib/Peer.js');
var copService = require('fabric-ca-client/lib/FabricCAClientImpl.js');

var config = require('../config.json');
var hfc = require('fabric-client');
hfc.addConfigFile(path.join(__dirname, 'network-config.json'));
var ORGS = hfc.getConfigSetting('network-config');

logger.setLevel('DEBUG');
exports.hfc = hfc;

var client1 = new hfc();
var chain1 = client1.newChain(config.channelName);

var client2 = new hfc();
var chain2 = client2.newChain(config.channelName);

exports.client1 = client1;
exports.client1 = client2;

exports.chain1 = chain1;
exports.chain2 = chain2;
// need to enroll it with CA server
var caClient;

/****************************************************************************/
//TODO: Remove this before comitting the code
var print = function(message) {
	logger.debug('=============================================================');
	logger.debug(message);
	logger.debug('=============================================================');
}
exports.print = print;
/****************************************************************************/

var addOrderer = function (chain, orderer){
	chain.addOrderer(
		getOrderer('grpcs://' + orderer)
	);
}
var setupOrderer = function(orderer) {
	let chains = [chain1, chain2];
chains.forEach(function(chain){
	if (chain.getOrderers().length === 0) {
		addOrderer(chain, orderer);
	} else {
		var ordererList = chain.getOrderers();
		let found = false;
		for (let key in ordererList){
			if (ordererList[key]._endpoint.addr === orderer) {
				found = true;
			}
		}
		if (!found){
			addOrderer(orderer);
		}
	}
});
}

var getChainForOrg = function(orgName) {
	if (orgName ===  config.orgsList[0]) {
		return chain1;
	} else if (orgName === config.orgsList[1]){
		return chain2;
	}
}

var clientForOrg = function(orgName) {
			if (orgName ===  config.orgsList[0]) {
				return client1;
			} else if (orgName === config.orgsList[1]){
				return client2;
			}
}

var getTargets = function(peers, org) {
	var targets = [];
	print(peers);
	for (let index in peers) {
		for (let key in ORGS[org]) {
			if (ORGS[org].hasOwnProperty(key)) {
				//FIXME: Can we think a better solution here ?
				if (key.indexOf('peer') === 0 && ORGS[org][key]["requests"] === 'grpcs://' + peers[index]) {
					let data = fs.readFileSync(path.join(__dirname, ORGS[org][key]['tls_cacerts']));
					targets.push(
						new Peer(
							'grpcs://' + peers[index], {
								pem: Buffer.from(data).toString(),
								'ssl-target-name-override': ORGS[org][key]['server-hostname']
							}
						)
					);
				}
			}
		}
	}
	return targets;
}


var enrollUser = function(username, orgName) {
	var member = null;
	var client = clientForOrg(orgName);
	return hfc.newDefaultKeyValueStore({
		path: getKeyStoreForOrg(orgName)
	}).then((store) => {
		client.setUserContext(null, true);
		client.setStateStore(store);
		var users = config.users;
		return getAdminUser(orgName);
	}).then((admin) => {
		return client.getUserContext(username)
			.then((user) => {
				//FIXME: Loading admin instead of user??
				if (user && user.isEnrolled()) {
					logger.info('Successfully loaded ' + username + ' from persistence');
					return user;
				} else {
					setCaClient(orgName);
					return caClient.register({
						enrollmentID: username,
						affiliation: orgName
					}, admin).then((secret) => {
						logger.info('Successfully registered user \"' + username + '\"');
						return caClient.enroll({
							enrollmentID: username,
							enrollmentSecret: secret
						});
					}).then((enrollment) => {
						logger.info('Successfully enrolled user \'' + username + '\'');
						member = new User(username, client);
						return member.setEnrollment(enrollment.key, enrollment.certificate, getMspID(orgName));
					}).then(() => {
						return client.setUserContext(member);
					});
				}
			}).then(() => {
				return true;
			}).catch((err) => {
				logger.error('Failed to enroll and register user. Error: ' + err.stack ? err.stack : err);
				//throw new Error('Failed to obtain an enrolled user');
				return false;
			});
	});
}

var getMspID = function(orgName) {
	print('Msp ID : '+ORGS[orgName].mspid);
	return ORGS[orgName].mspid;
}

var setCaClient = function(userOrg) {
	var caUrl = ORGS[userOrg].ca;
	caClient = new copService(caUrl);
}
var getUser = function(username, userOrg) {
	return client.getUserContext(username)
		.then((user) => {
			logger.info('Successfully loaded member from persistence');
			return user;
		});
}

var getAdminUser = function(userOrg) {
	var users = config.users;
	var username = users[0].username;
	var password = users[0].secret;
	var member;
	var client = clientForOrg(userOrg);
	return hfc.newDefaultKeyValueStore({
		path: getKeyStoreForOrg(getOrgName(userOrg))
	}).then((store) => {
		client.setStateStore(store);
		return client.getUserContext(username)
		.then((user) => {
			if (user && user.isEnrolled()) {
				logger.info('Successfully loaded member from persistence');
				return user;
			} else {
				setCaClient(userOrg);
				// need to enroll it with CA server
				return caClient.enroll({
					enrollmentID: username,
					enrollmentSecret: password
				}).then((enrollment) => {
					logger.info('Successfully enrolled user \'' + username + '\'');
					member = new User(username, client);
					return member.setEnrollment(enrollment.key, enrollment.certificate, getMspID(userOrg));
				}).then(() => {
					return client.setUserContext(member);
				}).then(() => {
					return member;
				}).catch((err) => {
					logger.error('Failed to enroll and persist user. Error: ' + err.stack ? err.stack : err);
					return null;
					//throw new Error('Failed to obtain an enrolled user');
				});
			}
		});
	});
};

var setupChaincodeDeploy = function() {
	process.env.GOPATH = path.join(__dirname, config.GOPATH);
};

var getLogger = function(moduleName) {
	var logger = log4js.getLogger(moduleName);
	logger.setLevel('DEBUG');
	return logger;
}
var getOrgName = function(org) {
	print('Org name : '+ORGS[org].name);
	return ORGS[org].name;
}

var getOrderer = function(orderer) {
	var caRootsPath = ORGS.orderer.tls_cacerts;
	let data = fs.readFileSync(path.join(__dirname, caRootsPath));
	let caroots = Buffer.from(data).toString();
	return new Orderer(
		orderer, {
			'pem': caroots,
			'ssl-target-name-override': ORGS.orderer['server-hostname']
		}
	)
}

var getKeyStoreForOrg = function(org) {
	return config.keyValueStore + '_' + org;
};


var getArgs = function(chaincodeArgs) {
	var args = [];
	for (var i = 0; i < chaincodeArgs.length; i++) {
		args.push(chaincodeArgs[i]);
	}
	return args;
};

exports.getAdminUser = getAdminUser;
exports.getArgs = getArgs;
exports.getKeyStoreForOrg = getKeyStoreForOrg;
exports.getOrgName = getOrgName;
exports.getLogger = getLogger;
exports.setupChaincodeDeploy = setupChaincodeDeploy;
exports.enrollUser = enrollUser
exports.getMspID = getMspID;
exports.getUser = getUser;
exports.ORGS = ORGS;
exports.setupOrderer = setupOrderer;
exports.getTargets = getTargets;
exports.getChainForOrg = getChainForOrg;
exports.clientForOrg = clientForOrg;
