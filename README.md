# 商派ECStore/B2B2c docker

## 说明

这是一个Shopex ECStore B2C/B2B2C docker官方镜像

*注意*：镜像中只有php 运行环境，不含产品代码包。如需代码，请联系商派（shopex）购买商业授权。www.shopex.cn

欢迎在github上提交PR来改进我们的镜像

### Git repository

The source files for this project can be found here: [https://github.com/shopex/docker-ecstore](https://github.com/shopex/docker-ecstore)

If you have any improvements please submit a pull request.

### Docker hub repository

The Docker hub build can be found here: [https://hub.docker.com/r/shopex/ecstore/](https://hub.docker.com/r/shopex/ecstore/)

## Supported tags and respective Dockerfile links


### 下面是 swooleloader 1.9.0版本，2018年3月至2018年11月 期间发布的 ecstore5.0.1版本适用此镜像
- [`php56-swooleloader-1.9.0`(*php56-swooleloader/Dockerfile*)](https://github.com/shopex/docker-ecstore/blob/swoole-1.9.0/php56-swooleloader/Dockerfile)
- [`php56-swooleloader-1.9.0-mysql`(*php56-swooleloader-mysql/Dockerfile*)](https://github.com/shopex/docker-ecstore/blob/swoole-1.9.0/php56-swooleloader-mysql/Dockerfile)
- [`php72-swooleloader-1.9.0`(*php72-swooleloader/Dockerfile*)](https://github.com/shopex/docker-ecstore/blob/swoole-1.9.0/php72-swooleloader/Dockerfile)
- [`php72-swooleloader-1.9.0-mysql`(*php72-swooleloader-mysql/Dockerfile*)](https://github.com/shopex/docker-ecstore/blob/swoole-1.9.0/php72-swooleloader-mysql/Dockerfile)

## Versions （old）

| Tag | Nginx | PHP | mysql | ZendGuard Loader | Swoole Loader  | Dockerfile | 适用产品版本 |
|-----|-------|-----|--------|--------| --------|-------- |  ----- |
| php56-swooleloader-1.9.0 | nginx/1.12.1 |  5.6.37 | - | - | 1.9.0 | [php56-swooleloader/Dockerfile](https://github.com/shopex/docker-ecstore/blob/swoole-1.9.0/php56-swooleloader/Dockerfile)| ECstore B2C 5.0.1|
| php56-swooleloader-1.9.0-mysql | nginx/1.12.1 |  5.6.37 | 5.6.28 | - | 1.9.0 |[nginx-php56-swooleloader-mysql/Dockerfile](https://github.com/shopex/docker-ecstore/blob/swoole-1.9.0/php56-swooleloader-mysql/Dockerfile)| ECstore B2C 5.0.1 |
| php72-swooleloader-1.9.0 | nginx/1.12.1 |  7.2.11 | - | - | 1.9.0 |[php72-swooleloader/Dockerfile](https://github.com/shopex/docker-ecstore/blob/swoole-1.9.0/php72-swooleloader/Dockerfile)| 升级为 swoole 2.0，该版本已弃用 |


相关默认配置：

- web_root:/data/httpd/
- mysql_data:/data/mysql/
- php.ini:/etc/php.ini
- php extension_dir:/etc/php.d/
- nginx config:/etc/nginx/
- 启动脚本:/start.sh
- 重启 php-fpm: supervisorctl reload 或 supervisorctl restart all

## Quick Start

```bash
# 启动不含mysql的容器 php5.6
sudo docker run -d -p 8080:80 -v /path-to-ecstore:/data/httpd shopex/ecstore:php56-swooleloader-1.9.0

# 启动包含mysql的容器 php5.6
sudo docker run -d -p 8080:80 -v /path-to-ecstore:/data/httpd shopex/ecstore:php56-swooleloader-1.9.0-mysql

# 启动不含mysql的容器 php7.2
sudo docker run -d -p 8080:80 -v /path-to-b2b2c:/data/httpd shopex/ecstore:php72-swooleloader-1.9.0

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

### php5.6 默认扩展情况(swooleLoader)

```bash
[PHP Modules]
bcmath
bz2
calendar
Core
ctype
curl
date
dom
ereg
exif
fileinfo
filter
ftp
gd
gettext
gmp
hash
iconv
igbinary
json
libxml
mbstring
mcrypt
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
readline
redis
Reflection
session
shmop
SimpleXML
sockets
SPL
sqlite3
standard
swoole_loader
sysvmsg
sysvsem
sysvshm
tokenizer
wddx
xml
xmlreader
xmlwriter
xsl
zip
zlib

[Zend Modules]

```

### php5.6 默认扩展情况(zendGuardLoader)

```bash
[PHP Modules]
bcmath
bz2
calendar
Core
ctype
curl
date
ereg
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
mcrypt
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
readline
Reflection
session
shmop
SimpleXML
sockets
SPL
sqlite3
standard
tokenizer
xml
Zend Guard Loader
zip
zlib

[Zend Modules]
Zend Guard Loader

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
