#!/bin/sh

# Give chance for Tomcat to fire up
nc -z -w300 127.0.0.1 8080
for i in {1..5}; do curl -o /dev/null http://127.0.0.1:8080/sample/index.html && break || \
(echo sleeping 15... && sleep 15); done

# Grab index from local tomcat server and compare the file with what is known to be expected
# If there is no difference, both diff and cmp exit with code 0
# If there is a difference, script will exit with 1, i.e., error out

curl -o ./.github/testScripts/actual.html http://127.0.0.1:8080/sample/index.html && \
diff ./.github/testScripts/expected.html ./.github/testScripts/actual.html && \
cmp ./.github/testScripts/expected.html ./.github/testScripts/actual.html && \
echo Tomcat Server OK
