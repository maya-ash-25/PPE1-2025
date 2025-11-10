##!/usr/bin/bash

if [ $# -ne 1 ]
then 
	echo "Un argument est demandé"
	exit 1

fi

Fichier_urls="$1"
Num_ligne=0

echo "<!DOCTYPE html>"
echo "<html>"
echo "<head>"
echo "    <meta charset="UTF-8">"
echo "    <title>Tableau des URLs - Projet Robot</title>"
echo "</head>"
echo "<body>"
echo "    <h1>Tableau des URLs analysées</h1>"
echo "    <table border="1">"
echo "        <tr>"
echo "            <th>Numéro</th>"
echo "            <th>URL</th>"
echo "            <th>Code HTTP</th>"
echo "            <th>Encodage</th>"
echo "            <th>Nombre de mots</th>"
echo "        </tr>"

while read -r line;
do
	Num_ligne=$(expr $Num_ligne + 1)

	code=$(curl -I -L -s -o /dev/null -w "%{http_code}" "$line")

	encodage=$(curl -I -L -s "$line" | grep -i "content-type" | grep -o -E "charset=[^ ]+" | tr -d '\r\n' | cut -d= -f2 | head -n 1)
    if [ -z "$encodage" ] 
		then
			encodage="not mentionned"
	fi 
	nb_mots=$(lynx -dump -nolist "$line" | wc -w)

	echo "        <tr>"
    echo "            <td>${Num_ligne}</td>"
    echo "            <td>${line}</td>"
    echo "            <td>${code}</td>"
    echo "            <td>${encodage}</td>"
    echo "            <td>${nb_mots}</td>"
    echo "        </tr>"



	sleep 1
	
done < $Fichier_urls;

echo "    </table>"
echo "</body>"
echo "</html>"

