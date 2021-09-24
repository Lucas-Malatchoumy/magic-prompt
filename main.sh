#!/bin/bash
AGE="Age : 20 ans"
FIRSTNAME="Firstname : lucas"
LASTNAME="Lastname : malatchoumy"
EMAIL="Email : malatchoumylucas@gmail.com"
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
age() {
  echo "Enter your age"
  read age
  re='^[0-9]+$'
  if ! [[ $age =~ $re ]] ; then
    echo "error: Not a number" >&2; exit 1
  fi
  if [ $age -lt 18 ]; then
    echo "You are minor"
  else
    echo "You are major"
  fi
}
profile() {
  echo "$AGE"
  echo "$FIRSTNAME"
  echo "$LASTNAME"
  echo "$EMAIL"
}
passw() {
  echo "Enter your first password :"
  read -s password1
  if [ "$password1" != "$password" ]; then
    printf "${RED}It's not the same password${NC}\n"
    exit
  else
    printf "${GREEN}Correct password${NC}\n"
    echo "Enter your new password"
    read -s password2
    echo "Confirm your new password"
    read -s password3
  if [ "$password3" != "$password2" ]; then
    printf "${RED}You don't right the same password${NC}\n"
    exit
  else
    printf "${GREEN}You have a new passord${NC}\n"
    password=${password2}
    echo ${password}
  fi
  fi
}
changefile() {
  cd "${commande[1]}"
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
    age ) age;;
    profile ) profile;;
    passw ) passw;;
    cd ) changefile "${commande[1]}";;
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