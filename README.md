This File contains steps/Scripts to run jenkins cicd.


1. This repo contains cloudformation template namedec2.yml. We run following CLI Command to create stack

aws cloudformation deploy --stack-name dev-bastion-host --template-file 'ec2.yml' --parameter-overrides EnvironmentName=dev 

2. After successful creation of stack ssh to public ec2 and private ec2.  configure jenkins server, ansible server and docker server on public ec2.

3. Install Publish-over-ssh plugin in jenkins.
4. Add jenkins server in jenkins 
    Manage jenkins--> configure system--> ssh server--> add --> Enter HostName, User, Password of jenkins server
5. Add Ansible server in jenkins
    Manage Jenkins--> configure system--> ssh server--> add --> Enter Hostname, user, password of ansible server
6. Integrate GitHub Repository with Jenkins
    Go into Repository in GitHub --> settings -->Webhook --> add Webhook--> add url of jenkins server-->add token--> add webhook.
7. Go to Jenkins to create job
    New Item--> Freestyle job-->Save--> Add git url in SCM --> In Build select send file or Execute command over ssh--> select jenkins server--> Add command in Exec command
                rsync -avh /var/lib/jenkins/workspace/jenkins-cicd/Dockerfile ec2-user@44.193.17.170:/ec2-user

8.  Now in Build select send file or Execute command over ssh--> select ansible server--> Add command in Exec command
        cd /opt
        docker build -t Server .
        docker tag server:v1 suhasw91/server:v1
        docker push suhasw91/server:v1

9. First create sourcecode folder in /opt and put playbook in it.
    In Post Build Actions 
    ssh server --> select ansible server--> add command in Exec command 
        ansible-playbook /sourcecode/docker.yml

10. Click on Build Now

