#
# Dockerfile 
FROM jboss/wildfly

MAINTAINER Juan Carlos Garcia Pelaez


# CODE for generate temporary usr/pwd files
# ADD http://central.maven.org/maven2/org/kie/kie-drools-wb-distribution-wars/6.0.1.Final/kie-drools-wb-distribution-wars-6.0.1.Final-jboss-as7.0.war /tmp
ADD wildfly-config/standalone.xml /opt/wildfly/standalone/deployments/
 
RUN wget http://central.maven.org/maven2/org/kie/kie-drools-wb-distribution-wars/6.0.1.Final/kie-drools-wb-distribution-wars-6.0.1.Final-jboss-as7.0.war 
 cp kie-drools-wb-distribution-wars-6.0.1.Final-jboss-as7.0.war /opt/wildfly/standalone/deployments/drools-workbench.war  
 rm kie-drools-wb-distribution-wars-6.0.1.Final-jboss-as7.0.war 