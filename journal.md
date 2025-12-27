# Journal de bord du projet encadré
## 
Pour m'entrainer à la mise en application des commandes vues en cours, j'ai essayé de reproduire les étapes faites en cours en créant un fichier test nommé essai-2---PPE1. Pour cela j'ai utilisé la commande git clone suivie de l'url ssh du fichier. Après cela, je suis allée dans le fichier avec la commande cd. Pour apporter des modifications j'ai utilisé [ echo .... >> README.md]. Pour cette commande je n'ai pas compris si ce qu'on écrivait  entre  seraient les modifications qui allaient apparaitre sur le fichier, après l'utilisation de la commande git push. Par ailleurs, la deuxième difficulté que j'ai rencontré, c'est de ne pas savoir ce que je devais mentionner entre  lors de la commande git commit -m .... Malgré ces incompréhensions, j'ai tout de même réussie à refaire toutes les étapes à la maison, puis j'ai entamé les exercices pour refaire les mêmes commandes
Après avoir relu et refait les commandes à plusieurs reprises, je suppose que ce qu'on écrit entre  dans la commande git commit -m ..., n'est que le nom qu'on donne au add, mais je ne suis pas sûre. En conclusion, j'ai pu reproduire toutes les commandes pour manipuler les fichiers, mettre à jour les versions, apporter des modifications.
Pour la création du tag : - j'ai utilisé la commande git tag -a -m version finie intro git gitinto [Modification journal]. J'ai eu en résultat too many arguments. Finalement, j'ai enlevé [Modification journal] et ça a fonctionné. POur vérifier si le tag a bien été créé j'ai fais <git tag>, ce qui m'a affiché le nom du tag gitinto. Il ne reste plus qu'à mettre <git push origin gitinto>

## Le miniprojet :

### Exercice 1 : 

Le script de départ fourni se contentait de lire le fichier nommé «fr.txt» ligne par ligne et d’afficher son contenu. L’objectif était de le modifier pour le rendre plus flexible pour passer le nom du fichier contenant les URLs comme paramètre, ajouter la condition que l'utilisateur a bien fourni un argument (sinon il verra un message d'erreur s'afficher) , et afficher chaque URL précédé de son numéro de ligne et séparé par une tabulation.


- j’ai d’abord ajouté une vérification d’argument pour que le script s’assure qu’un fichier d’entrée est bien donné au moment de son exécution. Pour cela, j’ai utilisé <if> et j'ai utilisé la variable $# qui indique le nombre d’arguments passés au script. Si ce nombre n’est pas égal à 1, le script affiche un message d’erreur "Un argument est demandé"
- j'ai remplacé le chemin du fichier par une variable qui récupère le premier argument , quand on exécute le script
- On n'utilise pas cat car elle risque de causer quelques problèmes , elle afficherait le contenu d'un coup or qu'avec read on l'affiche ligne par ligne, ce qui nous permet aussi de numéroter les URLs.
- Pour numéroter les lignes j'ai mis un compteur à 0 avant la boucle , puis dans la boucle on l'incrémente avec +1 grâce à expr (comme vu en cours). Puis, j'ai utilisé une option -e que j'ai trouvé en recherchant sur internet, celle-ci permet d'interpréter le caractère spécial \t, qui correspond à une tabulation. Cela permet d’afficher chaque ligne sous la forme : numéro de ligne, tabulation, puis contenu de la ligne. C'est apparemment -e, qui permet de ne pas l'interpréter comme une chaine de caractère.
- J'ai exécuté en premier lieu : le script répondant à l'exercice 1, et il a fonctionné après deux corrections : 
            -J'avais changé le nom d'un variable Num-ligne par Num-line ce qui n'a pas permit d'afficher le numéro de ligne , le numéro 0 s'affichait à chaque ligne.
            - J'ai oublié de mettre $ devant l'argument , ce qui a empéché d'appeler le fichier fr.txt



### Exercice 2 :

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
### Correction miniprojet 1 : 

- J'ai corrigé mon script en : 
                - utilisant lynx à la place de curl pour compter le nombre de mots, ce qui a pris en compte uniquement le corps du texet sans les balises.
                - Ajoutant les options -L -I pour récupérer les en-têtes et suivre les redirections. 
    - Résultat : J'ai obtenu le bon nombre de mots et l'encodage du 3ème url s'est affiché (UTF-8) au lieu de (not mentionned)
- J'ai créé le tag miniprojet-1-revu après avoir fait toutes les modifications.

## Miniprojet 2 : 

### Objectif du miniprojet2 :
Convertir la sortie tabulaire TSV en un tableau HTML afin de pouvoir visualiser les résultats dans un navigateur web.

### Etapes suivies : 

- J’ai modifié le script miniprojet.sh pour produire du HTML à la place du TSV.
- J’ai ajouté la structure HTML complète : DOCTYPE, <head>, <body>.
- J’ai créé un tableau HTML comprenant :
- Un en-tête avec les colonnes : Numéro, URL, Code HTTP, Encodage, Nombre de mots.
- Une ligne par URL analysée.
- J’ai supprimé le fichier TSV du dépôt.
- J’ai généré le fichier tableau-fr.html, qui peut être ouvert dans n’importe quel navigateur.

### Changements par rapport au mini-projet 1

- J’ai remplacé echo -e "...\t..." par des balises HTML <tr> et <td>.
- J’ai ajouté l’en-tête HTML avec l’attribut charset UTF-8.
- J’ai ajouté un titre <h1> pour le tableau.
- J’ai utilisé \border="1\ pour afficher les bordures du tableau.

## Miniprojet 03 : 

### Etapes de réalisation :

- J’ai d’abord créé le fichier index.html sans aucun style comem dans la consigne. Je l’ai ensuite testé en local, mais le lien vers le tableau ne fonctionnait pas à cause d’une erreur dans le chemin. Après correction, la page s’est affichée correctement.

- J’ai ensuite poussé ce premier fichier sur GitHub pour générer la GitHub Page du mini-projet. Le site a bien été déployé, mais à ce stade je n'avais pas modifié les scripts pour qu'un style soit appliqué.

- Par la suite, j’ai commencé à modifier le style de index.html et du script miniprojet.sh. Pour éviter de commettre des erreurs dans les fichiers originaux (c'était très utile, car toutes les erreurs et les difficultés rencontrées , je les ai reglé sur mes fichiers brouillons en amont), j’ai d’abord travaillé sur des copies afin de tester librement différentes idées de mise en forme, en m’appuyant sur les cours html-css et GitHub Pages. C’est à ce moment-là que j’ai ajouté l’appel à Bulma et appliqué les styles que je souhaitais. Par ailleurs, pour obtenir un rendu plus esthétique et harmonisé avec les couleurs que je souhaitais utiliser, j’ai ajouté un CSS personnalisé qui modifie certains styles par défaut de Bulma, notamment :

- Body:
    Ajout d’une couleur de fond personnalisée (#f8f5f2) qui remplace le fond neutre par défaut.

- Section .hero:
    Remplacement du fond original par un dégradé personnalisé.
    Changement de la couleur du texte de la zone héro.
    Cela modifie donc l’apparence standard fournie par Bulma.

- Composant .box:
    Couleur de fond légèrement différente du blanc de Bulma.
    Ajout d’une bordure personnalisée.
    Border-radius augmenté pour arrondir davantage les coins. Cela modifie l’apparence par défaut des boîtes Bulma.

- Boutons (a.button):
    Modification de la couleur de fond.
    Modification de la couleur du texte.
    Style du survol (hover) personnalisé. Ces changements remplacent le style standard des boutons Bulma.

- Sous-titres (.subtitle): Changement de la couleur du texte par défaut des sous-titres pour correspondre à ce que je voulais.

Pour trouver les codes des couleurs que je voulais et du css personnalisé, j'ai cherché sur internet. 

- J’ai rencontré plusieurs difficultés, notamment des problèmes de chemins qui m’empêchaient d’accéder au tableau depuis la page d’accueil. J’ai également repéré quelques erreurs dans les balises HTML que j’ai corrigées dans mes fichiers d’essai, toujours dans le but de ne pas reproduire les mêmes erreurs dans les fichiers présents dans PPE2025.

- Après plusieurs tests, et une fois que j'ai obtenu un style qppréciable et vérifié que tout fonctionnait correctement, j’ai copié le contenu final depuis mes fichiers brouillons vers les fichiers originaux index.html et miniprojet.sh présents dans le dépôt PPE2025. J'ai veillé à adapter les chemins pour qu'ils correspondent à l'arborescence dans PPE2025. J’ai ensuite ré-exécuté le script miniprojet.sh afin de générer le fichier tableau-fr.html avec le style voulu.

- Pour terminer, j’ai commité puis poussé toutes les modifications sur GitHub. Après quelques minutes d’attente, j’ai vérifié le déploiement dans l’onglet Actions, puis j’ai ouvert le lien GitHub Pages pour m’assurer que tout s’affichait correctement et que les pages étaient bien stylées.

## Projet final : 
- J'ai commencé par recherché les liens en fonction des hypothèses émises. A savoir qu'en français, j'ai commencé par trouver des liens du mot "culture" dans le domaine de l'agriculture (contexte1), puis dans l'acception de coutumes et traditions (contexte2), puis dans le sens de culture générale, connaissance du monde (contexte3)
- Ce qui ets intéressant, c'est que j'ai également trouvé des contextes ou le mot culture est en collocation comme dans les articles sur la "culture de masse" dont l'équivalent anglais est "pop culture" c'est bien pour l'analyse comparative des deux langues. 
- J'ai également créé le fichier index html de la page avec une page d'accueil ou on trouve la définition première du mot culture dans chaque langue. La justification du choix du mot ainsi que les hypothèses émises. 
- pour l'instant le site contient une barre avec trois pages l'accueil, les tableaux et les nuages de mots. Les tableaux et nuages de mots sont pour l'instant vide car nous n'avons pas encore finalisé le script de l'analyse. 
- Pour ce qui est du style de la page, j'ai fait un premier essaie en applicant un style css personnalisé (ce n'est peut-être pas le style final - à voir -):

        - Objectif général : on voulait un design simple, lisible et épuré pour mettre en valeur le contenu.

        - Palette de couleurs : rose pâle pour les sections, blanc pour le fond général, noir pour le texte et les titres, pour un bon contraste et lisibilité.

        - Typographie : Times New Roman, c'ets la police qui est utilisé généralement pour un style académique et elle a un rendu plutôt joli.

        - Structure et lisibilité : blocs clairs et espacés,utilisation de Flexbox pour aligner les définitions sur une meme ligne comme des sortes de colonnes.
        - Menu et navigation : barre simple et fonctionnelle avec dropdowns au survol pour tableaux et nuages de mots ; lien Accueil pointant vers la page principale. J'ai beaucoup cherché pour réussir à avoir cet effet de "faire dérouler le menu quand on passe la souris sur un onglet" (pour tableaux, par exemple, quand on passe la souris, on vois un menu se dérouler avec le tableau de chaque langue). Je suis assez satisfaite d'avoir appris à avoir cet effet. Et aussi à utiliser flex pour aligner. 
- Pour l'instant le CSS n'ets pas final, on verra par la suite si on le garde ou on modifie.  