FROM centos:7.2.1511

# 初始设置
RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup &&\
    curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo &&\
    yum makecache &&\   
    yum install -y vim tar wget curl bzip2 net-tools lsof sysstat cronie python-setuptools &&\
    yum clean all &&\
    easy_install supervisor &&\
    cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 安装软件
RUN yum clean all &&\
    curl -o /etc/yum.repos.d/shopex-lnmp.el7.repo http://mirrors.shopex.cn/shopex/shopex-lnmp/shopex-lnmp.el7.repo &&\
    yum install epel-release -y &&\
    yum install php-fpm56 ngx_openresty php-memcache56  redis -y &&\
    yum install perl perl-Data-Dumper libaio* libnuma* -y  &&\
    yum clean all && rm -rf /tmp/* && rm -rf /var/tmp/*

ENV fpm_conf /usr/local/php56/etc/php-fpm.conf

#copy nginx-site
RUN rm -Rf  /usr/local/nginx/conf/vhosts/* && rm -Rf /usr/local/nginx/conf/nginx.conf
ADD conf/nginx.conf /usr/local/nginx/conf/nginx.conf
ADD conf/nginx-site.conf /usr/local/nginx/conf/vhosts/nginx-site.conf



# tweak php-fpm and zend config
RUN sed -i \        
        -e "s/pm.max_children = 128/pm.max_children = 5/g" \       
        ${fpm_conf} 




#ADD link
RUN ln -s /usr/local/php56/bin/php /usr/local/bin/php &&\
ln -s /usr/local/nginx/sbin/nginx /usr/local/sbin/nginx


#copy supervisord
RUN rm -Rf /etc/supervisord.conf
ADD conf/supervisord.conf /etc/supervisord.conf



# Add Scripts
RUN rm -Rf /start.sh
ADD scripts/start.sh /start.sh
RUN chmod 755 /start.sh

# 安装mysql（选填）
#RUN yum clean all &&\    
#    yum install  mysql56  &&\
#    rm -rf /data/mysql/3306/ib* /data/mysql/3306/*-bin.* /data/mysql/3306/test &&\
#    yum clean all && rm -rf /tmp/* && rm -rf /var/tmp/* &&\
#    rm -Rf /usr/local/mysql/my.cnf
#ADD conf/my.cnf /usr/local/mysql/my.cnf

# copy in code
#RUN rm -Rf /data/httpd/*
#ADD httpd.tar /data/
#VOLUME /data/httpd

EXPOSE 443 80 22

CMD ["/start.sh"]
