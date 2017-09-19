#!/bin/bash

/etc/init.d/mysql start

if [ ! -f /.mysql_set ]; then
	
	PASS=${MYSQL_ROOT_PASSWORD:-$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-16};echo;)}
	_word=$( [ ${MYSQL_ROOT_PASSWORD} ] && echo "preset" || echo "random" )
	echo "=> Setting a ${_word} password to the mysql root user"
	
	echo "DROP DATABASE test;"|mysql -sN
	echo "update mysql.user set host='%',password=PASSWORD('${PASS}') where host='127.0.0.1';"|mysql -sN
	echo "delete from mysql.user where host!='%';"|mysql -sN
	echo "TRUNCATE mysql.db;"|mysql -sN
	
	if [ "${MYSQL_USER}" != "**None**" ] && [ "${MYSQL_PASSWORD}" != "**None**" ]; then
		echo "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"|mysql -sN
		echo "=> Create a User."
		echo "User: ${MYSQL_USER}"
		echo "Password: ${MYSQL_PASSWORD}"
	fi
	
	if [ "${MYSQL_DATABASE}" != "**None**" ]; then
		IFS=',' read -r -a array <<< "${MYSQL_DATABASE}"
		
		for element in "${array[@]}"
		do
			echo "CREATE DATABASE $element;"|mysql -sN
			echo "=> Create a Database $element."
			
			if [ "${MYSQL_USER}" != "**None**" ] && [ "${MYSQL_PASSWORD}" != "**None**" ]; then
				echo "GRANT ALL PRIVILEGES ON $element.* TO '${MYSQL_USER}'@'%';"|mysql -sN
				echo "=> Grant Database $element All Privileges for ${MYSQL_USER}."
			fi
			
		done
	fi
	
	echo "FLUSH PRIVILEGES;"|mysql -sN
	
	touch /.mysql_set
	
	echo "========================================================================"
	echo "You can now connect to this MySQL 5.0.96 container"
	echo "and enter the root password '$PASS' when prompted"
	echo ""
	echo "Please remember to change the above password as soon as possible!"
	echo "========================================================================"
fi

/bin/bash


