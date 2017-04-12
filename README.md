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

#### using cURL

##### 1. Enroll Users:

`curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -H "Postman-Token: 83d68175-4d03-0eb5-17bb-37d39ef54dd0" -d '{"username" : "binh", "orgName": "org2"}' "http://localhost:4000/users"`

##### 2. Create Channel

`curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -H "Postman-Token: 84a0c4bf-f902-b24e-8bda-38dda0bc4dae" -d '{
	"channelName":"mychannel",
	"orderer":"localhost:7050",
	"channelConfigPath":"../artifacts/channel/mychannel.tx",
	"username" : "binh",
    "orgName": "org1"
}' "http://localhost:4000/channels"`

##### 3. Join Channel

*Org1*

`curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -H "Postman-Token: bc385c8d-b4e9-ff6d-e1c7-84c7bd31d044" -d '{
	"orderer":"localhost:7050",
	"peers": ["localhost:7051","localhost:7056"],
	"username" : "binh",
    "orgName": "org1"
}' "http://localhost:4000/channels/mychannel/peers"
`

*Org2*

`curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -H "Postman-Token: bb8374ff-a2cc-afad-de73-a842139c1faa" -d '{
	"orderer":"localhost:7050",
	"peers": ["localhost:8051","localhost:8056"],
	"username" : "binh",
    "orgName": "org2"
}' "http://localhost:4000/channels/mychannel/peers"
`

##### 4. install chaincode

*Org1*

`curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -H "Postman-Token: d88b4f83-dedb-1262-189e-92b753367f49" -d '{
	"orderer":"localhost:7050",
	"peers": ["localhost:7051","localhost:7056"],
	"chaincodeName":"mycc",
	"chaincodePath":"github.com/example_cc",
	"chaincodeVersion":"v0",
	"username" : "binh",
    "orgName": "org1"
}' "http://localhost:4000/chaincodes"`

*Org2*

`curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -H "Postman-Token: 48d826f1-831a-1b11-b9ca-15156b470cb0" -d '{
	"orderer":"localhost:7050",
	"peers": ["localhost:8051","localhost:8056"],
	"chaincodeName":"mycc",
	"chaincodePath":"github.com/example_cc",
	"chaincodeVersion":"v0",
	"username" : "binh",
    "orgName": "org2"
}' "http://localhost:4000/chaincodes"`

##### 5. Instantiate chaincode
Instantiate chaincode on peer1 of Org1

`curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -H "Postman-Token: 40dce817-c5fb-7288-4620-9a667ed29831" -d '{
	"orderer":"localhost:7050",
	"peers": ["localhost:7051"],
	"chaincodeName":"mycc",
	"chaincodePath":"github.com/example_cc",
	"chaincodeVersion":"v0",
	"functionName":"init",
	"args":["a","100","b","200"],
	"username" : "binh",
    "orgName": "org1"
}' "http://localhost:4000/channels/mychannel/chaincodes"`

##### 6. Invoke chaincode

Invoke on chaincode on peer1 of Org1

`curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -H "Postman-Token: 40e6e183-3069-337f-7aed-a230373fa84c" -d '{
	"orderer":"localhost:7050",
	"peers": ["localhost:7051"],
	"chaincodeVersion":"v0",
	"functionName":"invoke",
	"args":["move","a","b","10"],
	"username" : "binh",
    "orgName": "org1"
}' "http://localhost:4000/channels/mychannel/chaincodes/mycc"`


##### 7. Query chaincode

Query on chaincode on peer1 of Org1

`curl -gs http://localhost:4000/channels/mychannel/chaincodes/mycc?args=[\"query\",\"b\"]&chaincodeVersion=v0`


-------------------------- OR -------------------------- 

#### script

Run the script **testAPIs.sh** after starting the network and app

```
./testAPIs.sh
```
