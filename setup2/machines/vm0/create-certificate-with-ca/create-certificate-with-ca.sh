createCretificateForOrderer() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p ../crypto-config/ordererOrganizations/amazonbiobank.mooo.com

  export FABRIC_CA_CLIENT_HOME=${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com

  fabric-ca-client enroll -u https://admin:adminpw@localhost:9054 --caname ca-orderer --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/msp/config.yaml

  echo
  echo "Register orderer"
  echo

  fabric-ca-client register --caname ca-orderer --id.name orderer --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  echo
  echo "Register orderer2"
  echo

  fabric-ca-client register --caname ca-orderer --id.name orderer2 --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  echo
  echo "Register orderer3"
  echo

  fabric-ca-client register --caname ca-orderer --id.name orderer3 --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  echo
  echo "Register the orderer admin"
  echo

  fabric-ca-client register --caname ca-orderer --id.name ordererAdmin --id.secret ordererAdminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  mkdir -p ../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers
  # mkdir -p ../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/amazonbiobank.mooo.com

  # ---------------------------------------------------------------------------
  #  Orderer

  mkdir -p ../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer.amazonbiobank.mooo.com

  echo
  echo "## Generate the orderer msp"
  echo

  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer.amazonbiobank.mooo.com/msp --csr.hosts orderer.amazonbiobank.mooo.com --csr.hosts localhost --csr.hosts orderer.amazonbiobank.duckdns.org --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/msp/config.yaml ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer.amazonbiobank.mooo.com/msp/config.yaml

  echo
  echo "## Generate the orderer-tls certificates"
  echo

  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer.amazonbiobank.mooo.com/tls --enrollment.profile tls --csr.hosts orderer.amazonbiobank.mooo.com --csr.hosts localhost --csr.hosts orderer.amazonbiobank.duckdns.org --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer.amazonbiobank.mooo.com/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer.amazonbiobank.mooo.com/tls/ca.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer.amazonbiobank.mooo.com/tls/signcerts/* ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer.amazonbiobank.mooo.com/tls/server.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer.amazonbiobank.mooo.com/tls/keystore/* ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer.amazonbiobank.mooo.com/tls/server.key

  mkdir ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer.amazonbiobank.mooo.com/msp/tlscacerts
  cp ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer.amazonbiobank.mooo.com/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer.amazonbiobank.mooo.com/msp/tlscacerts/tlsca.amazonbiobank.mooo.com-cert.pem

  mkdir ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/msp/tlscacerts
  cp ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer.amazonbiobank.mooo.com/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/msp/tlscacerts/tlsca.amazonbiobank.mooo.com-cert.pem

  # -----------------------------------------------------------------------
  #  Orderer 2

  mkdir -p ../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer2.amazonbiobank.mooo.com

  echo
  echo "## Generate the orderer2 msp"
  echo

  fabric-ca-client enroll -u https://orderer2:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer2.amazonbiobank.mooo.com/msp --csr.hosts orderer2.amazonbiobank.mooo.com --csr.hosts localhost --csr.hosts orderer2.amazonbiobank.duckdns.org --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/msp/config.yaml ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer2.amazonbiobank.mooo.com/msp/config.yaml

  echo
  echo "## Generate the orderer2-tls certificates"
  echo

  fabric-ca-client enroll -u https://orderer2:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer2.amazonbiobank.mooo.com/tls --enrollment.profile tls --csr.hosts orderer2.amazonbiobank.mooo.com --csr.hosts localhost --csr.hosts orderer2.amazonbiobank.duckdns.org --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer2.amazonbiobank.mooo.com/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer2.amazonbiobank.mooo.com/tls/ca.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer2.amazonbiobank.mooo.com/tls/signcerts/* ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer2.amazonbiobank.mooo.com/tls/server.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer2.amazonbiobank.mooo.com/tls/keystore/* ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer2.amazonbiobank.mooo.com/tls/server.key

  mkdir ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer2.amazonbiobank.mooo.com/msp/tlscacerts
  cp ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer2.amazonbiobank.mooo.com/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer2.amazonbiobank.mooo.com/msp/tlscacerts/tlsca.amazonbiobank.mooo.com-cert.pem

  # ---------------------------------------------------------------------------
  #  Orderer 3
  mkdir -p ../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer3.amazonbiobank.mooo.com

  echo
  echo "## Generate the orderer3 msp"
  echo

  fabric-ca-client enroll -u https://orderer3:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer3.amazonbiobank.mooo.com/msp --csr.hosts orderer3.amazonbiobank.mooo.com --csr.hosts localhost --csr.hosts orderer3.amazonbiobank.duckdns.org --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/msp/config.yaml ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer3.amazonbiobank.mooo.com/msp/config.yaml

  echo
  echo "## Generate the orderer3-tls certificates"
  echo

  fabric-ca-client enroll -u https://orderer3:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer3.amazonbiobank.mooo.com/tls --enrollment.profile tls --csr.hosts orderer3.amazonbiobank.mooo.com --csr.hosts localhost --csr.hosts orderer3.amazonbiobank.duckdns.org  --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer3.amazonbiobank.mooo.com/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer3.amazonbiobank.mooo.com/tls/ca.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer3.amazonbiobank.mooo.com/tls/signcerts/* ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer3.amazonbiobank.mooo.com/tls/server.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer3.amazonbiobank.mooo.com/tls/keystore/* ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer3.amazonbiobank.mooo.com/tls/server.key

  mkdir ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer3.amazonbiobank.mooo.com/msp/tlscacerts
  cp ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer3.amazonbiobank.mooo.com/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/orderers/orderer3.amazonbiobank.mooo.com/msp/tlscacerts/tlsca.amazonbiobank.mooo.com-cert.pem
  # ---------------------------------------------------------------------------

  mkdir -p ../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/users
  mkdir -p ../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/users/Admin@amazonbiobank.mooo.com

  echo
  echo "## Generate the admin msp"
  echo

  fabric-ca-client enroll -u https://ordererAdmin:ordererAdminpw@localhost:9054 --caname ca-orderer -M ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/users/Admin@amazonbiobank.mooo.com/msp --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/msp/config.yaml ${PWD}/../crypto-config/ordererOrganizations/amazonbiobank.mooo.com/users/Admin@amazonbiobank.mooo.com/msp/config.yaml

}

createCretificateForOrderer