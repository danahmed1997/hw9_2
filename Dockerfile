FROM golang:latest
RUN addgroup --gid 10001 app
RUN adduser --gid 10001 --uid 10001 \
    --home /app --shell /sbin/nologin \
    --disabled-password app

COPY bin/deployer /app/
RUN mkdir /app/deploymentTests
ADD deploymentTests /app/deploymentTests/

RUN echo "installing pineapple"
#RUN sudo mount -o remount,exec /tmp
RUN alias go='TMPDIR=~/tmp go'
RUN export TMPDIR=~/tmp/
RUN go install github.com/jvehent/pineapple@latest
#RUN go get -u github.com/jvehent/pineapple
RUN which pineapple
RUN pineapple -V
#RUN pineapple -c config.yml
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
RUN python3 --version
RUN which python3
RUN alias python=python3
RUN alias python='/usr/bin/python3'
RUN python --version
RUN sudo apt-get -y install python3-venv
RUN sudo '/usr/bin/python3' awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

USER app
EXPOSE 8080
WORKDIR /app
CMD /app/deployer
