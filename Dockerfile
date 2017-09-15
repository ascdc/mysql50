FROM centos:6.9
MAINTAINER ASCDC <asdc.sinica@gmail.com>

ADD run.sh /run.sh

RUN yum update -y && \
	yum install vim wget
RUN cd /root && \
	wget https://downloads.mysql.com/archives/get/file/MySQL-server-5.0.96-1.glibc23.x86_64.rpm && \
	wget https://downloads.mysql.com/archives/get/file/MySQL-shared-compat-5.0.96-1.glibc23.x86_64.rpm && \
	rpm -Uvh MySQL-shared-compat-5.0.96-1.glibc23.x86_64.rpm && \
	rpm -Uvh MySQL-server-5.0.96-1.glibc23.x86_64.rpm && \
	rm -f /root/*.rpm

EXPOSE 3306
WORKDIR /
ENTRYPOINT ["/run.sh"]
