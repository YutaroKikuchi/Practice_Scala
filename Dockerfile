FROM ubuntu:16.04
MAINTAINER YutaroKikuchi

RUN mkdir -p /usr/local/src/
WORKDIR /usr/local/src/

RUN apt-get update
RUN apt-get install -y vim \
	curl \
	git \
	wget \
	unzip \
	sudo \
	tar

RUN apt-get install -y openjdk-8-jdk

RUN apt-get install -y python3-dev python3 python3-pip python3-pip python3-tk
RUN pip3 install pip --upgrade

RUN pip3 install jupyter

RUN apt-get install -y scala

RUN curl -L -o coursier https://git.io/vgvpD && chmod +x coursier && ./coursier --help

# Enables X11 sharing and creates user home directory
ENV USER_NAME practice_scala
ENV HOME_DIR /home/$USER_NAME
#
# Replace HOST_UID/HOST_GUID with your user / group id (needed for X11)
ENV HOST_UID 1000
ENV HOST_GID 1000

RUN export uid=${HOST_UID} gid=${HOST_GID} && \
	mkdir -p ${HOME_DIR} && \
	echo "$USER_NAME:x:${uid}:${gid}:$USER_NAME,,,:$HOME_DIR:/bin/bash" >> /etc/passwd && \
	echo "$USER_NAME:x:${uid}:" >> /etc/group && \
	echo "$USER_NAME ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER_NAME && \
	chmod 0666 /etc/sudoers.d/$USER_NAME && \
	chown ${uid}:${gid} -R ${HOME_DIR}

USER ${USER_NAME}
WORKDIR ${HOME_DIR}

COPY jupyter-scala .
RUN bash jupyter-scala

RUN mkdir .jupyter
COPY jupyter_notebook_config.py ./.jupyter
RUN mkdir src

CMD ["/bin/bash"]