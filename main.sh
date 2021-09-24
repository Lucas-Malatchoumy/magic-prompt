#!/bin/bash
AGE="Age : 20 ans"
FIRSTNAME="Firstname : lucas"
LASTNAME="Lastname : malatchoumy"
EMAIL="Email : malatchoumylucas@gmail.com"
BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'
help() {
 printf "${GREEN}help${NC} : show commands you can use
${GREEN}ls${NC} : show files and hidden files
${GREEN}rm${NC} : delete file
${GREEN}rmd ou rmdir${NC} : delete folder
${GREEN}about${NC} : program description
${GREEN}version ou --v ou vers${NC} :  program version
${GREEN}age${NC} : Ask your age and tell you if you are major or minor
${GREEN}quit${NC} : quit the program
${GREEN}profile${NC} : show your personal informations : First Name, Last name, age, email
${GREEN}passw${NC} : change your password with confirmation
${GREEN}cd${NC} : go to a new folder or come back to a previous folder
${GREEN}pwd${NC} : show you the repository
${GREEN}hour${NC} : show the hour
${GREEN}*${NC} : Invalid command
${GREEN}httpget${NC} :  download html source code of web page and save in a new file. Ask the name of the file
${GREEN}smtp${NC} : send a mail with the mail adress, the subject and the text
${GREEN}open${NC} : open file with vim and create it if it doesn't exist\n"
}
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
directory() {
  pwd
}
download_page() {
  echo "Name of file is : "
  read file
  wget ${commande[1]} -O $file
}
open() {
  vim "${commande[1]}"
}
smtp() {
  echo "Enter the recipient :"
  read mail
  echo "Choose the subject :"
  read subject
  echo "Right the text :"
  read text
  echo "$text" | mail -s "$subject" $mail
  echo "Your mail has been sent"

}
cmd() {
  while [ 1 ]; do
    printf "${BLUE}Enter your command : ${NC}"
    read cmd
    commande=($cmd)
    case "${commande[0]}" in
    help ) help;;
    ls ) liste "${commande[1]}";;
    rm ) remove_file "${commande[1]}" ;;
    rmd | rmdir ) remove_folder "${commande[1]}";;
    version | --v | vers ) echo "prompt v1.0";;
    about ) echo "It's a prompt program with wich you can execute different commands in bash.";;
    age ) age;;
    profile ) profile;;
    passw ) passw;;
    cd ) changefile "${commande[1]}";;
    pwd ) directory;;
    hour ) date +"It is %T";;
    httpget ) download_page "${commande[1]}";;
    open ) open "${commande[1]}";;
    smtp ) smtp;;
    quit ) exit;;
    * ) echo "Command Invalid";;
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