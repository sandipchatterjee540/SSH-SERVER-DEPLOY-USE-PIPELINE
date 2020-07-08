#! /bin/bash

Date=$(date +%H-%M-%S)
BACKUP=db-$Date.sql
DB_host=$1
DB_password=$2
DB_name=$3
AWS_serect=$4
BUCCKET_NAME=$5

mysqldump -h $DB_host -u root -p$DB_password $DB_name > /tmp/$BACKUP && \

#mysqldump -h db_host -u root -p1234 sandip_info > db.sql
#  export AWS_SECRET_ACCESS_KEY=8jeXbxAmz9/HMRd7fsr+g5R2DksF9yAOZRtbvyWP

export AWS_ACCESS_KEY_ID=AKIAS6SE2EUIWDI7K7OZ && \
export AWS_SECRET_ACCESS_KEY=$AWS_serect && \

echo "upload your $BACKUP"


aws s3 cp /tmp/$BACKUP s3://$BUCCKET_NAME/$BACKUP

