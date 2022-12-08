const fs = require('fs')

const sk_name = process.argv[2]

const sk = fs.readFileSync("/home/ubuntu/fabric-multihost/setup2/machines/vm4/crypto-config/" + 
    "peerOrganizations/org4.amazonbiobank.mooo.com/users/User1@org4.amazonbiobank.mooo.com/msp/keystore/" +
    sk_name)

const cert = fs.readFileSync("/home/ubuntu/fabric-multihost/setup2/machines/vm4/crypto-config/" + 
    "peerOrganizations/org4.amazonbiobank.mooo.com/users/User1@org4.amazonbiobank.mooo.com/msp/signcerts/cert.pem")

const id = {
    "credentials": {
        "certificate": cert.toString(),
        "privateKey": sk.toString()
    },
    "mspId":"Org4MSP",
    "type":"X.509",
    "version":1
}

fs.writeFile("../wallet/admin.id", JSON.stringify(id), function (err) {
    if (err) return console.log(err);
    console.log('admin id created with success');
  })

