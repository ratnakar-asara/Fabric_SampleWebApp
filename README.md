# REST Api impmentation for NodeSDK apis

### Clone this repo

```
git clone https://github.com/ratnakar-asara/RestAPIs4Nodesdk
```

### A script to spin the local network and installs node modules also start the app @ port 4000

```
cd RestAPIs4Nodesdk
./runApp.sh
```

You will see the below log when app started
```
info: ****************** SERVER STARTED ************************
info: **************  http://loclahost:4000  ******************
```

### How to execute the requests

#### using PostMan

Imort the following link in your PostMan 
https://www.getpostman.com/collections/c67f15e1e9da14b31ffd

	
-------------------------- OR -------------------------- 

#### using cURL from command line

##### 1. Enroll Users:
*Org1*

```
curl -X POST \
  http://localhost:4000/users \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/x-www-form-urlencoded' \
  -H 'postman-token: e4509811-2f66-7f57-25e8-d79abf4188b6' \
  -d 'username=sam&password=secret&orgName=org1'

```

*Org2*

```
curl -X POST \
  http://localhost:4000/users \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/x-www-form-urlencoded' \
  -H 'postman-token: 56af030e-dae3-b6ff-6960-1b3af85baf7d' \
  -d 'username=sam&password=secret&orgName=org2'
```

##### 2. Create Channel

```
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

```

##### 3. Join Channel

*Org1*

```
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

```

*Org2*

```
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

```

##### 4. install chaincode

*Org1*

```
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
```

*Org2*

```
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
```

##### 5. Instantiate chaincode
Instantiate chaincode on peer1 of Org1

```
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
```

##### 6. Invoke chaincode

Invoke on chaincode on peer1 of Org1

```
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
```

**NOTE**: Save the output of this commands , It is TransactionID can be used while fetching transactions by ID

##### 7. Query chaincode

Query on chaincode on peer1 of Org1

```
curl -X GET \
  'http://localhost:4000/channels/mychannel/chaincodes/mycc?peer=peer1&args=%5B%22query%22%2C%22a%22%5D&chaincodeVersion=v0' \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'postman-token: 65c53404-24ff-9724-476c-082d72bf8ea8' \
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo'
```

##### 8. Query Block by BlockNumber

Fetch Block details by Blocknumber

```
curl -X GET \
  'http://localhost:4000/channels/mychannel/blocks/1?participatingPeer=peer1' \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'postman-token: 22fcf6e0-ac1c-c638-24ed-4275a7261e85' \
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo'
```

##### 9. Query Transaction by Transaction ID

**NOTE:** Use the transaction ID from any of the previous transactions

```
curl -X GET http://localhost:4000/channels/mychannel/transactions/<Use_transaction-ID>?participatingPeer=peer1 \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'postman-token: 2b6976b3-829b-e4fb-9d97-62b54847162c' \
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo'
```

##### 10. Query Block by Hash

**NOTE:** Change the following command by including the Block hash value

```
curl -X GET \
  'http://localhost:4000/channels/mychannel/blocks?hash=<HASH_VALUE_HERE>&participatingPeer=peer1' \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'postman-token: 4644efe9-24ae-7d69-e20a-4ee73885b259' \
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo'
```
##### 11. Query Channel Information

```
curl -X GET \
  'http://localhost:4000/channels/mychannel?participatingPeer=peer1' \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'postman-token: b9a8776f-3039-1c21-f5bb-88d279810330' \
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo'
```

##### 12. Query Installed chaincodes

```
curl -X GET \
  'http://localhost:4000/chaincodes?hostingPeer=peer1&installed=true' \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'postman-token: a712df6a-cfb0-7808-7ab4-8491de9b0d11' \
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo'

```

##### 13. Query Instantiated chaincodes

```
curl -X GET \
  'http://localhost:4000/chaincodes?hostingPeer=peer1&installed=false' \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'postman-token: 3852f1fb-42dd-3dce-3149-d14a6bd8adf5' \
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo'
```

##### 14. Query for all Channels

```
curl -X GET \
  'http://localhost:4000/channels?participatingPeer=peer1' \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'postman-token: 09722f21-786d-70c8-035b-71d7da4f30bb' \
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo'
```
-------------------------- OR -------------------------- 

#### script

Run the script **testAPIs.sh** after starting the network and app

```
./testAPIs.sh
```
**NOTE**: Script fails at the API queryBlockByHash
