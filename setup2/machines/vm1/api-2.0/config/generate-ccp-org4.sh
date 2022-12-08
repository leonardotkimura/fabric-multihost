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
        ./ccp-template.json
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

ORG=4
P0PORT=14751
CAPORT=14754
P0PORT1=8051
PEERPEM=../../../vm4/crypto-config/peerOrganizations/org4.amazonbiobank.mooo.com/peers/peer0.org4.amazonbiobank.mooo.com/tls/tlscacerts/tls-localhost-11054-ca-org4-amazonbiobank-mooo-com.pem
PEERPEM1=../../../vm4/crypto-config/peerOrganizations/org4.amazonbiobank.mooo.com/peers/peer0.org4.amazonbiobank.mooo.com/tls/tlscacerts/tls-localhost-11054-ca-org4-amazonbiobank-mooo-com.pem
# PEERPEM1=../../crypto-config/peerOrganizations/org4.amazonbiobank.mooo.com/peers/peer1.org4.amazonbiobank.mooo.com/tls/tlscacerts/tls-localhost-11054-ca-org4-amazonbiobank-mooo-com.pem
CAPEM=../../../vm4/crypto-config/peerOrganizations/org4.amazonbiobank.mooo.com/msp/tlscacerts/ca.crt

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $PEERPEM1 $P0PORT1)" > connection-org4.json
#echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/org4.amazonbiobank.mooo.com/connection-org4.yaml
