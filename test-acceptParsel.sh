#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
# Exit on first error, print all commands.
set -e

# don't rewrite paths for Windows Git Bash users
export MSYS_NO_PATHCONV=1

starttime=$(date +%s)


for i in `seq 1 1000`;
        do
                echo $i
                docker exec -it cli peer chaincode invoke -o orderer0.example.com:7050 -n postap -c '{"Args":["acceptParsel","1","2","3","4"]}' -C posta-channel 
        done  

printf "\nTotal execution time : $(($(date +%s) - starttime)) secs ...\n\n"
	
