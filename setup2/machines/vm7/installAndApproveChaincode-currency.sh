export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/../vm0/crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer.amazonbiobank.mooo.com/msp/tlscacerts/tlsca.amazonbiobank.mooo.com-cert.pem
export PEER0_ORG7_CA=${PWD}/crypto-config/peerOrganizations/org7.amazonbiobank.mooo.com/peers/peer0.org7.amazonbiobank.mooo.com/tls/ca.crt
export FABRIC_CFG_PATH=${PWD}/../../artifacts/channel/config/


export CHANNEL_NAME=mychannel

setGlobalsForPeer0Org7() {
    export CORE_PEER_LOCALMSPID="Org7MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG7_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/crypto-config/peerOrganizations/org7.amazonbiobank.mooo.com/users/Admin@org7.amazonbiobank.mooo.com/msp
    export CORE_PEER_ADDRESS=localhost:7051

}

setGlobalsForPeer1Org7() {
    export CORE_PEER_LOCALMSPID="Org7MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG7_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/crypto-config/peerOrganizations/org7.amazonbiobank.mooo.com/users/Admin@org7.amazonbiobank.mooo.com/msp
    export CORE_PEER_ADDRESS=localhost:12051

}

presetup() {
    echo Vendoring Go dependencies ...
    pushd ./../../artifacts/src/currency-contract
    npm install
    popd
    echo Finished vendoring Go dependencies
}
# presetup

CHANNEL_NAME="mychannel"
CC_RUNTIME_LANGUAGE="node"
VERSION="1"
CC_SRC_PATH="./../../artifacts/src/currency-contract"
CC_NAME="currency"

packageChaincode() {
    rm -rf ${CC_NAME}.tar.gz
    setGlobalsForPeer0Org7
    peer lifecycle chaincode package ${CC_NAME}.tar.gz \
        --path ${CC_SRC_PATH} --lang ${CC_RUNTIME_LANGUAGE} \
        --label ${CC_NAME}_${VERSION}
    echo "===================== Chaincode is packaged on peer0.org7 ===================== "
}
# packageChaincode

installChaincode() {
    setGlobalsForPeer0Org7
    peer lifecycle chaincode install ${CC_NAME}.tar.gz
    echo "===================== Chaincode is installed on peer0.org7 ===================== "

}

# installChaincode

queryInstalled() {
    setGlobalsForPeer0Org7
    peer lifecycle chaincode queryinstalled >&log.txt

    cat log.txt
    PACKAGE_ID=$(sed -n "/${CC_NAME}_${VERSION}/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt)
    echo PackageID is ${PACKAGE_ID}
    echo "===================== Query installed successful on peer0.org7 on channel ===================== "
}

# queryInstalled

approveForMyOrg7() {
    setGlobalsForPeer0Org7

    peer lifecycle chaincode approveformyorg -o 10.4.0.168:10750 \
        --ordererTLSHostnameOverride orderer.amazonbiobank.mooo.com --tls $CORE_PEER_TLS_ENABLED \
        --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name ${CC_NAME} \
        --version ${VERSION} --init-required --package-id ${PACKAGE_ID} \
        --sequence ${VERSION}

    echo "===================== chaincode approved from org 3 ===================== "
}
# queryInstalled
# approveForMyOrg7

checkCommitReadyness() {

    setGlobalsForPeer0Org7
    peer lifecycle chaincode checkcommitreadiness --channelID $CHANNEL_NAME \
        --peerAddresses localhost:7051 --tlsRootCertFiles $PEER0_ORG7_CA \
        --name ${CC_NAME} --version ${VERSION} --sequence ${VERSION} --output json --init-required
    echo "===================== checking commit readyness from org 3 ===================== "
}

# checkCommitReadyness

packageChaincode
installChaincode
queryInstalled
approveForMyOrg7
checkCommitReadyness
