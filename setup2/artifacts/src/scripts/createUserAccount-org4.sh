rm ../wallet/admin.id
cd ../../../machines/vm4/crypto-config/peerOrganizations/org4.amazonbiobank.mooo.com/users/User1@org4.amazonbiobank.mooo.com/msp/keystore
filename=$(ls)
cd -

node createAdminId-org4.js $filename

cd ../currency-contract
node_modules/.bin/mocha functionalTests/AccountContract-biobank.test.js --grep="createUserAccount"
cd -