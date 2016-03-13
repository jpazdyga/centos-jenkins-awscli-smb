FROM jpazdyga/centos7-base

MAINTAINER Jakub Pazdyga <admin@lascalia.com>

ENV container docker

ENV DATE_TIMEZONE UTC

RUN rpmdb --rebuilddb && \ 
    rpmdb --initdb && \
    yum clean all && \
    yum -y update && \
    yum -y install wget \ 
		   curl \
		   bind-utils \
		   screen \
		   openssl-devel \
		   gcc \
		   make \
		   openldap-devel \
		   openssh \
                   openssl \ 
                   openssl-libs \
                   psmisc \
		   python \
		   samba-client \
 		   samba-client-libs \
		   samba-common-tools \
		   samba-libs \
		   samba

RUN wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
RUN rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
RUN yum -y install jenkins

RUN curl -O https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN pip install awscli

RUN wget https://gp2x.org/adtool/adtool-1.3.3.tar.gz
RUN tar -zxvf adtool-1.3.3.tar.gz ; cd adtool-1.3.3; ./configure; make; make install; cp src/etc/adtool.cfg.dist /usr/local/etc/adtool.cfg
