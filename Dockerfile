FROM ubuntu:20.04
ENV TZ=Europe/Warsaw
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install packages
RUN apt-get update
RUN apt-get install -yy \
	build-essential \
	git \
	wget \
	curl \
	unzip \
	zip

# Install node
RUN curl -sl https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs
RUN echo "NODE Version:" && node --version
RUN echo "NPM Version:" && npm --version
RUN npm i react

RUN useradd -ms /bin/bash george2times
RUN adduser george2times sudo

EXPOSE 8080
USER george2times

RUN mkdir /home/george2times/aplikacja
WORKDIR /home/george2times/aplikacja
CMD cd /home/george2times/aplikacja && npm start
