#!/bin/bash 

starttime=$(date +%s)

echo 'POST Enroll on Org1 request ...'
echo
curl -X POST \
  http://localhost:4000/users \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/x-www-form-urlencoded' \
  -H 'postman-token: e4509811-2f66-7f57-25e8-d79abf4188b6' \
  -d 'username=sam&password=secret&orgName=org1'
echo
echo

echo 'POST Enroll on Org1 request ...'
echo
curl -X POST \
  http://localhost:4000/users \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/x-www-form-urlencoded' \
  -H 'postman-token: 56af030e-dae3-b6ff-6960-1b3af85baf7d' \
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
  -H 'postman-token: 2f369b2c-b867-2da8-6e9e-fb99698c116f' \
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
  -H 'postman-token: 54380c7f-eee9-fc9d-315c-37034ad40113' \
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
  -H 'postman-token: 99fb6301-0bc3-ac0e-800d-dd89338a8d54' \
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
  -H 'postman-token: 491135ff-82a6-aca6-a0cb-765cabd8e295' \
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
  -H 'postman-token: 41a0b539-8dd2-0587-c800-823a0ce02b28' \
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
  -H 'postman-token: 7ccc33bc-8e92-6c1e-a2d5-51c875d446e7' \
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
  -H 'postman-token: 5046837c-e0e5-36e5-60bf-e83f3a48863a' \
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
  -H 'postman-token: 65c53404-24ff-9724-476c-082d72bf8ea8' \
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
  -H 'postman-token: 22fcf6e0-ac1c-c638-24ed-4275a7261e85' \
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo'
echo
echo


echo 'GET query Transaction by TransactionID'
echo
curl -X GET http://localhost:4000/channels/mychannel/transactions/$TRX_ID?participatingPeer=peer1 \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'postman-token: 2b6976b3-829b-e4fb-9d97-62b54847162c' \
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
  -H 'postman-token: 4644efe9-24ae-7d69-e20a-4ee73885b259' \
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
  -H 'postman-token: b9a8776f-3039-1c21-f5bb-88d279810330' \
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
  -H 'postman-token: a712df6a-cfb0-7808-7ab4-8491de9b0d11' \
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
  -H 'postman-token: 3852f1fb-42dd-3dce-3149-d14a6bd8adf5' \
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
  -H 'postman-token: 09722f21-786d-70c8-035b-71d7da4f30bb' \
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo'
echo
echo


echo "Total execution time : $(($(date +%s)-starttime)) secs ..."
