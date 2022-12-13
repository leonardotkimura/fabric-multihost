export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/../vm0/crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer.amazonbiobank.mooo.com/msp/tlscacerts/tlsca.amazonbiobank.mooo.com-cert.pem
export PEER1_ORG1_CA=${PWD}/crypto-config/peerOrganizations/org1.amazonbiobank.mooo.com/peers/peer1.org1.amazonbiobank.mooo.com/tls/ca.crt
export FABRIC_CFG_PATH=${PWD}/../../artifacts/channel/config/

export CHANNEL_NAME=mychannel

setGlobalsForPeer1Org1() {
    export CORE_PEER_LOCALMSPID="Org1MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_ORG1_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/../vm1/crypto-config/peerOrganizations/org1.amazonbiobank.mooo.com/users/Admin@org1.amazonbiobank.mooo.com/msp
    export CORE_PEER_ADDRESS=localhost:7051

}

fetchChannelBlock() {
    rm -rf ./channel-artifacts/*
    setGlobalsForPeer1Org1
    # Replace localhost with your orderer's vm IP address
    peer channel fetch 0 ./channel-artifacts/$CHANNEL_NAME.block -o 10.4.0.168:10750 \
        --ordererTLSHostnameOverride orderer.amazonbiobank.mooo.com \
        -c $CHANNEL_NAME --tls --cafile $ORDERER_CA
}

# fetchChannelBlock

joinChannel() {
    setGlobalsForPeer1Org1
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block


}

# joinChannel

updateAnchorPeers() {
    setGlobalsForPeer1Org1
    # Replace localhost with your orderer's vm IP address
    peer channel update -o 10.4.0.168:10750 --ordererTLSHostnameOverride orderer.amazonbiobank.mooo.com \
        -c $CHANNEL_NAME -f ./../../artifacts/channel/${CORE_PEER_LOCALMSPID}anchors.tx \
        --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

}

# updateAnchorPeers

fetchChannelBlock
joinChannel
# updateAnchorPeers
