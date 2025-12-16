Bonjour,
Vous trouverez ci-dessous mon process pour la résolution de l'exercice 1. Je vous conseille cependant de le regarder sur le PDF car j'ai pu y inclure des captuers d'écrans.

*Process détaillé :* 
Chaque bureau sera composé de : 
- 1 switch
- 1 point d’accès Wi-Fi
- 1 PC portable
- 2 PC fixes
- 1 téléphone IP

On va donc faire 3 bureaux car on dispose de 3 switchs, 3 points d’accès, 3 PC Portable, …

On va également faire 4 VLAN : 
1 pour les téléphones IP (VLAN 1)
1 pour les points d’accès Wifi (VLAN 20)
1 pour les PC Fixes (VLAN 10)
1 pour l’administration (VLAN 30)
Il y a une petite coquille dans l’énoncé sur la numérotation des VLAN, j’adopte donc la numérotation mentionnée ci-dessus.

Pour résumer, on fait un schéma (schéma ex 1) 


On commence par créer un premier bureau avec 1 switch, 2 PC fixes, 1 téléphone à IP, 1 access point et 1 laptop.

On crée les 4 VLAN dans le switch avec la table de VLAN.
Et on vient ensuite attribuer le bon VLAN à chaque port comme défini dans l’énoncé (en forçant bien les ports 1 et 9 en mode TRUNK) :
Port 8 : Administration, VLAN 30
Ports 6-7 : PC fixes, VLAN 20
Ports 4-5 : Points d’accès Wi-Fi, VLAN 10
Ports 2-3 : Téléphones IP (VoIP), VLAN 1
Ports 1 et 9 : Uplink (Ethernet/Fibre), TRUNK 

On connecte les différents périphériques à leur port respectif et on connecte également le laptop au point d’accès wifi (en lui ajoutant le module wifi WPC300N dans l’onglet “Physical”).

On ajoute un routeur qu’on relie au switch et on active l’interface du routeur qui est reliée au switch (Gigabit Ethernet 0/0) avec no shutdown.
 
On va ensuite attribuer des adresses IP (statiques pour l’instant) à nos ordinateurs : 
192.168.10.10 et 192.168.10.11 pour les PC1 et PC2 puis 192.168.20.10 pour le laptop1. Le masque de sous-réseau /24 est automatiquement attribué pour chacun.
Pour l’instant les 2 PC fixes peuvent communiquer entre eux car ils sont dans le même VLAN mais pas un PC et le laptop. On peut vérifier cela avec une commande ping depuis l’une des deux machines, en appelant l’autre : 

Nous allons ensuite créer les 4 sous-interfaces pour les 4 VLAN au niveau du routeur, avec la commande encapsulation dot1Q. 

Le routage inter VLAN a bien été configuré. On ajoute les default Gateway pour chaque ordinateur.
On peut désormais re-tester la connectivité entre 2 machines de 2 VLAN différents. Exemple ici avec l’appel du laptop depuis le PC Fixe 0 : 

On va maintenant configurer le DHCP pour chaque VLAN. 
On va créer un pool d’adresse pour chaque VLAN et déclarer la passerelle par défaut. Exemple pour VLAN10 et VLAN20 : 

On exclut ensuite les adresses que l’on ne veut pas pour garder seulement celles comprises entre .10 et .50. Donc dans notre cas on exclut celles entre .1 et .9 puis celles entre .51 et .254.

On peut ensuite aller sur nos différentes machines vérifier que la configuration de notre DHCP a bien été effectuée. On clique sur “DHCP” dans l’onglet “Desktop”. 

Une adresse IP correspondante à celle que l’on voulait pour cette VLAN a bien été générée.
On vérifie avec un Ping que la connexion entre VLAN est toujours effective et on continue.

On crée notre deuxième bureau : on duplique notre premier switch et on rajoute les autres éléments (2 PC fixes, 1 téléphone IP, …). On connecte ce switch à celui du premier bureau via un câble croisé sur les bons ports (0 ou 9) puis on connecte les différents éléments au switch, toujours sur les bons ports définis au début. On rajoute la carte réseau sur le pc portable et on se connecte à l’access point du bureau correspondant.

On vérifie sur les différentes machines que les adresses IP se sont bien générées.

 On peut également vérifier la connectivité entre VLAN avec un Ping.

On met au propre notre schéma en faisant apparaître les différents VLAN et les 3 bureaux.





