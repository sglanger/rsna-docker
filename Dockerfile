from centos:centos6.9


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
# Run it with "sudo docker run --name rsna-dock -e /bin/bash -d rsna-docker "
# Connect to above instance with "sudo docker exec -it ddw-gw /bin/bash" or "sudo docker exec -u root -it ddw-gw /bin/bash"
# get IP of instance with "sudo docker inspect ddw-gw "
##############################################################


CMD ["/bin/bash"]
run yum -y install nano
run yum -y install openssh
run yum -y install java
run yum -y install epel-release
run yum -y install python-setuptools	# provides easy_install

# -----------------------------------------------------------------------------
# Install supervisord (required to run more than a single process in a container)
# Note: EPEL package lacks /usr/bin/pidproxy
# We require supervisor-stdout to allow output of services started by 
# supervisord to be easily inspected with "docker logs".
# -----------------------------------------------------------------------------
RUN  easy_install \
		'supervisor == 3.3.3' \
		'supervisor-stdout == 0.1.1' \
	&& mkdir -p \
	/var/log/supervisor/


# STEP xx: Expose a non-privealged port for ssh access
EXPOSE 2022


# STEP yy: Set the default command to run when starting the container
CMD ["/usr/bin/supervisord", "--configuration=/etc/supervisord.conf"]

