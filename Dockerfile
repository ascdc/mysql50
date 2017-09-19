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
	rm -f /root/*.rpm && \
	mkdir /etc/mysql && \
	touch /etc/mysql/my.cnf && \
	echo "[mysqld]" > /etc/mysql/my.cnf && \
	echo "datadir=/var/lib/mysql" >> /etc/mysql/my.cnf && \
	echo "socket=/var/lib/mysql/mysql.sock" >> /etc/mysql/my.cnf && \
	echo "user=mysql" >> /etc/mysql/my.cnf && \
	echo "old_passwords=1" >> /etc/mysql/my.cnf && \
	echo "max_allowed_packet=1024M" >> /etc/mysql/my.cnf && \
	echo "sync_binlog=1" >> /etc/mysql/my.cnf && \
	echo "innodb_flush_log_at_trx_commit=1" >> /etc/mysql/my.cnf && \
	echo "innodb_buffer_pool_size=1G" >> /etc/mysql/my.cnf && \
	echo "query_cache_type=1" >> /etc/mysql/my.cnf && \
	echo "query_cache_size=256M" >> /etc/mysql/my.cnf && \
	echo "query_cache_limit=4M" >> /etc/mysql/my.cnf && \
	echo "join_buffer_size=2M" >> /etc/mysql/my.cnf && \
	echo "sort_buffer_size=4M" >> /etc/mysql/my.cnf && \
	echo "read_buffer_size=4M" >> /etc/mysql/my.cnf && \
	echo "read_rnd_buffer_size=16M" >> /etc/mysql/my.cnf && \
	echo "table_cache=2048" >> /etc/mysql/my.cnf && \
	echo "max_heap_table_size=2G" >> /etc/mysql/my.cnf && \
	echo "tmp_table_size=2G" >> /etc/mysql/my.cnf && \
	echo "max_connections=64" >> /etc/mysql/my.cnf && \
	echo "key_buffer_size=1G" >> /etc/mysql/my.cnf && \
	echo "thread_cache_size=8" >> /etc/mysql/my.cnf && \
	echo "expire_logs_days=14" >> /etc/mysql/my.cnf && \
	echo "" >> /etc/mysql/my.cnf && \
	echo "[mysqld_safe]" >> /etc/mysql/my.cnf && \
	echo "log-error=/var/log/mysqld.log" >> /etc/mysql/my.cnf && \
	echo "pid-file=/var/run/mysqld/mysqld.pid" >> /etc/mysql/my.cnf && \
	ln -sf /etc/mysql/my.cnf /etc/my.cnf

ENV MYSQL_USER **None**
ENV MYSQL_PASSWORD **None**
ENV MYSQL_DATABASE **None**

EXPOSE 3306
WORKDIR /etc/mysql
ENTRYPOINT ["/run.sh"]

