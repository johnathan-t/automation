# InstallCylance.ps1
# Feed script a text file containing list of servers, 1 per line
# e.g.
#		SERVER1
#		SERVER2
# 		SERVER3
#
# PS C:\> ./InstallCylance.ps1 servers.txt
# 
# 2019-02-04 / Johnathan Tracz
#

if ($Args[0])
{
	foreach($srv in gc($Args[0]))
	{
		if(test-wsman -computername $srv)
		{
			robocopy \\server\common\cylance\ \\$srv\c$\cylance /XD "MAC OSX" "Linux"
			if((Get-WmiObject Win32_OperatingSystem -computername $srv).OSArchitecture -eq "32-bit")
			{
				write-host "32-bit machine, deploying Cylance x86..."
				Invoke-Command -computername $srv -ScriptBlock { & cmd /c "C:\cylance\CylanceProtect_x64.msi /q /l*v C:\Windows\Temp\CylanceInstall.log PIDKEY=CHANGEME LAUNCHAPP=1" }
			}
			else
			{
				write-host "64-bit machine, deploying Cylance x64..."
				Invoke-Command -computername $srv -ScriptBlock { & cmd /c "C:\cylance\CylanceProtect_x86.msi /q /l*v C:\Windows\Temp\CylanceInstall.log PIDKEY=CHANGEME LAUNCHAPP=1" }
			}
		}
		else
		{
			echo "PS-Remoting is disabled on machine $srv"
		}
	}
}
else
{
	echo "`nPlease supply a server list.`nUsage: ./InstallCylance.ps1 servers.txt`n"
}
# SIG # Begin signature block
# MIIJNgYJKoZIhvcNAQcCoIIJJzCCCSMCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUFlliIkVNAnaFsg7DEQlCEhyJ
# 5vygggaBMIIGfTCCBWWgAwIBAgITNwAtmTVHaTIVRs++iAABAC2ZNTANBgkqhkiG
# 9w0BAQsFADBnMRIwEAYKCZImiZPyLGQBGRYCY2ExEjAQBgoJkiaJk/IsZAEZFgJv
# bjEYMBYGCgmSJomT8ixkARkWCHN0am9zaGFtMRIwEAYKCZImiZPyLGQBGRYCYWQx
# DzANBgNVBAMTBlJPT1RDQTAeFw0xOTA0MTcxODUwMThaFw0yMDA0MTYxODUwMTha
# MIGAMRIwEAYKCZImiZPyLGQBGRYCY2ExEjAQBgoJkiaJk/IsZAEZFgJvbjEYMBYG
# CgmSJomT8ixkARkWCHN0am9zaGFtMRIwEAYKCZImiZPyLGQBGRYCYWQxDjAMBgNV
# BAMTBVVzZXJzMRgwFgYDVQQDEw9Kb2huYXRoYW4gVHJhY3owggEiMA0GCSqGSIb3
# DQEBAQUAA4IBDwAwggEKAoIBAQDzXyEY2zM42Ewmh8w8v8WKknVJGmCk60Km2HIa
# Zd9H6wos2G2S62bg/ZV+w51PZfJoaGI0Zkr9/X7xCnLB2uGL3exU9OTYA8K0o4PN
# gVIGyowm12mCPoYNmvl9IXQLVs4F3hVefILwG9wZ/u2QJMOWr4I50KrA3ubKnVTC
# ZU+nxek8dEqEnXXdoPeFxjXq5BmXYYInSjU2U16I4tJ2fRXW4GKd2+fMGacTlIEl
# RxDRVDymtDi9iA0x7D/OOYJJoiMXzk7b9UM6LsilWWSoTX3hVAdaP90yfamf3mDN
# 1FfmQsmzgSUPX2dIvG1ZgjQRiD+vdlOPPKZQ3wHL827D6JnZAgMBAAGjggMGMIID
# AjALBgNVHQ8EBAMCB4AwJQYJKwYBBAGCNxQCBBgeFgBDAG8AZABlAFMAaQBnAG4A
# aQBuAGcwHQYDVR0OBBYEFCx1n8lN+GhiLbpgmdvav8JsuPaKMB8GA1UdIwQYMBaA
# FK9SNk/0B5JkaIGXu3iW/b2jm3XkMIIBEwYDVR0fBIIBCjCCAQYwggECoIH/oIH8
# hoG9bGRhcDovLy9DTj1ST09UQ0EoMSksQ049U0pILUNFUlQsQ049Q0RQLENOPVB1
# YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRp
# b24sREM9YWQsREM9c3Rqb3NoYW0sREM9b24sREM9Y2E/Y2VydGlmaWNhdGVSZXZv
# Y2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50
# hjpodHRwOi8vU0pILUNFUlQuYWQuc3Rqb3NoYW0ub24uY2EvQ2VydEVucm9sbC9S
# T09UQ0EoMSkuY3JsMIIBKQYIKwYBBQUHAQEEggEbMIIBFzCBsQYIKwYBBQUHMAKG
# gaRsZGFwOi8vL0NOPVJPT1RDQSxDTj1BSUEsQ049UHVibGljJTIwS2V5JTIwU2Vy
# dmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1hZCxEQz1zdGpv
# c2hhbSxEQz1vbixEQz1jYT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9
# Y2VydGlmaWNhdGlvbkF1dGhvcml0eTBhBggrBgEFBQcwAoZVaHR0cDovL1NKSC1D
# RVJULmFkLnN0am9zaGFtLm9uLmNhL0NlcnRFbnJvbGwvU0pILUNFUlQuYWQuc3Rq
# b3NoYW0ub24uY2FfUk9PVENBKDEpLmNydDATBgNVHSUEDDAKBggrBgEFBQcDAzAz
# BgNVHREELDAqoCgGCisGAQQBgjcUAgOgGgwYanRyYWN6QGFkLnN0am9zaGFtLm9u
# LmNhMA0GCSqGSIb3DQEBCwUAA4IBAQAT8YJH/haGLRZ/QtnQRjKOTET6ljt78uyE
# /e17Ja0i5kLFFCT/wLqmEZyBqNkmelkTyURyaNXgC2uyjtF0plS4dhXVDLwMFRyy
# LV5WVmPHJ7I+AlllzAZrVpL/kEVQATQnRxnMOlctm/UryIRYlxMiNXGRbkh0zPde
# VRwZ+tYCp7Y8maEAMpjG4d0IGqECHrCcMbczjUSLXukVenmzBt1pN2TCj+iVLRhu
# jMTTBiaCL1GbMHzxirdaiVbaMWIPyVyisyq8hBdYyPRWrwaa4MAEubQdvVue8mJf
# +bYuv20Ab3y23Vhv3oh7QYCAVdr274fP7knmCv2zF97OKwmj8lbMMYICHzCCAhsC
# AQEwfjBnMRIwEAYKCZImiZPyLGQBGRYCY2ExEjAQBgoJkiaJk/IsZAEZFgJvbjEY
# MBYGCgmSJomT8ixkARkWCHN0am9zaGFtMRIwEAYKCZImiZPyLGQBGRYCYWQxDzAN
# BgNVBAMTBlJPT1RDQQITNwAtmTVHaTIVRs++iAABAC2ZNTAJBgUrDgMCGgUAoHgw
# GAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGC
# NwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQx
# FgQUfRqcsvThgPsj+5z5HcbsMl1YdoowDQYJKoZIhvcNAQEBBQAEggEA61buGizE
# NqGhpDFLjXQd+9vHco8fr5hI/z60TXEzh4udo8sC0LfyvKqtz3IEcFcMifZ0gTNg
# rFDdOSTb9PxbWzqm7BYamW/0/VWVltBH28vHvoX+farDxhDe9fG4kLmuq7LNPCDx
# llUOUoJDcHRoHjrkf98aUfhedF7ySfRAl+A7wAreULHP+Heb/9W3Bw9flFRPE5zd
# txW3INhljMtzmOYab2ieeAZQqnU+Has/oQNjNkKjCWbSMbkpz/naq1G7VSQjbzwP
# gSQyiWUKB7J4tnI6ct8I44vv6IiPD4IiAX+4raU1I8O4TGocEVKekhYt/1WWSHMA
# WQ2ndh/c2DQGhQ==
# SIG # End signature block
