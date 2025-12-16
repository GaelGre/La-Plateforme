# Installation du rôle AD DS
Add-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -IncludeAllSubFeature
Write-Output "Installation ADDS réussie"

# Installation du rôle DNS
Add-WindowsFeature -Name DNS -IncludeManagementTools -IncludeAllSubFeature
Write-Output "Installation DNS réussie"


# Création de la forêt et du domaine

# Création des variables et de la hashtable

$DNSName = "laplateforme.io"
$NetbiosName = "LAPLATEFORME"
$AdminPassword = ConvertTo-SecureString "AdminPwd" -AsPlainText -Force

$ForestConfiguration = @{
'-DomainName' = $DNSName;
'-DomainNetbiosName' = $NetbiosName;
'-DomainMode' = 'Default';
'-LogPath' = 'C:\Windows\NTDS';
'-SysvolPath' = 'C:\Windows\SYSVOL';
'-DatabasePath'= 'C:\Windows\NTDS';
'-ForestMode' = 'Default';
'-InstallDns' = $true;
'-NoRebootOnCompletion' = $false;
'-Force' = $true;
'-CreateDnsDelegation' = $false
'-SafeModeAdministratorPassword' = $AdminPassword  }

# Lancement de la création du domaine
Import-Module ADDSDeployment
Install-ADDSForest @ForestConfiguration
    


