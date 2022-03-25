# 
# ANSITORY
# ========
# ansible environment running in fedora container.
#
# collections:
#   - ovirt.ovirt
#   - awx.awx
# todo: 
#   - setup non-root user
#

FROM 		docker.io/library/fedora:34
LABEL 		description="ansible fedora container"
MAINTAINER 	John Doe <jdoe@xyz.com>

# yum packages
RUN yum check-update; \
    yum -y install python3; \
    yum -y install python3-pip; \
    yum -y install python3-pycurl; \
    yum -y install python3-ovirt-engine-sdk4; \
    yum -y install fish; \
    yum -y install git; \
    yum -y install ansible
 
# pip packages
RUN pip install hvac; \
    pip install kubernetes
    #pip install ansible-modules-hashivault

# ansible collections
RUN ansible-galaxy collection install ovirt.ovirt; \
    ansible-galaxy collection install awx.awx; \
    ansible-galaxy collection install community.okd

# copy ansible config
COPY ./src/ansible.cfg /etc/ansible/ansible.cfg
