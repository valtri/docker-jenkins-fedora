#! /bin/bash -e

if ! test -d ~jenkins/.ssh; then
	if test -d /context -a -d /context/.ssh; then
		cp -va /context/.ssh ~jenkins/
	else
		mkdir ~jenkins/.ssh
		echo "Settings jenkins password"
		echo "jenkins:jenkins" | chpasswd
	fi

	chmod 0700 ~jenkins/.ssh
	chown -R jenkins:jenkins ~jenkins/.ssh
fi

exec "$@"
