FROM ubuntu:16.04

RUN apt update &&\
  apt install lsb-release -y &&\
  bash -c 'echo "deb http://repo.xplico.org/ $(lsb_release -s -c) main" >> /etc/apt/sources.list' &&\
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 791C25CE &&\
  apt update &&\
  DEBIAN_FRONTEND=noninteractive apt install xplico --fix-missing -y &&\
  apt autoremove &&\
  apt autoclean

EXPOSE 9876

CMD ["/bin/bash", "-c", "service apache2 start && sleep 3 && /etc/init.d/xplico start && tail -F /var/log/apache2/*"]
