#!/bin/bash
BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'
liste() {
  ls ${commande[1]}
}
remove_file() {
  if [ -e ${commande[1]} ]; then
    rm ${commande[1]}
    echo "Your file ${commande[1]} has been deleted"
  else
    echo "Your file ${commande[1]} doesn't exist"
  fi
}
remove_folder() {
  if [ -e ${commande[1]} ]; then
    rm -r ${commande[1]}
    echo "Your folder ${commande[1]} has been deleted"
  else
    echo "Your folder ${commande[1]} doesn't exist"
  fi
}
cmd() {
  while [ 1 ]; do
    printf "${BLUE}Enter your command : ${NC}"
    read cmd
    commande=($cmd)
    case "${commande[0]}" in
    ls ) liste "${commande[1]}";;
    rm ) remove_file "${commande[1]}" ;;
    rmd | rmdir ) remove_folder "${commande[1]}";;
    version | --v | vers ) echo "prompt v1.0";;
    about ) echo "It's a prompt program with wich you can execute different commands in bash.";;
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