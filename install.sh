# to be executed on start

starttime=$(date +%s)

# Install application to the first peer
docker exec -it cli peer chaincode install -n postap -p github.com/chaincode -v v0.1 --peerAddresses peer0.org1.example.com:7051


# Install application to the second peer
docker exec -it cli peer chaincode install -n postap -p github.com/chaincode -v v0.1 --peerAddresses peer1.org1.example.com:7051

# Install application to the 3rd peer
docker exec -it cli peer chaincode install -n postap -p github.com/chaincode -v v0.1 --peerAddresses peer2.org1.example.com:7051

# Install application to the 4st
docker exec -it cli peer chaincode install -n postap -p github.com/chaincode -v v0.1 --peerAddresses peer3.org1.example.com:7051


# Instantiate ....

docker exec -it cli peer chaincode instantiate -o orderer0.example.com:7050 -C posta-channel -n postap github.com/chaincode -v v0.1 --peerAddresses peer0.org1.example.com:7051 -c '{"Args":["initLedger"]}' 

docker exec -it cli peer chaincode instantiate -o orderer0.example.com:7050 -C posta-channel -n postap github.com/chaincode -v v0.1 --peerAddresses peer1.org1.example.com:7051 -c '{"Args":["initLedger"]}'

docker exec -it cli peer chaincode instantiate -o orderer0.example.com:7050 -C posta-channel -n postap github.com/chaincode -v v0.1 --peerAddresses peer2.org1.example.com:7051 -c '{"Args":["initLedger"]}'

docker exec -it cli peer chaincode instantiate -o orderer0.example.com:7050 -C posta-channel -n postap github.com/chaincode -v v0.1 --peerAddresses peer3.org1.example.com:7051 -c '{"Args":["initLedger"]}'


printf "\nTotal execution time : $(($(date +%s) - starttime)) secs ...\n\n"
printf "\nFor init and test deployed chaincode run: ./test.sh \n\n"	