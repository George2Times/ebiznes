FROM ubuntu:20.04
ENV TZ=Europe/Warsaw
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install packages
RUN apt-get update
RUN apt-get install -yy \
	build-essential \
	git \
	wget \
	curl \
	unzip \
	zip \
	sudo

# Install node
RUN curl -sl https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs
RUN echo "NODE Version:" && node --version
RUN echo "NPM Version:" && npm --version
RUN npm i react

# Install Kotlin
RUN sudo apt-get install -y openjdk-11-jdk
RUN curl -s https://get.sdkman.io | bash
RUN chmod a+x "$HOME/.sdkman/bin/sdkman-init.sh"
RUN source "$HOME/.sdkman/bin/sdkman-init.sh" && sdk install kotlin

# Download Go 1.2.2 and install it to /usr/local/go
RUN curl -s https://storage.googleapis.com/golang/go1.2.2.linux-amd64.tar.gz| tar -v -C /usr/local -xz

# Install Gradle
RUN wget https://services.gradle.org/distributions/gradle-6.4.1-bin.zip -P /tmp
RUN sudo unzip -d /opt/gradle /tmp/gradle-*.zip

# Install ktlint
RUN curl -sSLO https://github.com/pinterest/ktlint/releases/download/0.45.0/ktlint && chmod a+x ktlint

# Add user and workdir
RUN useradd -ms /bin/bash george2times
RUN adduser george2times sudo
EXPOSE 8080
USER george2times
RUN mkdir /home/george2times/aplikacja
WORKDIR /home/george2times/aplikacja
CMD cd /home/george2times/aplikacja && npm start

