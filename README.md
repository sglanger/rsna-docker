# rsna-docker

Author: Steve Langer October 2017

Purpose: Provide a runtime platform for
	running user built apps (ie jars)
	in a portable environment.

	It may seem that this is an overkill Docker,
	but it is very tricky to start multiple processes
	on a DOcker. Supervisord allows this, at the 
	expense of learning about it 	http://supervisord.org/

Usage: see file run_docker.sh for build, run, clean
	Real user would replace all files starting with "fake"
	wither their real app, and have to update the .conf
	and .env files with their real stuff

	Follow the patterns seen in the /etc/services-config
	subfolders

