# 
# Ansitory
# ========
#  
# description:
#   Ansible collections running in fedora container.
#   - oVirt
#   - ...
#
# version: 1.0

FROM docker.io/library/fedora:34

LABEL description="Ansible inside Fedora container"
MAINTAINER John Doe <jdoe@xyz.com>

# Todo: Setup user 

# Yum packages
RUN yum check-update; \
    yum -y install python3; \
    yum -y install python3-pip; \
    yum -y install python3-pycurl; \
    yum -y install python3-ovirt-engine-sdk4; \
    yum install -y ansible

# Pip packages

# Ansible collections
RUN ansible-galaxy collection install ovirt.ovirt

# Copy Ansible config
COPY ./src/ansible.cfg /etc/ansible/ansible.cfg
