cd vm0/create-certificate-with-ca
docker-compose up -d
sleep 3
./create-certificate-with-ca.sh
docker-compose down
cd -

cd vm1/create-certificate-with-ca
docker-compose up -d
sleep 3
./create-certificate-with-ca.sh
docker-compose down
cd -

cd vm2/create-certificate-with-ca
docker-compose up -d
sleep 3
./create-certificate-with-ca.sh
docker-compose down
cd -

cd vm3/create-certificate-with-ca
docker-compose up -d
sleep 3
./create-certificate-with-ca.sh
docker-compose down
cd -

cd vm4/create-certificate-with-ca
docker-compose up -d
sleep 3
./create-certificate-with-ca.sh
docker-compose down
cd -

cd vm5/create-certificate-with-ca
docker-compose up -d
sleep 3
./create-certificate-with-ca.sh
docker-compose down
cd -

cd vm6/create-certificate-with-ca
docker-compose up -d
sleep 3
./create-certificate-with-ca.sh
docker-compose down
cd -

cd vm7/create-certificate-with-ca
docker-compose up -d
sleep 3
./create-certificate-with-ca.sh
docker-compose down
cd -

cd vm8/create-certificate-with-ca
docker-compose up -d
sleep 3
./create-certificate-with-ca.sh
docker-compose down
cd -

cd vm9/create-certificate-with-ca
docker-compose up -d
sleep 3
./create-certificate-with-ca.sh
docker-compose down
cd -

cd ../artifacts/channel/
./create-artifacts.sh
cd -

