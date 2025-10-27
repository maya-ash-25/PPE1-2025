# Journal de bord du projet encadré
##
## Pour m'entrainer à la mise en application des commandes vues en cours, j'ai essayé de reproduire les étapes faites en cours en créant un fichier test nommé essai-2---PPE1. Pour cela j'ai utilisé la commande git clone suivie de l'url ssh du fichier. Après cela, je suis allée dans le fichier avec la commande cd. Pour apporter des modifications j'ai utilisé [ echo .... >> README.md]. Pour cette commande je n'ai pas compris si ce qu'on écrivait  entre  seraient les modifications qui allaient apparaitre sur le fichier, après l'utilisation de la commande git push. Par ailleurs, la deuxième difficulté que j'ai rencontré, c'est de ne pas savoir ce que je devais mentionner entre  lors de la commande git commit -m .... Malgré ces incompréhensions, j'ai tout de même réussie à refaire toutes les étapes à la maison, puis j'ai entamé les exercices pour refaire les mêmes commandes
Après avoir relu et refait les commandes à plusieurs reprises, je suppose que ce qu'on écrit entre  dans la commande git commit -m ..., n'est que le nom qu'on donne au add, mais je ne suis pas sûre. En conclusion, j'ai pu reproduire toutes les commandes pour manipuler les fichiers, mettre à jour les versions, apporter des modifications.
Pour la création du tag : - j'ai utilisé la commande git tag -a -m version finie intro git gitinto [Modification journal]. J'ai eu en résultat too many arguments. Finalement, j'ai enlevé [Modification journal] et ça a fonctionné. POur vérifier si le tag a bien été créé j'ai fais <git tag>, ce qui m'a affiché le nom du tag gitinto. Il ne reste plus qu'à mettre <git push origin gitinto>

#Le miniprojet :

Pour l'exercice 1 : 

Le script de départ fourni se contentait de lire le fichier nommé «fr.txt» ligne par ligne et d’afficher son contenu. L’objectif était de le modifier pour le rendre plus flexible pour passer le nom du fichier contenant les URLs comme paramètre, ajouter la condition que l'utilisateur a bien fourni un argument (sinon il verra un message d'erreur s'afficher) , et afficher chaque URL précédé de son numéro de ligne et séparé par une tabulation.


- j’ai d’abord ajouté une vérification d’argument pour que le script s’assure qu’un fichier d’entrée est bien donné au moment de son exécution. Pour cela, j’ai utilisé <if> et j'ai utilisé la variable $# qui indique le nombre d’arguments passés au script. Si ce nombre n’est pas égal à 1, le script affiche un message d’erreur "Un argument est demandé"
- j'ai remplacé le chemin du fichier par une variable qui récupère le premier argument , quand on exécute le script
- On n'utilise pas cat car elle risque de causer quelques problèmes , elle afficherait le contenu d'un coup or qu'avec read on l'affiche ligne par ligne, ce qui nous permet aussi de numéroter les URLs.
- Pour numéroter les lignes j'ai mis un compteur à 0 avant la boucle , puis dans la boucle on l'incrémente avec +1 grâce à expr (comme vu en cours). Puis, j'ai utilisé une option -e que j'ai trouvé en recherchant sur internet, celle-ci permet d'interpréter le caractère spécial \t, qui correspond à une tabulation. Cela permet d’afficher chaque ligne sous la forme : numéro de ligne, tabulation, puis contenu de la ligne. C'est apparemment -e, qui permet de ne pas l'interpréter comme une chaine de caractère.
- J'ai exécuté en premier lieu : le script répondant à l'exercice 1, et il a fonctionné après deux corrections : 
            -J'avais changé le nom d'un variable Num-ligne par Num-line ce qui n'a pas permit d'afficher le numéro de ligne , le numéro 0 s'affichait à chaque ligne.
            - J'ai oublié de mettre $ devant l'argument , ce qui a empéché d'appeler le fichier fr.txt



Pour l'exercice 2 :

Au départ, j'ai écrit un premier code :

Pour la récupération du code HTTP et du content-type jai écrit : code=$(curl -s -I -L -w "\n%{http_code}\t%{content_type}\n" "$line") :

"code" contient donc à la fois le code HTTP et le type de contenu, ce qui est pratique pour vérifier si la page est accessible et pour connaître son encodage. Mais cela m'a causé un problème plus tard.

- pour compter le nombre de mots, j'ai fait :

nb_mots=$(lynx -dump -nolist "$line" | wc -w) 
- j'ai utilisé -dump et -nolist (vus en cours) pour afficher le contenu textuel et retirer la liste des liens. Puis wc -w pour compter compte le nombre de mots dans le texte extrait.

J'ai ensuite affiché le resultat avec :  echo -e "${Num_ligne}\t${line}\t${codes}\t${nb_mots}\n"

Lors de l'exécution du script, je me suis rendu compte que le résultat du fichier .tsv n'était pas du tout clean et on arrivait pas à identifier les informations, clairement. D'après mes recherche c'est parce que j'ai utilisé l'option -I qui a fait apparaitre tous les headers dans le resultat, sur le terminal.

Comme solution, j'ai essayé de récupérer le code http et l'encodage en deux étapes. J'ai donc réécris la version final de mon script qui a finalement fonctionné. Pour cela , j'ai utilisé code=$(curl -s -o /dev/null -w "%{http_code}" "$line"). curl et les options -s et -w m'ont permis de récupérer le code réponse HTTP
Pour détecter l'encodage, j'ai utilisé curl avec les options -s et -I qui récupère les en-têtes HTTP, puis avec j'ai filtré avec grep et cut.

Enfin, pour compter le nombre de mots, j'ai utilisé la commande wc vue en cours avec l'option -w.

Pour la redirection des résultats, je l'ai fait depuis le terminal, en écrivant <./miniprojet.sh ../urls/fr.txt > ../tableaux/tableau-fr.tsv , avec un seul chevron ce qui a créé le fichier , étant donné qu'il n'existait pas.
>


