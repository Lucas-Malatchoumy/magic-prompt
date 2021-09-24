#!/bin/bash
BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'
liste() {
  ls ${commande[1]}
}
cmd() {
  while [ 1 ]; do
    printf "${BLUE}Enter your command : ${NC}"
    read cmd
    commande=($cmd)
    case "${commande[0]}" in
    ls ) liste "${commande[1]}";;
    quit ) exit;;
    esac
  done
}
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
   cmd
    exit
}
main