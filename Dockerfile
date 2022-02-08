# 
# ANSITORY
# ========
# ansible environment running in fedora container.
#
# collections:
#   - ovirt.ovirt
#
# todo: 
#   - setup non-root user
#

FROM 		docker.io/library/fedora:34
LABEL 		description="ansible fedora container"
MAINTAINER 	John Doe <jdoe@xyz.com>

# yum packages
RUN yum check-update; \
    yum install -y ansible; \
    yum -y install python3; \
    yum -y install python3-pip; \
    yum -y install python3-pycurl; \
    yum -y install python3-ovirt-engine-sdk4; \
    yum -y install yamllint
# pip packages
RUN pip install ansible-tower-cli

# ansible collections
RUN ansible-galaxy collection \
	 install ovirt.ovirt

# copy ansible config
COPY ./src/ansible.cfg /etc/ansible/ansible.cfg
