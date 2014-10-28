#
# Dockerfile

FROM jgpelaez/docker-jbossas-7
MAINTAINER Juan Carlos Garcia Pelaez <juancarlosgpelaez@gmail.com>

# This configuration is used for environments with proxy, 
# replaced by build.sh for the proxy env
#PROXYCONF1_HTTP
#PROXYCONF2_HTTPS

ADD jboss-as-config/standalone.xml /opt/jboss-as/standalone/configuration/

ENV DROOLS_WB_VERSION 6.1.0.Final

# add user to jboss \
# see https://docs.jboss.org/author/display/AS71/add-user+utility \
# WARNING echo doesn't work in concatenations in the Dockerfile 
RUN chmod +r /opt/jboss-as/standalone/deployments/ && \
	bash /opt/jboss-as/bin/add-user.sh --silent=true -a admin welcome1 	&& \
	sed -i "\$aadmin=admin" /opt/jboss-as/standalone/configuration/application-roles.properties && \
	curl -L http://central.maven.org/maven2/org/kie/kie-drools-wb-distribution-wars/$DROOLS_WB_VERSION/kie-drools-wb-distribution-wars-$DROOLS_WB_VERSION-jboss-as7.0.war > \
		/opt/jboss-as/standalone/deployments/drools-wb.war 
 
# Expose the ports we're interested in
EXPOSE 8080 9990

CMD ["/opt/jboss-as/bin/standalone.sh", "-b", "0.0.0.0"]