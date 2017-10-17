from centos:latest


MAINTAINER Steve Langer <sglanger@fastmail.COM>
###############################################################
# rsna-docker
# Purpose: provide a runtime envornment for rnsa XXX
# 	inspired by https://github.com/jdeathe/centos-ssh/blob/centos-6/Dockerfile 		
#
# External Dependencies: all the "ADD" files below and
# 			
#
# Build with  "sudo docker build --rm=true -t ddw-gway . "
# Run it with "sudo docker run --name ddw-gw -e POSTGRES_PASSWORD=postgres -d ddw-gway "
# Connect to above instance with "sudo docker exec -it ddw-gw /bin/bash" or "sudo docker exec -u root -it ddw-gw /bin/bash"
# get IP of instance with "sudo docker inspect ddw-gw "
##############################################################


CMD ["/bin/bash"]
run yum -y install nano
run yum -y install openssh
run yum -y install java

expose 22

run sshd

