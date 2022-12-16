const fs = require('fs')

const sk_name = process.argv[2]

const sk = fs.readFileSync("/home/ubuntu/fabric-multihost/setup3/machines/vm3/crypto-config/" + 
    "peerOrganizations/org3.amazonbiobank.mooo.com/users/User1@org3.amazonbiobank.mooo.com/msp/keystore/" +
    sk_name)

const cert = fs.readFileSync("/home/ubuntu/fabric-multihost/setup3/machines/vm3/crypto-config/" + 
    "peerOrganizations/org3.amazonbiobank.mooo.com/users/User1@org3.amazonbiobank.mooo.com/msp/signcerts/cert.pem")

const id = {
    "credentials": {
        "certificate": cert.toString(),
        "privateKey": sk.toString()
    },
    "mspId":"Org3MSP",
    "type":"X.509",
    "version":1
}

fs.writeFile("wallet/admin.id", JSON.stringify(id), function (err) {
    if (err) return console.log(err);
    console.log('admin id created with success');
  })

