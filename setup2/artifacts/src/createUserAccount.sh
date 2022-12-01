rm wallet/admin.id


cd ../../machines/vm1/crypto-config/peerOrganizations/org1.amazonbiobank.mooo.com/users/User1@org1.amazonbiobank.mooo.com/msp/keystore
filename=$(ls)
cd -

node createAdminId.js $filename

cd ./currency-contract
node_modules/.bin/mocha functionalTests/AccountContract-biobank.test.js --grep="createUserAccount"
cd -