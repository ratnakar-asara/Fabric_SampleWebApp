/**
 * Copyright 2017 IBM All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

// This is an end-to-end test that focuses on exercising all parts of the fabric APIs
// in a happy-path scenario
'use strict';

var path = require('path');
var fs = require('fs');
var util = require('util');

var hfc = require('fabric-client');
var utils = require('fabric-client/lib/utils.js');
var Peer = require('fabric-client/lib/Peer.js');
var EventHub = require('fabric-client/lib/EventHub.js');

var config = require('../config.json')
var helper = require('./helper.js');
var logger = helper.getLogger('invoke-chaincode');
var tx_id = null;
var nonce = null;
var adminUser = null;
var queryChaincode = function (peers, channelName, chaincodeName, chaincodeVersion, functionName, args, username, org){

			helper.setupChaincodeDeploy();
			var chain = helper.getChainForOrg(org);
			//helper.setupOrderer(orderer);
			var targets = helper.getTargets(peers, org);
			helper.setupPeers(chain, peers, targets);
			/*for(var index in targets) {
				chain.addPeer(targets[index]);
			}*/

	   return helper.getAdminUser(org)
	.then((member) => {
	  adminUser = member;

		nonce = utils.getNonce();
		tx_id = chain.buildTransactionID(nonce, adminUser);

		// send query
		var request = {
			targets : targets,
			chaincodeId: chaincodeName,
			//chaincodeVersion: chaincodeVersion,
			chainId: channelName,
			txId: tx_id,
			nonce: nonce,
			fcn: functionName,
			args: helper.getArgs(args)
		};
		return chain.queryByChaincode(request);
	},
	(err) => {
		logger.info('Failed to get submitter \'admin\'');
		return 'Failed to get submitter \'admin\'. Error: ' + err.stack ? err.stack : err ;
	}).then((response_payloads) => {
		if (response_payloads) {
			for(let i = 0; i < response_payloads.length; i++) {
				logger.info('User b now has '+response_payloads[i].toString('utf8')+' after the move')
				return 'User b now has '+response_payloads[i].toString('utf8')+' after the move';
			}
		} else {
			logger.error('response_payloads is null');
			return 'response_payloads is null';
		}
	},
	(err) => {
		logger.error('Failed to send query due to error: ' + err.stack ? err.stack : err);
		return 'Failed to send query due to error: ' + err.stack ? err.stack : err;
	}).catch((err) => {
		logger.error('Failed to end to end test with error:' + err.stack ? err.stack : err);
		return 'Failed to end to end test with error:' + err.stack ? err.stack : err;
	});
}
exports.queryChaincode = queryChaincode;
