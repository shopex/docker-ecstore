# 商派ECStore/B2B2c docker

## 说明

这是一个Shopex ECStore B2C/B2B2C 可用的docker官方镜像

### Git repository

The source files for this project can be found here: [https://github.com/summergeorge/nginx-php56-docker](https://github.com/summergeorge/nginx-php56-docker)

If you have any improvements please submit a pull request.

### Docker hub repository

The Docker hub build can be found here: [https://hub.docker.com/r/ecstore/nginx-php56/](https://hub.docker.com/r/ecstore/nginx-php56/)

## Versions

| Tag | Nginx | PHP | mysql | ZendGuard Loader | Swoole Loader  | Dockerfile | 
|-----|-------|-----|--------|--------| --------|-------- |  
| nginx-php56 | openresty/1.11.2.4 | 5.6.31 | - | - | 1.8.0 | [nginx-php56/Dockerfile](https://github.com/summergeorge/nginx-php56-docker/blob/master/nginx-php56/Dockerfile)|
| nginx-php56-mysql56   | openresty/1.11.2.4 | 5.6.31 | 5.6.28 | - | 1.8.0 |[nginx-php56-mysql56/Dockerfile](https://github.com/summergeorge/nginx-php56-docker/blob/master/nginx-php56-mysql56/Dockerfile)|
| nginx-php72-swooleloader   | nginx/1.12.1 | 7.2.8 | - | - | 1.9.0 |[nginx-php72-swooleloader/Dockerfile](https://github.com/summergeorge/nginx-php56-docker/blob/master/nginx-php72-swooleloader/Dockerfile)|
相关默认配置：

- web_root:/data/httpd/
- mysql_data:/data/mysql/

## Quick Start

```bash
# 启动不含mysql的容器 php5.6
sudo docker run -d -p 8080:80 -v /path-to-ecstore:/data/httpd ecstore/nginx-php56:nginx-php56

# 启动包含mysql的容器 php5.6
sudo docker run -d -p 8080:80 -v /path-to-ecstore:/data/httpd ecstore/nginx-php56:nginx-php56-mysql56

# 启动不含mysql的容器 php7.2
sudo docker run -d -p 8080:80 -v /path-to-ecstore:/data/httpd ecstore/nginx-php56:nginx-php72-swooleloader

```

### mysql info（适用于nginx-php56-mysql56)

**mysql 默认没有密码**

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

The latest information about MySQL is available on the web at  http://www.mysql.com

### php5.6 默认扩展情况

```bash
[PHP Modules]
bcmath
Core
ctype
curl
date
dom
ereg
fileinfo
filter
ftp
gd
gettext
hash
iconv
json
libxml
mbstring
mcrypt
memcache
mhash
mysql
mysqli
mysqlnd
openssl
pcntl
pcre
PDO
pdo_mysql
pdo_sqlite
Phar
posix
Reflection
session
shmop
SimpleXML
soap
sockets
SPL
sqlite3
standard
swoole_loader
sysvsem
tokenizer
xml
xmlreader
xmlrpc
xmlwriter
zip
zlib

[Zend Modules]

```

### php7.2默认扩展

```bash
[PHP Modules]
bcmath
bz2
calendar
Core
ctype
curl
date
exif
fileinfo
filter
ftp
gd
gettext
gmp
hash
iconv
json
libxml
mbstring
mysqli
openssl
pcntl
pcre
PDO
pdo_mysql
pdo_sqlite
Phar
readline
Reflection
session
shmop
SimpleXML
sockets
SPL
sqlite3
standard
swoole_loader
tokenizer
xml
zip
zlib

[Zend Modules]

```