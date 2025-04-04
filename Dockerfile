# Use an official JDK image as the base
FROM openjdk:17-jdk-slim

# Set environment variables
ENV DEVOPS_NAME=Anton
ENV MAVEN_VERSION=3.9.6
ENV JAVA_HOME=/usr/local/openjdk-17
ENV PATH="$JAVA_HOME/bin:$PATH"

# Install dependencies
RUN apt update && apt install -y wget tar

# Install Maven (to /opt/maven)
RUN wget https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
    && tar -xzf apache-maven-${MAVEN_VERSION}-bin.tar.gz -C /opt \
    && ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven \
    && rm apache-maven-${MAVEN_VERSION}-bin.tar.gz

# Set Maven environment variables (after installing it)
ENV MAVEN_HOME=/opt/maven
ENV PATH=$MAVEN_HOME/bin:$PATH

# Set working directory inside the container
WORKDIR /app

# Copy the application source code into the container
COPY . .

# Build the application using Maven
RUN mvn clean package -DskipTests

# Expose the application port
EXPOSE 8080

# Run the Spring Boot application
CMD ["java", "-jar", "target/docker-0.0.1-SNAPSHOT.jar"]


