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
  -d 'username=sam&password=secret&orgName=org1'

```

*Org2*

```
curl -X POST \
  http://localhost:4000/users \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/x-www-form-urlencoded' \
  -d 'username=sam&password=secret&orgName=org2'
```

##### 2. Create Channel

```
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

```

##### 3. Join Channel

*Org1*

```
curl -X POST \
  http://localhost:4000/channels/mychannel/peers \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
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
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -d '{
        "peers": ["localhost:7051"],
        "chaincodeVersion":"v0",
        "functionName":"invoke",
        "args":["move","a","b","10"]
}'
```

**NOTE**: Save the output (TransactionID) of this command, The same can be used when querying transactions by ID

##### 7. Query chaincode

Query on chaincode on peer1 of Org1

```
curl -X GET \
  'http://localhost:4000/channels/mychannel/chaincodes/mycc?peer=peer1&args=%5B%22query%22%2C%22a%22%5D&chaincodeVersion=v0' \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
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
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo'
```

##### 9. Query Transaction by Transaction ID

**NOTE:** Use the transaction ID from any of the previous transactions

```
curl -X GET http://localhost:4000/channels/mychannel/transactions/<Use_transaction-ID>?participatingPeer=peer1 \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
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
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo'
```
##### 11. Query Channel Information

```
curl -X GET \
  'http://localhost:4000/channels/mychannel?participatingPeer=peer1' \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo'
```

##### 12. Query Installed chaincodes

```
curl -X GET \
  'http://localhost:4000/chaincodes?hostingPeer=peer1&installed=true' \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo'

```

##### 13. Query Instantiated chaincodes

```
curl -X GET \
  'http://localhost:4000/chaincodes?hostingPeer=peer1&installed=false' \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo'
```

##### 14. Query for all Channels

```
curl -X GET \
  'http://localhost:4000/channels?participatingPeer=peer1' \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'x-access-token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNhbSIsIm9yZ05hbWUiOiJvcmcxIiwiaWF0IjoxNDkyMzk3OTg5fQ.zMvr5AoksMgJr0yT42N_uy8KhD4d8j5qOfVWkpJfgXo'
```
-------------------------- OR -------------------------- 

#### script

Run the script **testAPIs.sh** after starting the network and app

```
./testAPIs.sh
```
**NOTE**: Script fails at queryBlockByHash
