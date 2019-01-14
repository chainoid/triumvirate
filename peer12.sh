docker run --rm -it \
 --network="posta-net" \
 --link orderer0.example.com:orderer0.example.com \
 --link orderer1.example.com:orderer1.example.com \
 --link orderer2.example.com:orderer2.example.com \
 --name peer2.org1.example.com -p 11051:7051 -p 11053:7053 \
 -e CORE_PEER_ADDRESSAUTODETECT=true \
 -e CORE_PEER_CHAINCODELISTENADDRESS=peer2.org1.example.com:7052 \
 -e CORE_VM_ENDPOINT=unix:///host/var/run/docker.sock \
 -e CORE_LOGGING_LEVEL=INFO \
 -e CORE_PEER_NETWORKID=peer1.org1.example.com \
 -e CORE_NEXT=true \
 -e CORE_PEER_ENDORSER_ENABLED=true \
 -e CORE_PEER_ID=peer1.org1.example.com \
 -e CORE_PEER_PROFILE_ENABLED=true \
 -e CORE_PEER_COMMITTER_LEDGER_ORDERER=orderer.example.com:7050 \
 -e CORE_PEER_GOSSIP_ORGLEADER=false \
 -e CORE_PEER_GOSSIP_EXTERNALENDPOINT=peer2.org1.example.com:7051 \
 -e CORE_PEER_GOSSIP_IGNORESECURITY=true \
 -e CORE_PEER_LOCALMSPID=Org1MSP \
 -e CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=posta-net \
 -e CORE_PEER_GOSSIP_BOOTSTRAP=peer0.org1.example.com:7051 \
 -e CORE_PEER_GOSSIP_USELEADERELECTION=true \
 -e CORE_PEER_TLS_ENABLED=false -v /var/run/:/host/var/run/ \
 -v $(pwd)/crypto-config/peerOrganizations/org1.example.com/peers/peer2.org1.example.com/msp:/etc/hyperledger/fabric/msp \
 -v /var/hyperledger/peer12:/var/hyperledger/production \
 -w /opt/gopath/src/github.com/hyperledger/fabric/peer  hyperledger/fabric-peer peer node start \
 

