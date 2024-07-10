# the name of the folder that this script is running in MUST be the same as the name of the Lambda!
lambda_name="${PWD##*/}"

zip_path="${lambda_name}.zip"

# all files in the ./lambda directory will be zipped
zip -j $zip_path ./lambda/*

echo "Created $zip_path"
echo "Updating $lambda_name lambda in AWS..."

# to see the lambda yaml remove the " > /dev/null" from the following command.  Use the space bar to jump a page of output at a time or the enter key to see a line at a time
aws lambda update-function-code --function-name $lambda_name --zip-file fileb://$zip_path > /dev/null

#comment out the following line if you want to inspect the zip file - be sure that you do not check the zip file into Git
rm $zip_path

echo "$zip_path deleted. Process complete"
