export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/etc/hyperledger/channel/crypto-config/peerOrganizations/org1.amazonbiobank.mooo.com/peers/peer0.org1.amazonbiobank.mooo.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/channel/crypto-config/peerOrganizations/org1.amazonbiobank.mooo.com/users/Admin@org1.amazonbiobank.mooo.com/msp
export CORE_PEER_ADDRESS=peer0.org1.amazonbiobank.mooo.com:7051
export CHANNEL_NAME="mychannel"
export CC_NAME="currency"
export ORDERER_CA=/etc/hyperledger/channel/crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer.amazonbiobank.mooo.com/msp/tlscacerts/tlsca.amazonbiobank.mooo.com-cert.pem
export VERSION="1"

 peer lifecycle chaincode commit -o orderer.amazonbiobank.mooo.com:10750 --ordererTLSHostnameOverride orderer.amazonbiobank.mooo.com \
        --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA \
        --channelID $CHANNEL_NAME --name ${CC_NAME} \
        --peerAddresses peer0.org1.amazonbiobank.mooo.com:7051 --tlsRootCertFiles /etc/hyperledger/channel/crypto-config/peerOrganizations/org1.amazonbiobank.mooo.com/peers/peer0.org1.amazonbiobank.mooo.com/tls/ca.crt \
        --peerAddresses peer0.org3.amazonbiobank.mooo.com:11051 --tlsRootCertFiles /etc/hyperledger/channel/crypto-config/peerOrganizations/org3.amazonbiobank.mooo.com/peers/peer0.org3.amazonbiobank.mooo.com/tls/ca.crt \
        --peerAddresses peer0.org2.amazonbiobank.mooo.com:9051 --tlsRootCertFiles /etc/hyperledger/channel/crypto-config/peerOrganizations/org2.amazonbiobank.mooo.com/peers/peer0.org2.amazonbiobank.mooo.com/tls/ca.crt \
        --version ${VERSION} --sequence ${VERSION} --init-required


peer chaincode invoke -o orderer.amazonbiobank.mooo.com:10750 \
        --ordererTLSHostnameOverride orderer.amazonbiobank.mooo.com \
        --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA \
        -C $CHANNEL_NAME -n ${CC_NAME} \
        --peerAddresses peer0.org1.amazonbiobank.mooo.com:7051 --tlsRootCertFiles /etc/hyperledger/channel/crypto-config/peerOrganizations/org1.amazonbiobank.mooo.com/peers/peer0.org1.amazonbiobank.mooo.com/tls/ca.crt \
        --peerAddresses peer0.org2.amazonbiobank.mooo.com:9051 --tlsRootCertFiles /etc/hyperledger/channel/crypto-config/peerOrganizations/org2.amazonbiobank.mooo.com/peers/peer0.org2.amazonbiobank.mooo.com/tls/ca.crt  \
         --peerAddresses peer0.org3.amazonbiobank.mooo.com:11051 --tlsRootCertFiles /etc/hyperledger/channel/crypto-config/peerOrganizations/org3.amazonbiobank.mooo.com/peers/peer0.org3.amazonbiobank.mooo.com/tls/ca.crt  \
        --isInit -c '{"Args":[]}'



export CC_NAME="biobank"

peer lifecycle chaincode commit -o orderer.amazonbiobank.mooo.com:10750 --ordererTLSHostnameOverride orderer.amazonbiobank.mooo.com \
        --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA \
        --channelID $CHANNEL_NAME --name ${CC_NAME} \
        --peerAddresses peer0.org1.amazonbiobank.mooo.com:7051 --tlsRootCertFiles /etc/hyperledger/channel/crypto-config/peerOrganizations/org1.amazonbiobank.mooo.com/peers/peer0.org1.amazonbiobank.mooo.com/tls/ca.crt \
        --peerAddresses peer0.org3.amazonbiobank.mooo.com:11051 --tlsRootCertFiles /etc/hyperledger/channel/crypto-config/peerOrganizations/org3.amazonbiobank.mooo.com/peers/peer0.org3.amazonbiobank.mooo.com/tls/ca.crt \
        --peerAddresses peer0.org2.amazonbiobank.mooo.com:9051 --tlsRootCertFiles /etc/hyperledger/channel/crypto-config/peerOrganizations/org2.amazonbiobank.mooo.com/peers/peer0.org2.amazonbiobank.mooo.com/tls/ca.crt \
        --version ${VERSION} --sequence ${VERSION} --init-required


peer chaincode invoke -o orderer.amazonbiobank.mooo.com:10750 \
        --ordererTLSHostnameOverride orderer.amazonbiobank.mooo.com \
        --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA \
        -C $CHANNEL_NAME -n ${CC_NAME} \
        --peerAddresses peer0.org1.amazonbiobank.mooo.com:7051 --tlsRootCertFiles /etc/hyperledger/channel/crypto-config/peerOrganizations/org1.amazonbiobank.mooo.com/peers/peer0.org1.amazonbiobank.mooo.com/tls/ca.crt \
        --peerAddresses peer0.org2.amazonbiobank.mooo.com:9051 --tlsRootCertFiles /etc/hyperledger/channel/crypto-config/peerOrganizations/org2.amazonbiobank.mooo.com/peers/peer0.org2.amazonbiobank.mooo.com/tls/ca.crt  \
         --peerAddresses peer0.org3.amazonbiobank.mooo.com:11051 --tlsRootCertFiles /etc/hyperledger/channel/crypto-config/peerOrganizations/org3.amazonbiobank.mooo.com/peers/peer0.org3.amazonbiobank.mooo.com/tls/ca.crt  \
        --isInit -c '{"Args":[]}'