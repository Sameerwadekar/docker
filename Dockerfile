# STEP 1: Build stage (uses Maven + Java to compile the project)
FROM maven:3.9-eclipse-temurin-21 AS build
# 👉 Start from an image that already has Maven + Java 21 installed
# 👉 Name this stage "build" so we can use it later

WORKDIR /app
# 👉 Set working directory inside container to /app
# 👉 All commands will run from here

COPY pom.xml .
# 👉 Copy pom.xml from your computer into container (/app)
# 👉 Maven needs this file to understand project dependencies

COPY src ./src
# 👉 Copy your Java source code into container
# 👉 Now /app/src contains your project code

RUN mvn clean package
# 👉 Run Maven build inside container
# 👉 clean = remove old builds
# 👉 package = compile Java + create JAR file
# 👉 Output will be inside: /app/target/

# ------------------------------------------------------

# STEP 2: Runtime stage (lightweight final image)
FROM eclipse-temurin:21
# 👉 Start a fresh image with only Java 21 (no Maven)
# 👉 This keeps final image small and fast

WORKDIR /app
# 👉 Set working directory in final container

COPY --from=build /app/target/*.jar app.jar
# 👉 Copy JAR file from FIRST stage (build stage)
# 👉 Take compiled output and put it as app.jar

CMD ["java", "-jar", "app.jar"]
# 👉 Command that runs when container starts
# 👉 This runs your Java application


#docker build -t my-java-app .
#docker run -p 8001:8001 my-java-app