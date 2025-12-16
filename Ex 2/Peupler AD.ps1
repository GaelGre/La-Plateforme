Import-Module ActiveDirectory

#Création des OU
New-ADOrganizationalUnit -Name "Utilisateurs" -Path "OU=DC=LAPLATEFORME, DC=IO"
New-ADOrganizationalUnit -Name "Groupes" -Path "OU=DC=LAPLATEFORME, DC=IO"


# Importation des données du CSV
$CSVFile = "C:\Users\bigbo\Documents\La Plateforme\Fichier CSV.csv"
$CSVData = Import-Csv -Path $CSVFile -Delimiter "," -Encoding Default
#Write-Output $CSVData

#Variable avec les noms des groupes (sans doublons ni vide)
$groupes = $CSVData | ForEach-Object {
    $_.groupe1, $_.groupe2, $_.groupe3, $_.groupe4, $_.groupe5, $_.groupe6} | Where-Object {$_ -and $_ -ne "" } | Sort-Object -Unique

Write-Host $groupes

# Création des groupes
Foreach ($groupe in $groupes) {
    New-ADGroup `
        -Name $groupe `
        -GroupScope Global `
        -GroupCategory Security `
        -Path "OU=Groupes, DC=LAPLATEFORME, DC=IO"
}

# Mot de passe à définir à chaque user
$PasswordUser = ConvertTo-SecureString "Azerty_2025!" -AsPlainText -Force

#Boucle qui parcoure le CSV
Foreach($User in $CSVData){
    $NomUser = $User.nom
    $PrenomUser = $User.prénom
    $LoginUser = ($User.prénom.Substring(0,1) + $User.nom).ToLower()
    $EmailUser = "$LoginUser@laplateforme.fr"



    #Vérification de la longueur du SamAccountName
    if ($LoginUser.Length -gt 20)
    {
        $LoginUser = $LoginUser.Substring(0,20)
    }
    
    #Vérification de la présence de l'user dans l'AD
    if (Get-ADUser -Filter {SamAccountName -eq $LoginUser})
    {
        Write-Warning "L'utilisateur $LoginUser existe déjà dans l'AD"
    }

    else
    {
        New-ADUser `
        -Name "$NommUser $PrenomUser" `
        -DisplayName "$NommUser $PrenomUser" `
        -GivenName $PrenomUser `
        -Surname $NomUser `
        -SamAccountName $LoginUser `
        -UserPrincipalName $EmailUser `
        -EmailAddress $EmailUser `
        -Path "OU=Utiliasteurs, DC=LAPLATEFORME, DC=IO" `
        -AccountPassword $PasswordUser `
        -Enabled $true `
        -ChangePasswordAtLogon $true
    }

    # Ajout aux groupes
    Foreach($groupe in @($User.groupe1,$User.groupe2,$User.groupe3,$User.groupe4,$User.groupe5,$User.groupe6)) {
        if ($groupe -and $groupe -ne "") 
        {
            Add-ADGroupMember -Identity $groupe -Members $LoginUser 
        }
 
    }

}

