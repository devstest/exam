#!/usr/bin/env bash

SYNC_FOLDER=jenkins
JENKINS_PORT=8081
JENKINS_PASS=$( sudo cat /var/lib/jenkins/secrets/initialAdminPassword )

# Create helloworld job
java -jar /home/vagrant/$SYNC_FOLDER/jenkins-cli.jar -s http://127.0.0.1:${JENKINS_PORT}/ \
create-job helloworld_job < /home/vagrant/$SYNC_FOLDER/helloworld_job.xml --username admin --password $JENKINS_PASS
