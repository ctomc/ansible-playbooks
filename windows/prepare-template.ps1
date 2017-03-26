# Prepare windows host for templating
# -----------------------------------------------------------
#

Disable-PSRemoting -Force
Get-ChildItem WSMan:\localhost\Listener\* | Remove-Item -Recurse
Get-ChildItem -Path Cert:\LocalMachine\My | Remove-Item

Stop-Service -Name "TCBuildAgent"
rm -Force -Recurse -ErrorAction SilentlyContinue -Path C:\BuildAgent\tools 
rm -Force -Recurse -ErrorAction SilentlyContinue -Path C:\BuildAgent\work
rm -Force -Recurse -ErrorAction SilentlyContinue -Path C:\BuildAgent\logs
rm -Force -Recurse -ErrorAction SilentlyContinue -Path C:\BuildAgent\temp
rm -Force -Recurse -ErrorAction SilentlyContinue -Path C:\BuildAgent\plugins

$content = Get-Content -path "C:\BuildAgent\conf\buildAgent.properties" | select-string -pattern 'authorizationToken' -notmatch
Set-Content -Value $content -Path "C:\BuildAgent\conf\buildAgent.properties"