FROM centos:latest
LABEL Maintainer=Suhas Email=suhasw91@gmail.com
RUN yum install -y httpd\
zip\
unzip
ADD https://www.free-css.com/assets/files/free-css-templates/download/page267/solitude.zip /var/www/html/
WORKDIR /var/www/html/
RUN unzip solitude.zip
RUN cp -rvf solitude/*
CMD ["usr/sbin/httpd", "D", "FOREFROUND"]
EXPOSE 80
