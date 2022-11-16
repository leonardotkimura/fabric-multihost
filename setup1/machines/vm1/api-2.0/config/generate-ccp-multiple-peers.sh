#!/bin/bash

function one_line_pem {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}

function json_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    local PP1=$(one_line_pem $6)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        -e "s#\${PEERPEM1}#$PP1#" \
        -e "s#\${P1PORT}#$7#" \
        -e "s#\${P2PORT}#$8#" \
        -e "s#\${P3PORT}#$9#" \
        ./ccp-template-multiple-peers.json
}


ORG=1
P0PORT=11751
CAPORT=11754
P1PORT=14751
P2PORT=16751
P3PORT=18751
PEERPEM=../../crypto-config/peerOrganizations/org1.amazonbiobank.mooo.com/peers/peer0.org1.amazonbiobank.mooo.com/tls/tlscacerts/tls-localhost-7054-ca-org1-amazonbiobank-mooo-com.pem
PEERPEM1=../../crypto-config/peerOrganizations/org1.amazonbiobank.mooo.com/peers/peer0.org1.amazonbiobank.mooo.com/tls/tlscacerts/tls-localhost-7054-ca-org1-amazonbiobank-mooo-com.pem
# PEERPEM1=../../crypto-config/peerOrganizations/org1.amazonbiobank.mooo.com/peers/peer1.org1.amazonbiobank.mooo.com/tls/tlscacerts/tls-localhost-7054-ca-org1-amazonbiobank-mooo-com.pem
CAPEM=../../crypto-config/peerOrganizations/org1.amazonbiobank.mooo.com/msp/tlscacerts/ca.crt

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $PEERPEM1 $P1PORT $P2PORT $P3PORT)" > connection-org1-multiple-peers.json
#echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/org1.amazonbiobank.mooo.com/connection-org1.yaml
