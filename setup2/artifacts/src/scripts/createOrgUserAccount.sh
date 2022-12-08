ORG=$1

rm ../wallet/admin.id


cd ../../../machines/vm${ORG}/crypto-config/peerOrganizations/org${ORG}.amazonbiobank.mooo.com/users/User1@org${ORG}.amazonbiobank.mooo.com/msp/keystore
filename=$(ls)
cd -

node createOrgAdminId.js $filename $ORG

cd ../currency-contract
node_modules/.bin/mocha functionalTests/AccountContract-biobank.test.js --grep="createUserAccount"
cd -