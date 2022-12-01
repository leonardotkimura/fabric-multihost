createcertificatesForOrg9() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p ../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/
  export FABRIC_CA_CLIENT_HOME=${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/

  fabric-ca-client enroll -u https://admin:adminpw@localhost:16054 --caname ca.org9.amazonbiobank.mooo.com --tls.certfiles ${PWD}/fabric-ca/org9/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-16054-ca-org9-amazonbiobank-mooo-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-16054-ca-org9-amazonbiobank-mooo-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-16054-ca-org9-amazonbiobank-mooo-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-16054-ca-org9-amazonbiobank-mooo-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/msp/config.yaml

  echo
  echo "Register peer0"
  echo
  fabric-ca-client register --caname ca.org9.amazonbiobank.mooo.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/org9/tls-cert.pem

  # echo
  # echo "Register peer1"
  # echo
  # fabric-ca-client register --caname ca.org9.amazonbiobank.mooo.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/org9/tls-cert.pem

  echo
  echo "Register user"
  echo
  fabric-ca-client register --caname ca.org9.amazonbiobank.mooo.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca/org9/tls-cert.pem

  echo
  echo "Register the org admin"
  echo
  fabric-ca-client register --caname ca.org9.amazonbiobank.mooo.com --id.name org9admin --id.secret org9adminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/org9/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/peers

  # -----------------------------------------------------------------------------------
  #  Peer 0
  mkdir -p ../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/peers/peer0.org9.amazonbiobank.mooo.com

  echo
  echo "## Generate the peer0 msp"
  echo
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:16054 --caname ca.org9.amazonbiobank.mooo.com -M ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/peers/peer0.org9.amazonbiobank.mooo.com/msp --csr.hosts peer0.org9.amazonbiobank.mooo.com --tls.certfiles ${PWD}/fabric-ca/org9/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/peers/peer0.org9.amazonbiobank.mooo.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:16054 --caname ca.org9.amazonbiobank.mooo.com -M ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/peers/peer0.org9.amazonbiobank.mooo.com/tls --enrollment.profile tls --csr.hosts peer0.org9.amazonbiobank.mooo.com --csr.hosts localhost --csr.hosts peer0.org9.amazonbiobank.duckdns.org  --tls.certfiles ${PWD}/fabric-ca/org9/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/peers/peer0.org9.amazonbiobank.mooo.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/peers/peer0.org9.amazonbiobank.mooo.com/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/peers/peer0.org9.amazonbiobank.mooo.com/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/peers/peer0.org9.amazonbiobank.mooo.com/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/peers/peer0.org9.amazonbiobank.mooo.com/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/peers/peer0.org9.amazonbiobank.mooo.com/tls/server.key

  mkdir ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/msp/tlscacerts
  cp ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/peers/peer0.org9.amazonbiobank.mooo.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/tlsca
  cp ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/peers/peer0.org9.amazonbiobank.mooo.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/tlsca/tlsca.org9.amazonbiobank.mooo.com-cert.pem

  mkdir ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/ca
  cp ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/peers/peer0.org9.amazonbiobank.mooo.com/msp/cacerts/* ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/ca/ca.org9.amazonbiobank.mooo.com-cert.pem

  # ------------------------------------------------------------------------------------------------

  # Peer1

  # mkdir -p ../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/peers/peer1.org9.amazonbiobank.mooo.com

  # echo
  # echo "## Generate the peer1 msp"
  # echo
  # fabric-ca-client enroll -u https://peer1:peer1pw@localhost:16054 --caname ca.org9.amazonbiobank.mooo.com -M ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/peers/peer1.org9.amazonbiobank.mooo.com/msp --csr.hosts peer1.org9.amazonbiobank.mooo.com --tls.certfiles ${PWD}/fabric-ca/org9/tls-cert.pem

  # cp ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/peers/peer1.org9.amazonbiobank.mooo.com/msp/config.yaml

  # echo
  # echo "## Generate the peer1-tls certificates"
  # echo
  # fabric-ca-client enroll -u https://peer1:peer1pw@localhost:16054 --caname ca.org9.amazonbiobank.mooo.com -M ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/peers/peer1.org9.amazonbiobank.mooo.com/tls --enrollment.profile tls --csr.hosts peer1.org9.amazonbiobank.mooo.com --csr.hosts localhost --csr.hosts peer1.org9.amazonbiobank.duckdns.org  --tls.certfiles ${PWD}/fabric-ca/org9/tls-cert.pem

  # cp ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/peers/peer1.org9.amazonbiobank.mooo.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/peers/peer1.org9.amazonbiobank.mooo.com/tls/ca.crt
  # cp ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/peers/peer1.org9.amazonbiobank.mooo.com/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/peers/peer1.org9.amazonbiobank.mooo.com/tls/server.crt
  # cp ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/peers/peer1.org9.amazonbiobank.mooo.com/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/peers/peer1.org9.amazonbiobank.mooo.com/tls/server.key

  # --------------------------------------------------------------------------------------------------

  mkdir -p ../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/users
  mkdir -p ../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/users/User1@org9.amazonbiobank.mooo.com

  echo
  echo "## Generate the user msp"
  echo
  fabric-ca-client enroll -u https://user1:user1pw@localhost:16054 --caname ca.org9.amazonbiobank.mooo.com -M ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/users/User1@org9.amazonbiobank.mooo.com/msp --tls.certfiles ${PWD}/fabric-ca/org9/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/users/Admin@org9.amazonbiobank.mooo.com

  echo
  echo "## Generate the org admin msp"
  echo
  fabric-ca-client enroll -u https://org9admin:org9adminpw@localhost:16054 --caname ca.org9.amazonbiobank.mooo.com -M ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/users/Admin@org9.amazonbiobank.mooo.com/msp --tls.certfiles ${PWD}/fabric-ca/org9/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/org9.amazonbiobank.mooo.com/users/Admin@org9.amazonbiobank.mooo.com/msp/config.yaml

}

createcertificatesForOrg9

