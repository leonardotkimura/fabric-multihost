rm wallet/admin.id
node createAdminId.js $1

cd ./currency-contract
node_modules/.bin/mocha functionalTests/AccountContract-biobank.test.js --grep="createUserAccount"
cd -