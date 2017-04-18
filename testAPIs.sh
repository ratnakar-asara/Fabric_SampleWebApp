#!/bin/bash 

starttime=$(date +%s)

echo 'POST Enroll on Org1 request ...'
echo
curl -X POST \
  http://localhost:4000/users \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/x-www-form-urlencoded' \
  -d 'username=sam&password=secret&orgName=org1'
echo
echo

echo 'POST Enroll on Org1 request ...'
echo
curl -X POST \
  http://localhost:4000/users \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/x-www-form-urlencoded' \
  -d 'username=sam&password=secret&orgName=org2'
echo
echo

echo 'POST Create channel request ...'
echo
curl -X POST \
  http://localhost:4000/channels \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -d '{
	"channelName":"mychannel",
	"channelConfigPath":"../artifacts/channel/mychannel.tx"
}'
echo
echo


echo 'POST Join channel request ... on Org1'
echo
curl -X POST \
  http://localhost:4000/channels/mychannel/peers \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -d '{
	"peers": ["localhost:7051","localhost:7056"]
}'
echo
echo


echo 'POST Join channel request ... on Org2'
echo
curl -X POST \
  http://localhost:4000/channels/mychannel/peers \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImJpbmgiLCJvcmdOYW1lIjoib3JnMiIsImlhdCI6MTQ5MjM5OTcwNH0.iMDVFsE8viKCRwg_VuHuJN5-E1Va6Gem_3pblL1Wb0s' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImJpbmgiLCJvcmdOYW1lIjoib3JnMiIsImlhdCI6MTQ5MjM5OTcwNH0.iMDVFsE8viKCRwg_VuHuJN5-E1Va6Gem_3pblL1Wb0s' \
  -d '{
	"peers": ["localhost:8051","localhost:8056"]
}'
echo
echo


echo 'POST Install chaincode on Org1'
echo
curl -X POST \
  http://localhost:4000/chaincodes \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -d '{
	"peers": ["localhost:7051","localhost:7056"],
	"chaincodeName":"mycc",
	"chaincodePath":"github.com/example_cc",
	"chaincodeVersion":"v0"
}'
echo
echo


echo 'POST Install chaincode on Org2'
echo
curl -X POST \
  http://localhost:4000/chaincodes \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImJpbmgiLCJvcmdOYW1lIjoib3JnMiIsImlhdCI6MTQ5MjM5OTcwNH0.iMDVFsE8viKCRwg_VuHuJN5-E1Va6Gem_3pblL1Wb0s' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImJpbmgiLCJvcmdOYW1lIjoib3JnMiIsImlhdCI6MTQ5MjM5OTcwNH0.iMDVFsE8viKCRwg_VuHuJN5-E1Va6Gem_3pblL1Wb0s' \
  -d '{
	"peers": ["localhost:8051","localhost:8056"],
	"chaincodeName":"mycc",
	"chaincodePath":"github.com/example_cc",
	"chaincodeVersion":"v0"
}'
echo
echo

echo 'POST instantiate chaincode on peer1 of Org1'
echo
curl -X POST \
  http://localhost:4000/channels/mychannel/chaincodes \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -d '{
	"peers": ["localhost:7051"],
	"chaincodeName":"mycc",
	"chaincodePath":"github.com/example_cc",
	"chaincodeVersion":"v0",
	"functionName":"init",
	"args":["a","100","b","200"]
}'
echo
echo

echo 'POST invoke chaincode on peer1 of Org1'
echo
TRX_ID=$(curl -X POST \
  http://localhost:4000/channels/mychannel/chaincodes/mycc \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -d '{
	"peers": ["localhost:7051"],
	"chaincodeVersion":"v0",
	"functionName":"invoke",
	"args":["move","a","b","10"]
}')
echo "Transacton ID is $TRX_ID"
echo
echo

echo 'GET query chaincode on peer1 of Org1'
echo
curl -X GET \
  'http://localhost:4000/channels/mychannel/chaincodes/mycc?peer=peer1&args=%5B%22query%22%2C%22a%22%5D&chaincodeVersion=v0' \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo'
echo
echo

echo 'GET query Block by blockNumber'
echo
curl -X GET \
  'http://localhost:4000/channels/mychannel/blocks/1?participatingPeer=peer1' \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo'
echo
echo


echo 'GET query Transaction by TransactionID'
echo
curl -X GET http://localhost:4000/channels/mychannel/transactions/$TRX_ID?participatingPeer=peer1 \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo'
echo
echo

############################################################################
### TODO
### How to Read HASH value to get the Block details
############################################################################
echo 'GET query Block by Hash'
echo
hash='123'
curl -X GET \
  'http://localhost:4000/channels/mychannel/blocks?hash=$hash&participatingPeer=peer1' \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo'
echo
echo

echo 'GET query ChainInfo'
echo
curl -X GET \
  'http://localhost:4000/channels/mychannel?participatingPeer=peer1' \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo'
echo
echo

echo 'GET query Installed chaincodes'
echo
curl -X GET \
  'http://localhost:4000/chaincodes?hostingPeer=peer1&installed=true' \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo'
echo
echo

echo 'GET query Instantiated chaincodes'
echo
curl -X GET \
  'http://localhost:4000/chaincodes?hostingPeer=peer1&installed=false' \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo'
echo
echo

echo 'GET query Channels'
echo
curl -X GET \
  'http://localhost:4000/channels?participatingPeer=peer1' \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo'
echo
echo


echo "Total execution time : $(($(date +%s)-starttime)) secs ..."
