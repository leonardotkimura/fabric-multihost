export FABRIC_CA_CLIENT_HOME=${PWD}/../vm2/crypto-config/peerOrganizations/org2.amazonbiobank.mooo.com/

fabric-ca-client register --caname ca.org2.amazonbiobank.mooo.com --id.name peer3 --id.secret peer3pw --id.type peer --tls.certfiles ${PWD}/../vm2/create-certificate-with-ca/fabric-ca/org2/tls-cert.pem

mkdir -p crypto-config/peerOrganizations/org2.amazonbiobank.mooo.com/peers/peer3.org2.amazonbiobank.mooo.com

fabric-ca-client enroll -u https://peer3:peer3pw@localhost:8054 --caname ca.org2.amazonbiobank.mooo.com -M ${PWD}/crypto-config/peerOrganizations/org2.amazonbiobank.mooo.com/peers/peer3.org2.amazonbiobank.mooo.com/msp --csr.hosts peer3.org2.amazonbiobank.mooo.com --tls.certfiles ${PWD}/../vm2/create-certificate-with-ca/fabric-ca/org2/tls-cert.pem

cp ${PWD}/../vm2/crypto-config/peerOrganizations/org2.amazonbiobank.mooo.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/org2.amazonbiobank.mooo.com/peers/peer3.org2.amazonbiobank.mooo.com/msp/config.yaml

fabric-ca-client enroll -u https://peer3:peer3pw@localhost:8054 --caname ca.org2.amazonbiobank.mooo.com -M ${PWD}/crypto-config/peerOrganizations/org2.amazonbiobank.mooo.com/peers/peer3.org2.amazonbiobank.mooo.com/tls --enrollment.profile tls --csr.hosts peer3.org2.amazonbiobank.mooo.com --csr.hosts localhost --csr.hosts peer3.org2.amazonbiobank.duckdns.org --tls.certfiles ${PWD}/../vm2/create-certificate-with-ca/fabric-ca/org2/tls-cert.pem
cp ${PWD}/crypto-config/peerOrganizations/org2.amazonbiobank.mooo.com/peers/peer3.org2.amazonbiobank.mooo.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/org2.amazonbiobank.mooo.com/peers/peer3.org2.amazonbiobank.mooo.com/tls/ca.crt
cp ${PWD}/crypto-config/peerOrganizations/org2.amazonbiobank.mooo.com/peers/peer3.org2.amazonbiobank.mooo.com/tls/signcerts/* ${PWD}/crypto-config/peerOrganizations/org2.amazonbiobank.mooo.com/peers/peer3.org2.amazonbiobank.mooo.com/tls/server.crt
cp ${PWD}/crypto-config/peerOrganizations/org2.amazonbiobank.mooo.com/peers/peer3.org2.amazonbiobank.mooo.com/tls/keystore/* ${PWD}/crypto-config/peerOrganizations/org2.amazonbiobank.mooo.com/peers/peer3.org2.amazonbiobank.mooo.com/tls/server.key
