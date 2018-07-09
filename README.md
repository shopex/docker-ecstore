# 商派ECStore 5.0 docker

支持版本：Shopex ECStore 5.0.x

该docker镜像包含：

- php5.6 (with swoole loader)
- nginx 

不含mysql，需要自己在此基础上安装mysql，或者连接到远程的mysql(推荐)

相关默认配置：

web_root:/data/httpd/