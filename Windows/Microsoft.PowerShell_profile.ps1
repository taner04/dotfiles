#Starship
Invoke-Expression (&starship init powershell)
$ENV:STARSHIP_CONFIG = "C:\Users\Taner\.config\starship.toml"

#Terminal-Icons
Import-Module -Name Terminal-Icons

#Auto Suggestion
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -Colors @{ InlinePrediction = "$([char]0x1b)[38;5;238m"}
