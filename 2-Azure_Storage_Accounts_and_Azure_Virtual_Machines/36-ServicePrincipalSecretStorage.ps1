
# We first connect using our Azure Administrator account to create the new service principal
Disable-AzContextAutosave
Connect-AzAccount

$ServicePrincipalName="new-principal"
$ServicePrincipal=New-AzADServicePrincipal -DisplayName $ServicePrincipalName

$ServicePrincipalSecret=$ServicePrincipal.PasswordCredentials.SecretText

# Here we assume we have the following key vault in place
$KeyVaultName="appvault1002030"

$SecretValue = ConvertTo-SecureString $ServicePrincipalSecret -AsPlainText -Force

# We then store the secret in the key vault
Set-AzKeyVaultSecret -VaultName $KeyVaultName -Name $ServicePrincipalName `
-SecretValue $SecretValue

# Connecting via the new service principal

$ServicePrincipal =Get-AzADServicePrincipal -DisplayName $ServicePrincipalName
$AppId=$ServicePrincipal.AppId

# We can now fetch the value of the secret from the key vault
$AppSecret=Get-AzKeyVaultSecret -VaultName $KeyVaultName -Name $ServicePrincipalName `
-AsPlainText

$SecureSecret = $AppSecret | ConvertTo-SecureString -AsPlainText -Force

$Credential = New-Object -TypeName System.Management.Automation.PSCredential `
-ArgumentList $AppId,$SecureSecret

$TenantID=""

Disconnect-AzAccount

# We can now connect via our service principal
Connect-AzAccount -ServicePrincipal -Credential $Credential -Tenant $TenantID 
