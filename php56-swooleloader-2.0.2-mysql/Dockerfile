FROM ecstore/docker-ecstore:php56-swooleloader-2.0.2
# docker image name: ecstore/docker-ecstore:php56-swooleloader-2.0.2-mysql


# 安装mysql 
RUN curl -o /tmp/MySQL-server-5.6.28-1.el7.x86_64.rpm  https://cdn.mysql.com/archives/mysql-5.6/MySQL-server-5.6.28-1.el7.x86_64.rpm  &&\
    rpm -ivh /tmp/MySQL-server-5.6.28-1.el7.x86_64.rpm &&\ 
    mkdir -p /data/mysql && chown -R mysql.mysql /data/mysql &&\  
    mysql_install_db  --no-defaults --datadir=/data/mysql --user=mysql &&\
    rm -Rf /etc/my.cnf &&\    
    rm -rf /tmp/* && rm -rf /var/tmp/* 

# data
VOLUME /data/mysql

ADD conf/my.cnf /etc/my.cnf

# Add Scripts
RUN rm -Rf /start.sh
ADD scripts/start.sh /start.sh
RUN chmod 755 /start.sh


# copy in code
#RUN rm -Rf /data/httpd/*
#ADD httpd.tar /data/
#VOLUME /data/httpd

EXPOSE 443 80 22 3306

CMD ["/start.sh"]
