#
# Dockerfile 
#FROM mrunalp/centos-jbossas
FROM jboss/wildfly

MAINTAINER Juan Carlos Garcia Pelaez



# CODE for generate temporary usr/pwd files
# ADD http://central.maven.org/maven2/org/kie/kie-drools-wb-distribution-wars/6.0.1.Final/kie-drools-wb-distribution-wars-6.0.1.Final-jboss-as7.0.war /tmp

 
RUN chmod +r /opt/wildfly/standalone/deployments/ && \
#	curl -L http://central.maven.org/maven2/org/kie/kie-drools-wb-distribution-wars/6.0.1.Final/kie-drools-wb-distribution-wars-6.0.1.Final-jboss-as7.0.war > \
	curl -L  http://repo1.maven.org/maven2/org/kie/kie-drools-wb-distribution-wars/6.1.0.Final/kie-drools-wb-distribution-wars-6.1.0.Final-wildfly.war   > \
		 /opt/wildfly/standalone/deployments/drools-workbench.war

ADD wildfly-config/standalone.xml /opt/wildfly/standalone/deployments/	 