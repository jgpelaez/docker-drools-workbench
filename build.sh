#!/bin/bash
#####################################################
# NOT MODIFY AFTER THIS, todo use a tool for building

IMAGENAME=$(<imagename.txt)

trap "exit 1" TERM
export TOP_PID=$$


function exitBash {
	kill -s TERM $TOP_PID
}

function checkParameters {
	if [ -z "$1" ] && [ -z "$2" ]; then
		echo 'Incorrect usage. Missing username password'
		exitBash
	fi
}

function runBuild {
	sudo mkdir -p target
	sudo mkdir -p target/logs
	sudo cp -r * ./target
	
	PROXYURLVAR=$http_proxy
	PROXYCONF_HTTP="ENV http_proxy $http_proxy"
	PROXYCONF_HTTPS="ENV https_proxy $https_proxy"
	sudo sed -i "s|#PROXYCONF1_HTTP|$PROXYCONF_HTTP|" ./target/Dockerfile
	sudo sed -i "s|#PROXYCONF2_HTTPS|$PROXYCONF_HTTPS|" ./target/Dockerfile
	echo $PROXYCONF_HTTP
	echo $PROXYCONF_HTTPS
	
	sudo docker build -t $IMAGENAME-tmp ./target
	RUNID=$(sudo docker run -d -e http_proxy='' -e https_proxy='' $IMAGENAME-tmp)
	echo docker id: $RUNID

	if [ -z "$RUNID" ] ; then
		echo 'The image has not been built'
		exitBash
	fi
	sudo docker commit $RUNID $IMAGENAME
	sudo docker stop $RUNID
	sudo docker rm $RUNID
	sudo docker rmi $IMAGENAME-tmp
	
	echo image $IMAGENAME build finish...
	
	
}
echo "====================="



clear


runBuild 