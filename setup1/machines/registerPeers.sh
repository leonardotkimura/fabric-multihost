
cd vm1/create-certificate-with-ca
docker-compose up -d
cd -

cd vm2/create-certificate-with-ca
docker-compose up -d
cd -

sleep 3

cd vm4
./registerPeer1.sh
cd -

cd vm5
./registerPeer1.sh
cd -

cd vm6
./registerPeer1.sh
cd -

cd vm7
./registerPeer1.sh
cd -

cd vm8
./registerPeer1.sh
cd -

cd vm9
./registerPeer1.sh
cd -

cd vm1/create-certificate-with-ca
docker-compose down
cd -

cd vm2/create-certificate-with-ca
docker-compose up -d
cd -