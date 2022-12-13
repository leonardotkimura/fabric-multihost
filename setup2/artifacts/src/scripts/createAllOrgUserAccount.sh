org=1
while [ $org -lt 10 ]
do
echo "creating user from org " $org
./createOrgUserAccount.sh $org
((org++))
done