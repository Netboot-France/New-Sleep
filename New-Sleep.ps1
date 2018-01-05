<#PSScriptInfo
	.VERSION 1.0.1
	.GUID 5a193180-8425-41de-955d-8f0e298c2cbc
	.AUTHOR thomas.illiet
	.COMPANYNAME netboot.fr
	.COPYRIGHT (c) 2017 Netboot. All rights reserved.
	.TAGS Tools
	.LICENSEURI https://raw.githubusercontent.com/Netboot-France/New-Sleep/master/LICENSE
	.PROJECTURI https://github.com/Netboot-France/New-Sleep
#>

<#  
	.SYNOPSIS  
		Suspends the activity in a script or session for the specified period of time.

	.DESCRIPTION
		The New-Sleep cmdlet suspends the activity in a script or session for the specified period of time.
		You can use it for many tasks, such as waiting for an operation to complete or pausing before repeating an operation.

	.NOTES  
		File Name  : New-Sleep.ps1
		Author     : Thomas ILLIET, contact@thomas-illiet.fr
		Date	   : 2017-05-10
		Last Update: 2017-07-26
		Version	   : 1.0.1
		
	.PARAMETER S
		Time to wait
	
	.PARAMETER Message
		Message you want to display

	.EXAMPLE  
		New-Sleep -S 60 -Message "wait and see"

	.EXAMPLE
		New-Sleep -S 60
#>
[cmdletbinding()]
param
(
	[parameter(Mandatory=$true)]
	[int]$S,
	[parameter(Mandatory=$false)]
	[string]$Message="Wait"
)
for ($i = 1; $i -lt $s; $i++) 
{
	if ($host.ui.RawUi.KeyAvailable) { # Cancel waiting if CTRL+Q is pressed
		$key = $host.ui.RawUI.ReadKey("NoEcho,IncludeKeyUp") 
		if (($key.VirtualKeyCode -eq 81) -AND ($key.ControlKeyState -match "LeftCtrlPressed"))
		{
			break
		}
	}
	[int]$TimeLeft = $s - $i
	Write-Progress -Activity $message -PercentComplete (100 / $s * $i) -CurrentOperation "$TimeLeft seconds left" -Status "Please wait (Cancel with CTRL + Q)"
	Start-Sleep -s 1
}
Write-Progress -Completed $true -Status "Please wait"