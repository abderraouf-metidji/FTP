#!/bin/bash

cd /home/abdou
while IFS="," read Id Nom Prenom Mdp Role User
do
varname="$User"
varpassword="$Mdp"
vargroup="$Role"

getent group $vargroup >/dev/null || groupadd $vargroup

useradd -m -g $vargroup $varname -s /bin/bash

chpasswd <<< "$varname:$varpassword"

mkdir /home/$varname
mkdir /ftp/$varname
mkdir /ftp/$varname/document
chown -R proftpd:nogroup /ftp/$varname/
chmod 555 /ftp/$varname
chmod 777 /ftp/$varname/document
done < Shell_Userlist.csv
