export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/../vm0/crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer.amazonbiobank.mooo.com/msp/tlscacerts/tlsca.amazonbiobank.mooo.com-cert.pem
export PEER2_ORG2_CA=${PWD}/crypto-config/peerOrganizations/org2.amazonbiobank.mooo.com/peers/peer2.org2.amazonbiobank.mooo.com/tls/ca.crt
export FABRIC_CFG_PATH=${PWD}/../../artifacts/channel/config/


export CHANNEL_NAME=mychannel

# setGlobalsForPeer0Org2() {
#     export CORE_PEER_LOCALMSPID="Org2MSP"
#     export CORE_PEER_TLS_ROOTCERT_FILE=$PEER2_ORG2_CA
#     export CORE_PEER_MSPCONFIGPATH=${PWD}/crypto-config/peerOrganizations/org2.amazonbiobank.mooo.com/users/Admin@org2.amazonbiobank.mooo.com/msp
#     export CORE_PEER_ADDRESS=localhost:11051

# }

setGlobalsForPeer2Org2() {
    export CORE_PEER_LOCALMSPID="Org2MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER2_ORG2_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/../vm2/crypto-config/peerOrganizations/org2.amazonbiobank.mooo.com/users/Admin@org2.amazonbiobank.mooo.com/msp
    export CORE_PEER_ADDRESS=localhost:7051

}

presetup() {
    echo Vendoring Go dependencies ...
    pushd ./../../artifacts/src/biobank-contract
    npm install
    popd
    echo Finished vendoring Go dependencies
}
# presetup

CHANNEL_NAME="mychannel"
CC_RUNTIME_LANGUAGE="node"
VERSION="1"
CC_SRC_PATH="./../../artifacts/src/biobank-contract"
CC_NAME="biobank"

packageChaincode() {
    rm -rf ${CC_NAME}.tar.gz
    setGlobalsForPeer2Org2
    peer lifecycle chaincode package ${CC_NAME}.tar.gz \
        --path ${CC_SRC_PATH} --lang ${CC_RUNTIME_LANGUAGE} \
        --label ${CC_NAME}_${VERSION}
    echo "===================== Chaincode is packaged on peer2.org2 ===================== "
}
# packageChaincode

installChaincode() {
    setGlobalsForPeer2Org2
    peer lifecycle chaincode install ${CC_NAME}.tar.gz
    echo "===================== Chaincode is installed on peer2.org2 ===================== "

}

# installChaincode

queryInstalled() {
    setGlobalsForPeer2Org2
    peer lifecycle chaincode queryinstalled >&log.txt

    cat log.txt
    PACKAGE_ID=$(sed -n "/${CC_NAME}_${VERSION}/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt)
    echo PackageID is ${PACKAGE_ID}
    echo "===================== Query installed successful on peer2.org2 on channel ===================== "
}

# queryInstalled

approveForMyOrg2() {
    setGlobalsForPeer2Org2

    peer lifecycle chaincode approveformyorg -o 10.4.0.168:10750 \
        --ordererTLSHostnameOverride orderer.amazonbiobank.mooo.com --tls $CORE_PEER_TLS_ENABLED \
        --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name ${CC_NAME} \
        --version ${VERSION} --init-required --package-id ${PACKAGE_ID} \
        --sequence ${VERSION}

    echo "===================== chaincode approved from org 1 ===================== "
}
# queryInstalled
# approveForMyOrg2

checkCommitReadyness() {

    setGlobalsForPeer2Org2
    peer lifecycle chaincode checkcommitreadiness --channelID $CHANNEL_NAME \
        --peerAddresses localhost:11051 --tlsRootCertFiles $PEER2_ORG2_CA \
        --name ${CC_NAME} --version ${VERSION} --sequence ${VERSION} --output json --init-required
    echo "===================== checking commit readyness from org 1 ===================== "
}

# checkCommitReadyness

# presetup

packageChaincode
installChaincode
# queryInstalled
# approveForMyOrg2
# checkCommitReadyness