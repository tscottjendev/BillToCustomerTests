param (
    [string]$token
)

Import-Module ".\.alpaca\PowerShell\module\alpaca-functions.psd1" -Scope Global -Force -DisableNameChecking

$Needs = $ENV:needsContext | ConvertFrom-Json
$containerConfig = $Needs."CustomJob-CreateAlpaca-Container".outputs

$owner = $Env:GITHUB_REPOSITORY_OWNER
$repository = $Env:GITHUB_REPOSITORY
$repository = $repository.replace($owner, "")
$repository = $repository.replace("/", "")

$containerID = $containerConfig.containerID

Write-Host "Delete Container $containerID"

$headers = Get-AuthenticationHeader -token $token -owner $owner -repository $repository

$QueryParams = @{
    "api-version" = "0.12"
}
$apiUrl = Get-AlpacaEndpointUrlWithParam -controller "Container" -ressource $containerID -QueryParams $QueryParams
Invoke-RestMethod $apiUrl -Method 'DELETE' -Headers $headers -AllowInsecureRedirect