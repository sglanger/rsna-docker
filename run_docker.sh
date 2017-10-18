#!/bin/bash

###############################################
# Author: SG Langer Jan 2016
# Purpose: put all the Docker commands to build/run 
#	ddw-dbase in one easy place
#
##########################################


############## main ###############
# Purpose: Based on command line arg either
#		a) build all Docker from scratch or
#		b) kill running docker or
#		c) start Docker or
#		d) restart
# Caller: user
###############################
clear
host="127.0.0.1"
image="rsna-docker"
instance="rsna-dock"


case "$1" in
	build)
		# first clean up if any running instance
		# Comment out the rmi line if you really don't want to rebuild the docker
		sudo docker stop $instance
		sudo docker rmi -f $image
		sudo docker rm $instance

		# now build from clean. The DOcker run line uses --net="host" term to expose the docker
		# on the Host's NIC. For better security, remove it
		sudo docker build --rm=true -t $image .
		# WHen both this and the ddw-gw DOcker use HOST, their Postgres instances collide in namespace
		# but we no longer expose the gway Postgres
		sudo docker run --net="host" --name $instance  -d $image
		sleep 3
		sudo docker ps
	;;

	conn)
		# connect to a  runnung docker
		sudo docker exec -it $instance /bin/bash 
	;;


	conn_r)
		# connect as root to a  runnung docker
		sudo docker exec -u root -it $instance /bin/bash
	;;

	restart)
		$0 stop
		$0 start
	;;

	status)
		sudo docker ps; echo
		sudo docker images 
	;;

	stop)
		# stops but does not remove image from DOcker engine
		sudo docker stop $instance
		sudo docker rm $instance
	;;

	start)
		# here we launch DOcker w/out the --net="host" tag , but then no ports are exposed including 104
		# so we expose them one at a time with -p switches on the container address
		host=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' $instance)
		# the trick is to know the IP before the docker is created, and yes it is a trick
		sudo docker run -p $host:2022:2022  --name $instance  -d $image
		sleep 3
		sudo docker ps
		sudo docker exec -it -u root $instance /bin/bash
	;;

	*)
		echo "invalid option"
		echo "valid options: build/start/stop/restart/status/conn"
		exit
	;;
esac
