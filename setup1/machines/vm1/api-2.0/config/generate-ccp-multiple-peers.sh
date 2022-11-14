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
        -e "s#\${P0PORT1}#$7#" \
        ./ccp-template-multiple-peers.json
}

function yaml_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/ccp-template.yaml | sed -e $'s/\\\\n/\\\n          /g'
}

ORG=1
P0PORT=11751
CAPORT=11754
P0PORT1=8051
PEERPEM=../../crypto-config/peerOrganizations/org1.amazonbiobank.mooo.com/peers/peer0.org1.amazonbiobank.mooo.com/tls/tlscacerts/tls-localhost-7054-ca-org1-amazonbiobank-mooo-com.pem
PEERPEM1=../../crypto-config/peerOrganizations/org1.amazonbiobank.mooo.com/peers/peer0.org1.amazonbiobank.mooo.com/tls/tlscacerts/tls-localhost-7054-ca-org1-amazonbiobank-mooo-com.pem
# PEERPEM1=../../crypto-config/peerOrganizations/org1.amazonbiobank.mooo.com/peers/peer1.org1.amazonbiobank.mooo.com/tls/tlscacerts/tls-localhost-7054-ca-org1-amazonbiobank-mooo-com.pem
CAPEM=../../crypto-config/peerOrganizations/org1.amazonbiobank.mooo.com/msp/tlscacerts/ca.crt

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $PEERPEM1 $P0PORT1)" > connection-org1-multiple-peers.json
#echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/org1.amazonbiobank.mooo.com/connection-org1.yaml
