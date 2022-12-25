import logging
import boto3
from botocore.exceptions import ClientError
import os
import argparse

parser = argparse.ArgumentParser(prog = 'Upload to S3',description = 'Upoads all files in the dir to s3')
parser.add_argument('-f', '--path')
parser.add_argument('-b', '--bucket')
args = parser.parse_args()

def upload_file(file_name, bucket, object_name=None):

    if object_name is None: object_name = os.path.basename(file_name)

    s3_client = boto3.client('s3')
    try: response = s3_client.upload_file(file_name, bucket, object_name)
    except ClientError as e: logging.error(e); return False
    return True

def uploadDirectory(path, bucketname):
        for root, dirs, files in os.walk(path):
            for file in files:
                print(os.path.join(root,file), bucketname, file)
                # upload_file(os.path.join(root,file), bucketname, file)
                
                
uploadDirectory(args.path, args.bucket)