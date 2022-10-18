
# chmod -R 0755 ./crypto-config
# # Delete existing artifacts
# rm -rf ./crypto-config
# rm genesis.block channel2.tx
# rm -rf ../../channel-artifacts/*

#Generate Crypto artifactes for organizations
cryptogen generate --config=./crypto-config.yaml --output=./crypto-config/



# System channel
SYS_CHANNEL="channel1"

# channel name defaults to "channel2"
CHANNEL_NAME="channel1"

echo $CHANNEL_NAME

# Generate System Genesis block
configtxgen -profile OrdererGenesis -configPath . -channelID $SYS_CHANNEL  -outputBlock ./genesis_${CHANNEL_NAME}.block


# Generate channel configuration block
configtxgen -profile BasicChannel -configPath . -outputCreateChannelTx ./channel1.tx -channelID $CHANNEL_NAME

echo "#######    Generating anchor peer update for Org1MSP  ##########"
configtxgen -profile BasicChannel -configPath . -outputAnchorPeersUpdate ./Org1MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org1MSP

echo "#######    Generating anchor peer update for Org2MSP  ##########"
configtxgen -profile BasicChannel -configPath . -outputAnchorPeersUpdate ./Org2MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org2MSP

echo "#######    Generating anchor peer update for Org3MSP  ##########"
configtxgen -profile BasicChannel -configPath . -outputAnchorPeersUpdate ./Org3MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org3MSP