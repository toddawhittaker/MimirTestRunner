#!/bin/bash
wget -q https://raw.githubusercontent.com/toddawhittaker/MimirTestRunner/master/hamcrest-core-1.3.jar
wget -q https://raw.githubusercontent.com/toddawhittaker/MimirTestRunner/master/junit-4.13.jar
wget -q https://raw.githubusercontent.com/toddawhittaker/MimirTestRunner/master/MimirTestRunner.java

export CLASSPATH=.
count=$(find . -type f -name "*.jar" 2>/dev/null | wc -l)
if [ "$count" != 0 ]
then 
  for filename in ./*.jar; do
    export CLASSPATH=${CLASSPATH}:${filename}
  done
fi

javac ./*.java;

if [ $? -ne 0 ]; then
  echo 0 > OUTPUT
  exit 1
fi

if [ -f "RunMe.class" ]; then
    java RunMe > DEBUG
fi

java MimirTestRunner >> DEBUG
status=$?
if [ $status -gt 100 ]; then
  echo 0 > OUTPUT
else
  echo $status > OUTPUT
fi
