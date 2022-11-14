export FABRIC_CA_CLIENT_HOME=${PWD}/../vm1/crypto-config/peerOrganizations/org1.amazonbiobank.mooo.com/

fabric-ca-client register --caname ca.org1.amazonbiobank.mooo.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/../vm1/create-certificate-with-ca/fabric-ca/org1/tls-cert.pem

mkdir -p crypto-config/peerOrganizations/org1.amazonbiobank.mooo.com/peers/peer1.org1.amazonbiobank.mooo.com

fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca.org1.amazonbiobank.mooo.com -M ${PWD}/crypto-config/peerOrganizations/org1.amazonbiobank.mooo.com/peers/peer1.org1.amazonbiobank.mooo.com/msp --csr.hosts peer1.org1.amazonbiobank.mooo.com --tls.certfiles ${PWD}/../vm1/create-certificate-with-ca/fabric-ca/org1/tls-cert.pem

cp ${PWD}/../vm1/crypto-config/peerOrganizations/org1.amazonbiobank.mooo.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/org1.amazonbiobank.mooo.com/peers/peer1.org1.amazonbiobank.mooo.com/msp/config.yaml

fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca.org1.amazonbiobank.mooo.com -M ${PWD}/crypto-config/peerOrganizations/org1.amazonbiobank.mooo.com/peers/peer1.org1.amazonbiobank.mooo.com/tls --enrollment.profile tls --csr.hosts peer1.org1.amazonbiobank.mooo.com --csr.hosts localhost --csr.hosts peer1.org1.amazonbiobank.duckdns.org --tls.certfiles ${PWD}/../vm1/create-certificate-with-ca/fabric-ca/org1/tls-cert.pem
cp ${PWD}/crypto-config/peerOrganizations/org1.amazonbiobank.mooo.com/peers/peer1.org1.amazonbiobank.mooo.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/org1.amazonbiobank.mooo.com/peers/peer1.org1.amazonbiobank.mooo.com/tls/ca.crt
cp ${PWD}/crypto-config/peerOrganizations/org1.amazonbiobank.mooo.com/peers/peer1.org1.amazonbiobank.mooo.com/tls/signcerts/* ${PWD}/crypto-config/peerOrganizations/org1.amazonbiobank.mooo.com/peers/peer1.org1.amazonbiobank.mooo.com/tls/server.crt
cp ${PWD}/crypto-config/peerOrganizations/org1.amazonbiobank.mooo.com/peers/peer1.org1.amazonbiobank.mooo.com/tls/keystore/* ${PWD}/crypto-config/peerOrganizations/org1.amazonbiobank.mooo.com/peers/peer1.org1.amazonbiobank.mooo.com/tls/server.key
