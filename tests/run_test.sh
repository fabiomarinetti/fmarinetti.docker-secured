#!/bin/bash

die() {
  echo "ERROR: $1" >&2
  exit 1
}

#run_test() {
#  local platform=$1
#  local t=0
#  mkdir -p results/$platform
#  for test in firstrun idempotence; do
#    nohup (ansible-playbook -i inventory --extra-vars "platform=$platform" test.yml \
#       	  && touch results/$test.OK \
#	  || $test.KO) &>results/$platform/$test.log &
#    while [ -n "$(pgrep -f platform=$platform)" -a $t -lt $TIMEOUT ]; do 
#      sleep $SLEEPTIME
#      t=$(( $t + $SLEEPTIME ))
#    done
#    [ $t -le $TIMEOUT ] || die "timeout occurred for $platform $test"
#    if [ -e results/$platform/$test.KO ]; then
#      cat result/$platform/$test.log | sed s/^/"$platform \-\-\- "/	  
#      die "$platform $test: FAILURE"
#    else
#      echo "$platform $test: SUCCESS"  
#    fi  
#  done
#}

SLEEPTIME=10
TIMEOUT=30
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

# test role execution and idempotency
echo "run convergence test"
py.test -v converge.py
[ $? -eq 0 ] || die "one or more convergence tests failed"

echo "run verification test"
py.test -v --ansible-inventory=inventory --hosts='ansible://all' verify.py
[ $? -eq 0 ] || die "one or more verification tests failed"

exit 0
