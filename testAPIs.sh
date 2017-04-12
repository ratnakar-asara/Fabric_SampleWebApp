#!/bin/bash 
starttime=$(date +%s)

echo 'POST Create channel request ...'
echo
curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -H "Postman-Token: 3cadca26-05c1-e0d1-d894-f3900fdafa66" -d '{"channelName":"mychannel","orderer":"localhost:7050","channelConfigPath":"../artifacts/channel/mychannel.tx","username" : "binh","orgName": "org1"}' "http://localhost:4000/channels"
echo
echo


echo 'POST Join channel request ... on Org1'
echo
curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -H "Postman-Token: f18f061e-bf65-4f27-b521-5bc980f53cf2" -d '{"orderer":"localhost:7050","peers": ["localhost:7051","localhost:7056"],"username" : "binh","orgName": "org1"}' "http://localhost:4000/channels/mychannel/peers"
echo
echo


echo 'POST Join channel request ... on Org2'
echo
curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -H "Postman-Token: f18f061e-bf65-4f27-b521-5bc980f53cf2" -d '{"orderer":"localhost:7050","peers": ["localhost:8051","localhost:8056"],"username" : "binh","orgName": "org2"}' "http://localhost:4000/channels/mychannel/peers"

echo
echo


echo 'POST Install chaincode on Org1'
echo
curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -H "Postman-Token: 7d921d28-aa2b-4d50-f278-9c733fff5e80" -d '{"orderer":"localhost:7050","peers": ["localhost:7051","localhost:7056"],"chaincodeName":"mycc","chaincodePath":"github.com/example_cc","chaincodeVersion":"v0","username" : "binh","orgName": "org1"}' "http://localhost:4000/chaincodes"

echo
echo


echo 'POST Install chaincode on Org2'
echo
curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -H "Postman-Token: 7d921d28-aa2b-4d50-f278-9c733fff5e80" -d '{"orderer":"localhost:7050","peers": ["localhost:8051","localhost:8056"],"chaincodeName":"mycc","chaincodePath":"github.com/example_cc","chaincodeVersion":"v0","username" : "binh","orgName": "org2"}' "http://localhost:4000/chaincodes"

echo
echo

echo 'POST instantiate chaincode on peer1 of Org1'
echo
curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -H "Postman-Token: 4053dc7d-33fb-1576-0295-36a88ee97b6d" -d '{"orderer":"localhost:7050","peers": ["localhost:7051"],"chaincodeName":"mycc","chaincodePath":"github.com/example_cc","chaincodeVersion":"v0","functionName":"init","args":["a","100","b","200"],"username" : "binh","orgName": "org1"}' "http://localhost:4000/channels/mychannel/chaincodes"
echo
echo

echo 'POST invoke chaincode on peer1 of Org1'
echo
curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -H "Postman-Token: 642f3b93-b265-e71b-6f0b-67c996e04e7b" -d '{"orderer":"localhost:7050","peers":["localhost:7051"],"chaincodeVersion":"v0","functionName":"invoke","args":["move","a","b","10"],"username" : "binh","orgName": "org1"}' "http://localhost:4000/channels/mychannel/chaincodes/mycc"
echo
echo

echo 'GET query chaincode on peer1 of Org1'
echo
OUTPUT=$(curl -gs http://localhost:4000/channels/mychannel/chaincodes/mycc?args=[\"query\",\"b\"]&chaincodeVersion=v0)
echo $OUTPUT
echo
echo

echo "Total execution time : $(($(date +%s)-starttime)) secs ..."
