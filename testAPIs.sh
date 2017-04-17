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
curl -X POST \
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
}'
echo
echo

echo 'GET query chaincode on peer1 of Org1'
echo
curl -X GET \
  'http://localhost:4000/channels/mychannel/chaincodes/mycc?args=%5B%22query%22%2C%22a%22%5D&chaincodeVersion=v0' \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'postman-token: 6c2072c0-6dc3-2ed8-b6a5-29b8ef8269b0' \
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo'
echo
echo

echo "Total execution time : $(($(date +%s)-starttime)) secs ..."
