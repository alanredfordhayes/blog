COMMANDS

docker build -t alanredfordhayes/upload-to-s3:latest . 

DOCKER RUN

docker run -v $HOME/.aws:/root/.aws -t alanredfordhayes/upload-to-s3:latest

docker push alanredfordhayes/upload-to-s3:latest