FROM ubuntu:18.04

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install nano -y
RUN apt-get install apache2 -y

RUN a2enmod rewrite

CMD service apache2 start && tail -f /dev/null