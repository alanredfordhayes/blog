import logging
import boto3
from botocore.exceptions import ClientError
import os
import argparse

parser = argparse.ArgumentParser(prog = 'Upload to S3',description = 'Upoads all files in the dir to s3')
parser.add_argument('-f', '--filename')
parser.add_argument('-b', '--bucket')
parser.add_argument('-o', '--objectname')
args = parser.parse_args()

def upload_file(file_name, bucket, object_name=None):

    if object_name is None: object_name = os.path.basename(file_name)

    s3_client = boto3.client('s3')
    try: response = s3_client.upload_file(file_name, bucket, object_name)
    except ClientError as e: logging.error(e); return False
    return True

print(args.filename, args.bucket, args.objectname)