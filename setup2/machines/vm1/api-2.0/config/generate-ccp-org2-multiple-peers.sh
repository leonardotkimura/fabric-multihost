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


ORG=2
P0PORT=12751
CAPORT=12754
P1PORT=15751
P2PORT=17751
P3PORT=19751
PEERPEM=../../../vm2/crypto-config/peerOrganizations/org2.amazonbiobank.mooo.com/peers/peer0.org2.amazonbiobank.mooo.com/tls/tlscacerts/tls-localhost-8054-ca-org2-amazonbiobank-mooo-com.pem
PEERPEM1=../../../vm2/crypto-config/peerOrganizations/org2.amazonbiobank.mooo.com/peers/peer0.org2.amazonbiobank.mooo.com/tls/tlscacerts/tls-localhost-8054-ca-org2-amazonbiobank-mooo-com.pem
# PEERPEM1=../../crypto-config/peerOrganizations/org2.amazonbiobank.mooo.com/peers/peer1.org2.amazonbiobank.mooo.com/tls/tlscacerts/tls-localhost-7054-ca-org2-amazonbiobank-mooo-com.pem
CAPEM=../../../vm2/crypto-config/peerOrganizations/org2.amazonbiobank.mooo.com/msp/tlscacerts/ca.crt

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $PEERPEM1 $P1PORT $P2PORT $P3PORT)" > connection-org2-multiple-peers.json
#echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/org2.amazonbiobank.mooo.com/connection-org2.yaml
