COMMANDS

docker build -t jenkins-casc . 

DOCKER RUN

Map jenkins home dir
jenkins_home:/var/jenkins_home

Map jenkins log dir
jenkins_log:/var/log/jenkins

Maps docker installed on host to docker installed in container
/var/run/docker.sock:/var/run/docker.sock

docker run -v jenkins_home:/var/jenkins_home -v jenkins_log:/var/log/jenkins -v /var/run/docker.sock:/var/run/docker.sock -p 8080:8080 -p 50000:50000 jenkins-casc