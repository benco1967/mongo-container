# Install MongoDB 3.6 on debian
FROM debian:jessie
MAINTAINER Benoit Chanclou <benoit.chanclou@tactilia.fr>
RUN apt-get update
RUN apt-get install -y gnupg netcat pwgen
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
RUN echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.4 main" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list
RUN apt-get update
RUN apt-get install -y mongodb-org
#RUN service mongod stop
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# will start mongodb with db in /data which will be exposed
RUN mkdir /data

#add scripts to restore fidbe data at first start
ADD scripts /scripts
RUN chmod +x /scripts/*.sh
RUN touch /scripts/.firstrun

# Command to run
ENTRYPOINT ["/scripts/run.sh"]
CMD [""]

# Expose listen port
EXPOSE 27017
EXPOSE 28017

# Expose our data volumes
VOLUME ["/data"]
