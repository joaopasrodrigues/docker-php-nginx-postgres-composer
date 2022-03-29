#!/bin/sh

if [ "${GIT_REPO}" = "" ]; then
  echo "Please provide a GIT_REPO environment variable"
fi

if [ "${GIT_BRANCH}" = "" ]; then
  echo "Defaulting GIT_BRANCH to 'master'"
  GIT_BRANCH="master"
fi

if [ "${ENVIRONMENT}" = "" ]; then
  echo "Defaulting ENVIRONMENT to 'DEV'"
  ENVIRONMENT="dev"
fi

#PREPARE PROJECT

echo "Cloning ${GIT_REPO} branch:${GIT_BRANCH} to /src"

GIT_SSH_COMMAND="ssh -i  ~/.ssh/gitlab.id_rsa -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" \
  git clone ${GIT_REPO} --branch ${GIT_BRANCH}

if [ "$ENVIRONMENT" != "PROD" ]; then
  echo "Downloading dump to /initdb.sql"

  DBDUMP_FILE=$(curl http://int2.youbeep.com/dbdumps/ | grep lite | awk -F "\"" '{print "http://int2.youbeep.com/dbdumps/"$2}' ) && \
    curl $DBDUMP_FILE -o /initdb.sql ;
fi
