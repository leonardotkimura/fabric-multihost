rm wallet/admin.id
node createAdminId-org3.js $1

cd ./currency-contract
node_modules/.bin/mocha functionalTests/AccountContract-biobank.test.js --grep="createUserAccount"
cd -