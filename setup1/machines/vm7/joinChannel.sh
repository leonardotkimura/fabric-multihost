export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/../vm0/crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer.amazonbiobank.mooo.com/msp/tlscacerts/tlsca.amazonbiobank.mooo.com-cert.pem
export PEER2_ORG2_CA=${PWD}/crypto-config/peerOrganizations/org2.amazonbiobank.mooo.com/peers/peer2.org2.amazonbiobank.mooo.com/tls/ca.crt
export FABRIC_CFG_PATH=${PWD}/../../artifacts/channel/config/

export CHANNEL_NAME=mychannel

setGlobalsForPeer2Org2() {
    export CORE_PEER_LOCALMSPID="Org2MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER2_ORG2_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/../vm2/crypto-config/peerOrganizations/org2.amazonbiobank.mooo.com/users/Admin@org2.amazonbiobank.mooo.com/msp
    export CORE_PEER_ADDRESS=localhost:7051

}

fetchChannelBlock() {
    rm -rf ./channel-artifacts/*
    setGlobalsForPeer2Org2
    # Replace localhost with your orderer's vm IP address
    peer channel fetch 0 ./channel-artifacts/$CHANNEL_NAME.block -o 10.4.0.168:10750 \
        --ordererTLSHostnameOverride orderer.amazonbiobank.mooo.com \
        -c $CHANNEL_NAME --tls --cafile $ORDERER_CA
}

# fetchChannelBlock

joinChannel() {
    setGlobalsForPeer2Org2
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block


}

# joinChannel

updateAnchorPeers() {
    setGlobalsForPeer2Org2
    # Replace localhost with your orderer's vm IP address
    peer channel update -o 10.4.0.168:10750 --ordererTLSHostnameOverride orderer.amazonbiobank.mooo.com \
        -c $CHANNEL_NAME -f ./../../artifacts/channel/${CORE_PEER_LOCALMSPID}anchors.tx \
        --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

}

# updateAnchorPeers

fetchChannelBlock
joinChannel
# updateAnchorPeers
