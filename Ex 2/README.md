Bonjour,
Vous trouverez ci-dessous mon process pour la résolution de l'exercice 2. Je vous conseille cependant de le regarder sur le PDF car j'ai pu y inclure des captuers d'écrans.

#Process détaillé :#

On suppose que sur le windows server, la machine a été renommée, la configuration réseau et la définition du serveur DNS ont déjà été faite.

On commence donc par ajouter les rôles ADDS et DNS à notre windows server.

Ensuite, pour créer le domaine, je vais créer une hastable qui va contenir tous les paramètres de configuration ($ForestConfiguration). C’est plus lisible et ça permet de modifier plus facilement les paramètres si besoin.

Enfin, on lance la création du domaine.

Pour le deuxième script qui doit peupler l’AD, je précise que je n’ai pas réussi à installer les outils d'administration à distance sur mon PC. J’ai essayé aussi bien depuis Powershell avec la commande ci-dessous mais le statut est toujours resté en “running”.
Commande : Add-WindowsCapability -Online -Name "Rsat.ServerManager.Tools~~~~0.0.1.0"
J’ai également essayé depuis mes paramètres systèmes mais impossible d’ajouter les fonctionnalités RSAT.
Je n’ai donc pas pu importer le module ActiveDirectory sur ma machine personnelle et vérifier que le script fonctionnait bien. 

Pour créer ce deuxième script qui doit peupler l’AD, on va commencer par créer notre script qui crée chaque user à partir du CSV et ensuite on s’intéressera aux groupes.
On commence par importer le module ActiveDirectory et créer nos OU Utilisateurs et Groupes. 

On peut ensuite importer les données du CSV.

On vérifie que cela marche bien avec le Write-Ouput.

On crée ensuite notre boucle Foreach qui va parcourir le CSV. Pour chaque user on va créer différentes variables qui reprennent les éléments de chacun : nom, prénom, login (première lettre du prénom et nom, le tout en minuscule) et email.


On peut ensuite créer l’user, en vérifiant au préalable : 
- que le SamAccountName ne dépasse pas 20 caractères
- que l’user n’existe pas déjà avec un if qui filtre sur le SamAccountName.

On a bien rajouté le ChangePasswordAtLogon en true comme demandé dans l’exercice.

On peut maintenant se concentrer sur les groupes. On va commencer par créer la variables groupes qui va contenir tous les groupes possibles non vides et sans doublon grâce au   Sort-Object   -Unique.

On peut ensuite les créer.

Enfin, on peut rajouter dans notre boucle Foreach initiale, l’ajout à chaque groupe auquel un utilisateur appartient.



