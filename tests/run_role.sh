#!/bin/bash

die() {
  echo "ERROR: $1" >&2
  exit 1
}

BASEDIR=$(pwd)/..
SSH_USER=$( [ -n "${SSH_USER}" ] && echo ${SSH_USER} || echo "johndoe" )

# Main logic
[ $# -eq 1 ] || die "wrong number of arguments [$#]" 
role_name=$1

BASEDIR=$(pwd)/..

rm -rf roles/$role_name
mkdir -pv roles/$role_name
cp -r $BASEDIR/defaults \
      $BASEDIR/handlers \
      $BASEDIR/meta \
      $BASEDIR/molecule \
      $BASEDIR/tasks \
      $BASEDIR/vars \
      $BASEDIR/files \
      $BASEDIR/templates \
      $BASEDIR/README.md roles/$role_name

cd $BASEDIR/terraform && terraform output inventory > $BASEDIR/tests/inventory && cd - &>/dev/null
[ $? -eq 0 ] || die "a problem occurred in generating inventory"

ansible-playbook -i inventory test.yml
[ $? -eq 0 ] || die "role execution failed"

exit 0
