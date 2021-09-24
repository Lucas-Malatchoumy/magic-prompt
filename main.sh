#!/bin/bash

main() {
  echo -n "Login : "
  read login
  echo -n "Password : "
  read -s password
  echo ${login} ${password}
  if [ "$login" != "lucas" ] || [ "$password" != "test1" ]; then
    echo "Invalid login or password"
    exit
  fi
  echo "You can start";
    exit
}
main