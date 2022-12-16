FIRST_TIME=false

# Deploy  all Docker containers
cd vm0
docker-compose up -d
cd -

cd vm1
docker-compose up -d
cd -

cd vm2
docker-compose up -d
cd -

cd vm3 
docker-compose up -d 
cd -



# wait for docker containers to deploy
if [ "$FIRST_TIME" = true ];
then
sleep 30
else
sleep 3
fi 


# create and join channels
cd vm1
./createChannel.sh
cd -

cd vm2
./joinChannel.sh
cd -

cd vm3
./joinChannel.sh
cd -



# deploy chaincodes
cd vm1
./deployChaincode-biobank.sh 
./deployChaincode-currency.sh
cd -

cd vm2
./installAndApproveChaincode-biobank.sh 
./installAndApproveChaincode-currency.sh
cd -

cd vm3
./installAndApproveChaincode-biobank.sh 
./installAndApproveChaincode-currency.sh
cd -

#commit chaincodes
docker exec -i cli bash < chaincode-commit.sh

# generate cpp
cd vm1/api-2.0/config
./generate-ccp.sh
cd -
