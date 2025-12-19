# Use the official Tomcat base image (version 9)
FROM tomcat:9.0

# Create a custom webapp folder inside Tomcat
RUN mkdir -p /usr/local/tomcat/webapps/openedition

# Copy your site files into the openedition folder
COPY index.html /usr/local/tomcat/webapps/openedition/
COPY style.css /usr/local/tomcat/webapps/openedition/

# Expose Tomcat's default port
EXPOSE 8080

# Start Tomcat when the container runs
CMD ["catalina.sh", "run"]
