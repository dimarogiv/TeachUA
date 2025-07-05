FROM ubuntu/jre:17_edge
COPY dev.war /ROOT.war
ENTRYPOINT ["/usr/bin/java", "-jar"]
CMD ["/ROOT.war"]
EXPOSE 8080/tcp
