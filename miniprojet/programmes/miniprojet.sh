#!/usr/bin/bash

if [ $# -ne 1 ]
then
    echo "Un argument est demandé"
    exit 1
fi

Fichier_urls="$1"
Num_ligne=0

echo "<!DOCTYPE html>"
echo "<html lang=\"fr\">"
echo "<head>"
echo "    <meta charset=\"UTF-8\">"
echo "    <title>Tableau des URLs - Projet Robot</title>"
echo "    <link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bulma@1.0.4/css/bulma.min.css\">"
echo "    <style>"
echo "      body { background: #f8f5f2; color: #2d170f; }"
echo "      .box { background: #fffdfa; border-radius: 0.75rem; border: 1px solid #e3dfd9; padding: 1.5rem; margin: 2rem auto; max-width: 90%; }"
echo "      table.table.is-bordered, table.table.is-bordered th, table.table.is-bordered td {"
echo "        border: 2px solid #7a4f24;"
echo "      }"
echo "      thead { background-color: #bfae99; color: #0d2543; }"
echo "      tbody tr:hover { background-color: #0d2543; color: white; cursor: pointer; }"
echo "    </style>"
echo "</head>"
echo "<body>"
echo "  <section class=\"section\">"
echo "    <div class=\"container box\">"
echo "      <h1 class=\"title has-text-centered\">Tableau des URLs analysées</h1>"
echo "      <table class=\"table is-fullwidth is-hoverable is-bordered\">"
echo "        <thead>"
echo "          <tr>"
echo "            <th>Numéro</th>"
echo "            <th>URL</th>"
echo "            <th>Code HTTP</th>"
echo "            <th>Encodage</th>"
echo "            <th>Nombre de mots</th>"
echo "          </tr>"
echo "        </thead>"
echo "        <tbody>"

while read -r line;
do
    Num_ligne=$(expr $Num_ligne + 1)
    code=$(curl -I -L -s -o /dev/null -w "%{http_code}" "$line")
    encodage=$(curl -I -L -s "$line" | grep -i "content-type" | grep -o -E "charset=[^ ]+" | tr -d '\r\n' | cut -d= -f2 | head -n 1)
    if [ -z "$encodage" ]; then
        encodage="not mentionned"
    fi
    nb_mots=$(lynx -dump -nolist "$line" | wc -w)

    echo "          <tr>"
    echo "            <td>${Num_ligne}</td>"
    echo "            <td><a href=\"${line}\">${line}</a></td>"
    echo "            <td>${code}</td>"
    echo "            <td>${encodage}</td>"
    echo "            <td>${nb_mots}</td>"
    echo "          </tr>"

    sleep 1
done < "$Fichier_urls"

echo "        </tbody>"
echo "      </table>"
echo "    </div>"
echo "  </section>"
echo "</body>"
echo "</html>"
