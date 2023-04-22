FROM centos:7.9.2009
MAINTAINER monkeye "monkeye@discuz.vip"
    
ARG timezone
ENV TIMEZONE=${timezone:-"Asia/Shanghai"}

# Install
RUN yum install -y epel-release \
&& yum -y install wget \
&& wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo \
&& rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm \
&& yum install -y --enablerepo=remi --enablerepo=remi-php81 php php-opcache php-devel php-mbstring php-mcrypt php-mysqlnd php-mysql php-odbc php-pdo php-mssql php-mysqli php-gd php-xml php-pear php-bcmath php-pecl-swoole php-pecl-redis php-pecl-mongo --skip-broken \
&& yum install -y --enablerepo=remi --enablerepo=remi-php81 php-fpm \
&& yum install -y nginx \
&& groupadd www \
&& useradd -g www -s /sbin/nologin www \
&& yum install vim -y

# Config
RUN cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
echo "${TIMEZONE}" > /etc/timezone

# Copy
COPY nginx.conf /etc/nginx/nginx.conf
COPY www.conf /etc/php-fpm.d/www.conf
COPY php.ini /etc/php.ini
RUN mkdir /run/php-fpm && rm /usr/share/nginx/html/* -rf
ADD upload/ /usr/share/nginx/html/
COPY run.sh /mnt/run.sh
RUN chmod 755 /mnt/run.sh
RUN chmod -R 777 /usr/share/nginx/html/data
RUN chmod -R 777 /usr/share/nginx/html/config
RUN chmod -R 777 /usr/share/nginx/html/uc_client/data
RUN chmod -R 777 /usr/share/nginx/html/uc_server/data

EXPOSE 80
CMD ["/mnt/run.sh"]