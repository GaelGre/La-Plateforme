Bonjour, 

Vous trouverez ci-dessous mon process pour la résolution de l'exercice 1. Je vous conseille cependant de le regarder sur le PDF car j'ai pu y inclure des captuers d'écrans.

**Process détaillé**

On crée notre fichier racine et on crée notre fichier docker-compose.
On commence par rajouter le service nginx (j’ai pris la dernière version en alpine car elle est plus légère).

On crée ensuite le fichier default.conf et on configure la gestion PHP.

On peut ensuite lancer un docker compose up dans le terminal puis vérifier dans Docker que notre container s’est bien créé.

On regarde également que le container nginx s'est bien créé, en version 1.29.4.

On peut ensuite se rendre sur notre local host:8080.

On a une erreur 404, ce qui est normal pour le moment car il cherche un fichier index.php alors que nous n’avons pas encore ajouté le container php, comme on peut le voir dans les logs.

On va ensuite créer notre base de données MariaDB.
On commence par créer un fichier .env qui contiendra nos variables. Cela permet que nos variables soient dans un fichier séparé de notre docker-compose.

*Le fichier .env n’est pas sur le git mais correspond juste à 4 lignes que je montre dans le PDF.*

On prend la dernière version de MariaDB et on pointe vers le port 3306 qui est le port par défaut de MySQL.
Comme on veut que les deux images (web et BDD) communiquent entre elles, on va rajouter un network commun à chacun que l’on définit en bas de notre fichier. On ajoutera également ce network à chaque nouvelle image.
On crée enfin un volume pour notre base de données(db_data). On va donc rajouter la section volumes dans notre container database et on va le mapper à db_data.

Enfin on ajoute notre container phpmyadmin, monté de la même manière. 

On peut ensuite refaire un docker compose up pour créer nos containers et on vérifie qu’ils sont bien créés dans Docker.

On peut aller sur notre localhost:8081 qui correspond à phpmyadmin et se connecter avec les identifiants qu’on a mis dans notre fichier .env.

On peut notamment vérifier qu’on a bien notre base de données “wordpress” qui a été créée.

On ajoute enfin le container Wordpress, toujours monté de la même manière. 
On prend la version fpm pour la connecter plus facilement à nginx et configurer la prise en charge de php. On a aussi créé un volume wordpress que l’on va également rajouté dans notre container nginx.


On va maintenant pouvoir revenir sur notre fichier de configuration NGINX pour configurer la gestion PHP avec FastCGI, qui est intégré à l’image FPM. On met bien le port 9000 qui est le port par défaut de FPM.

On peut désormais faire un dernier docker compose up et vérifier dans Docker que tous nos containers sont bien en running.

On peut ensuite se rendre sur notre localhost:8080 et vérifier qu’on a bien Wordpress : On a bien installé Wordpress ! 


En relisant l’énoncé je m’aperçois que je n’ai pas pris en compte le fait d’utiliser un volume commun.
Je supprime donc le volume db_data à la fin de mon fichier.

Et dans mon container database, je remplace le volume db_data par l’unique volume wordpress.




