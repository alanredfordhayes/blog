COMMANDS

docker build -t boto3-docker . 

DOCKER RUN

docker run v $HOME/.aws:/root/.aws -t boto3-docker