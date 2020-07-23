FROM tomcat:8-jre8
MAINTAINER G Murali Krishna Reddy
RUN rm -rf /usr/local/tomcat/webapps/*
COPY ./gameoflife-web/target/*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
HEALTHCHECK --interval=5m --timeout=3s --retries=3 \
      CMD curl -f http://localhost:8080 || exit
