rm wallet/admin.id
cd ../../machines/vm3/crypto-config/peerOrganizations/org3.amazonbiobank.mooo.com/users/User1@org3.amazonbiobank.mooo.com/msp/keystore
filename=$(ls)
cd -

node createAdminId-org3.js $filename

cd ./currency-contract
node_modules/.bin/mocha functionalTests/AccountContract-biobank.test.js --grep="createUserAccount"
cd -