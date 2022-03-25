FROM golang:latest
RUN addgroup --gid 10001 app
RUN adduser --gid 10001 --uid 10001 \
    --home /app --shell /sbin/nologin \
    --disabled-password app

COPY bin/deployer /app/
RUN mkdir /app/deploymentTests
ADD deploymentTests /app/deploymentTests/

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install jq
RUN apt-get -y install postgresql-client
RUN apt-get -y install zip
RUN apt-get -y install python
RUN apt-get -y install python3
RUN apt-get -y install sudo
RUN echo "howdy"
RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
RUN unzip awscli-bundle.zip
RUN python --version
RUN alias python=python3
RUN python --version
RUN sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
RUN sudo python awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

USER app
EXPOSE 8080
WORKDIR /app
CMD /app/deployer
