# 商派ECStore 5.0 docker

支持版本：Shopex ECStore 5.0.x

该docker镜像包含：

- php5.6 (with swoole loader)
- nginx 
- mysql5.6

不含mysql，需要自己在此基础上安装mysql，或者连接到远程的mysql(推荐)

相关默认配置：

web_root:/data/httpd/

### mysql info:

To start mysqld at boot time you have to copy
support-files/mysql.server to the right place for your system

PLEASE REMEMBER TO SET A PASSWORD FOR THE MySQL root USER !
To do so, start the server, then issue the following commands:

  /usr/bin/mysqladmin -u root password 'new-password'
  /usr/bin/mysqladmin -u root -h 563dacdc4a71 password 'new-password'

Alternatively you can run:

  /usr/bin/mysql_secure_installation

which will also give you the option of removing the test
databases and anonymous user created by default.  This is
strongly recommended for production servers.

See the manual for more instructions.

You can start the MySQL daemon with:

  cd /usr ; /usr/bin/mysqld_safe &

You can test the MySQL daemon with mysql-test-run.pl

  cd mysql-test ; perl mysql-test-run.pl

Please report any problems at http://bugs.mysql.com/

The latest information about MySQL is available on the web at

  http://www.mysql.com
