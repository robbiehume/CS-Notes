#!/usr/bin/bash

# the name of the folder that this script is running in MUST be the same as the name of the Lambda!
lambda_name="${PWD##*/}"
zip_file=$lambda_name.zip
location=$(aws lambda get-function --function-name $lambda_name --query 'Code.Location')

touch $zip_file
sudo su -c "wget -O $zip_file $location"
unzip $zip_file -d lambda
rm $zip_file
