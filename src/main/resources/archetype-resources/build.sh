#!/bin/sh
source /home/work/build_script/env/java/jdk_1.8.env
source /home/work/build_script/env/maven/maven-3.5.3.env
#编译系统中没有线上的8u144版本，先采用8u131编译
export JAVA_HOME=/opt/soft/jdk1.8.0_131
echo $JAVA_HOME
export PATH=$JAVA_HOME/bin:$PATH
set -e
set -x

JOB_ENV=$1
CLUSTER=`python ./deploy/find_name.py ${JOB_ENV} cluster`
SERVICE=`python ./deploy/find_name.py ${JOB_ENV} service`
JOB=`python ./deploy/find_name.py ${JOB_ENV} job`
echo $SERVICE
echo $CLUSTER
echo $JOB

echo $PATH

SCRIPT_DIR=`cd $(dirname $0); pwd -P`
cd ${SCRIPT_DIR}
echo ${SCRIPT_DIR}
echo -----------start maven compile--------------
hostname
mvn -X -U clean package -D${SERVICE}=true -D${CLUSTER}=true appassembler:assemble
mkdir -p release
cp -r deploy target/appassembler/* release