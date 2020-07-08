#! /bin/bash

echo "*********************************************************************"
echo "************************** Auto Input *******************************"
echo "*********************************************************************"


mysql -h db-host -u root -psandip -e "CREATE DATABASE user;"

echo "**************************** DB CREATE ************************************************************************"
mysql -h db-host -u root -psandip -e "USE user;SELECT DATABASE();CREATE TABLE register(id int(12), name varchar(20), age int(3));"
echo "**************************** INCERT DATA ************************************************************************"
Counter=0

while [ $Counter -lt 116 ]; do

        let Counter=Counter+1

        name=$(nl people.txt |grep -w $Counter |awk '{print $2}')
        age=$(shuf -i 15-75 -n 1)


        mysql -h db-host  -u root -psandip user -e "insert into register value('$Counter','$name',$age)"
        echo "Sucessfully import in db $name...."
done
echo "all data is sucessfully copy"

