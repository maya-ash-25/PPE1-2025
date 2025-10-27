##!/usr/bin/bash

if [ $# -ne 1 ]
then 
	echo "Un argument est demandé"
	exit 1

fi

Fichier_urls="$1"
Num_ligne=0

while read -r line;
do
	Num_ligne=$(expr $Num_ligne + 1)

	code=$(curl -s -o /dev/null -w "%{http_code}" "$line")

	encodage=$(curl -s -I "$line" | grep -i "content-type" | grep -o -E "charset=[^ ]+" | tr -d '\r\n' | cut -d= -f2)
    if [ -z "$encodage" ] 
		then
			encodage="not mentionned"
	fi 
	nb_mots=$(curl -s $line | wc -w)



	echo -e "${Num_ligne}\t${line}\t${code}\t${encodage}\t${nb_mots}\n" # -e permet de ne pas interpréter "\" comme un moyen pour échapper le scaractères spéciaux

	sleep 1
	
done < $Fichier_urls;

