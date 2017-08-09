# Info

Basic Jenkins node Fedora image

Installed:

* Java 8 JRE (EPEL)
* openssh server
* sudo

# Usage

In Jenkins:

* for example with *Docker Plugin*
* start command must be set to */docker-entry.sh /usr/sbin/sshd -D*

## Simple way

Initial password is created during start, but only if */context/.ssh* directory is not found locally:

* user: **jenkins**
* password: **jenkins**

Steps:

    docker pull valtri/docker-jenkins-fedora
    docker run -itd --name jenkins-fedora valtri/docker-jenkins-fedora

## Recommended way

Access using ssh keys and no password will be created.

Steps:

	ssh-keygen -t rsa -f jenkins_node
	mkdir -p context/.ssh
	#SELinux: chcon -Rt svirt_sandbox_file_t context/
	cp -p jenkins_node.pub context/.ssh/authorized_keys

    docker pull valtri/docker-jenkins-fedora
    docker run -itd --name jenkins-fedora --volume `pwd`/context:/context:ro valtri/docker-jenkins-fedora

# Tags

* **rawhide**, **latest**: Fedora rawhide
