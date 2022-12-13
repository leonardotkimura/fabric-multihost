rm wallet/admin.id

cd ../../machines/vm2/crypto-config/peerOrganizations/org2.amazonbiobank.mooo.com/users/User1@org2.amazonbiobank.mooo.com/msp/keystore
filename=$(ls)
cd -

node createAdminId-org2.js $filename

cd ./currency-contract
node_modules/.bin/mocha functionalTests/AccountContract-biobank.test.js --grep="createUserAccount"
cd -