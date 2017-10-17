from centos: latest

MAINTAINER Steve Langer <sglanger@fastmail.COM>
###############################################################
# ddw-docker-GWAY
# Purpose: provide a runtime envornment for rnsa XXX
# 	inspired by 	
# 	and 		
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
run yum install nano

