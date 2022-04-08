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


# Environment
ENV ANSITORY_USER='jdoe'
ENV ANSITORY_OC_API='https://api.cluster.example.org'
ENV ANSITORY_OC_DOMAIN='apps.cluster.example.org'
ENV ANSITORY_OC_PASS=''
ENV ANSITORY_OC_USER=''


# yum packages
RUN yum check-update; \
    yum -y install python3; \
    yum -y install python3-pip; \
    yum -y install python3-pycurl; \
    yum -y install python3-ovirt-engine-sdk4; \
    yum -y install fish; \
    yum -y install git


# pip packages
RUN pip install ansible kubernetes hvac ansible-modules-hashivault

# install oc client
RUN curl -O https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/stable/openshift-client-linux.tar.gz ; \ 
    tar -xzvf openshift-client-linux.tar.gz -C /usr/local/bin; \
    rm -f openshift-client-linux.tar.gz

# land global ansible config file
COPY ./src/ansible.cfg /etc/ansible/ansible.cfg

# create and switch to USER; install ansible collections as user
RUN useradd ${ANSITORY_USER}
USER ${ANSITORY_USER}
RUN ansible-galaxy collection install ovirt.ovirt; \
    ansible-galaxy collection install awx.awx; \
    ansible-galaxy collection install community.okd

