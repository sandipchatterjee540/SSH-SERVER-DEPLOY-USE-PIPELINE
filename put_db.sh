#! /bin/bash

echo "*********************************************************************"
echo "************************** Auto Input *******************************"
echo "*********************************************************************"


Counter=0

while [ $Counter -lt 116 ]; do

        let Counter=Counter+1

        name=$(nl people.txt |grep -w $Counter |awk '{print $2}')
        age=$(shuf -i 15-75 -n 1)


        mysql -u root -psandip user -e "insert into register value('$Counter','$name',$age)"
        echo "Sucessfully import in db $name...."
done
echo "all data is sucessfully copy"

