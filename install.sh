#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
# Exit on first error.
set -e

starttime=$(date +%s)

# # # Create the channel
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/Admin@org1.example.com/msp" peer0.org1.example.com peer channel create -o orderer0.example.com:7050 -c posta-channel -f /var/hyperledger/configs/channel.tx
# # # Join peer0.org1.example.com to the channel.
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/Admin@org1.example.com/msp" peer0.org1.example.com peer channel join -b posta-channel.block

# # # Join peer1.org1.example.com to the channel.
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/Admin@org1.example.com/msp" -e "CORE_PEER_ADDRESS=peer1.org1.example.com:7051" peer0.org1.example.com peer channel join -b posta-channel.block

# # # Join peer2.org1.example.com to the channel.
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/Admin@org1.example.com/msp" -e "CORE_PEER_ADDRESS=peer2.org1.example.com:7051" peer0.org1.example.com peer channel join -b posta-channel.block

# # # Join peer3.org1.example.com to the channel.
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/Admin@org1.example.com/msp" -e "CORE_PEER_ADDRESS=peer3.org1.example.com:7051" peer0.org1.example.com peer channel join -b posta-channel.block


# wait for Hyperledger Fabric to start
# incase of errors when running later commands, issue export FABRIC_START_TIMEOUT=<larger number>
export FABRIC_START_TIMEOUT=12
echo ${FABRIC_START_TIMEOUT}
sleep ${FABRIC_START_TIMEOUT}


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

#docker exec -it cli peer chaincode instantiate -o orderer0.example.com:7050 -C posta-channel -n postap github.com/chaincode -v v0.1 --peerAddresses peer2.org1.example.com:7051 -c '{"Args":["initLedger"]}'

#docker exec -it cli peer chaincode instantiate -o orderer0.example.com:7050 -C posta-channel -n postap github.com/chaincode -v v0.1 --peerAddresses peer3.org1.example.com:7051 -c '{"Args":["initLedger"]}'


printf "\nTotal execution time : $(($(date +%s) - starttime)) secs ...\n\n"
printf "\nFor init and test deployed chaincode run: ./test.sh \n\n"	