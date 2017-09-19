FROM centos:6.9
MAINTAINER ASCDC <asdc.sinica@gmail.com>

ADD run.sh /run.sh

RUN chmod 755 /run.sh && \
	yum update -y && \
	yum install -y vim wget
RUN cd /root && \
	wget https://downloads.mysql.com/archives/get/file/MySQL-server-5.0.96-1.glibc23.x86_64.rpm && \
	wget https://downloads.mysql.com/archives/get/file/MySQL-shared-compat-5.0.96-1.glibc23.x86_64.rpm && \
	wget https://downloads.mysql.com/archives/get/file/MySQL-client-5.0.96-1.glibc23.x86_64.rpm && \
	rpm -Uvh MySQL-shared-compat-5.0.96-1.glibc23.x86_64.rpm && \
	rpm -Uvh MySQL-server-5.0.96-1.glibc23.x86_64.rpm && \
	rpm -Uvh MySQL-client-5.0.96-1.glibc23.x86_64.rpm && \
	rm -f /root/*.rpm

ENV MYSQL_USER **None**
ENV MYSQL_PASSWORD **None**
ENV MYSQL_DATABASE **None**

EXPOSE 3306
WORKDIR /
ENTRYPOINT ["/run.sh"]
