# Find and modify a user's logon script
# 2019-02-04 Johnathan Tracz
# rev 1.3 
#		- added dynamic menu to JGetLogonScript for user selection
#		- added JModifyGroups cmd-let
#
# JTGetLogonScript - Get Logon Script
# JTFindGroup - Find groups containing $String
# JTModifyGroup - Modify Groups

import-module activedirectory

function JTGetLogonScript {
	$un = read-host -prompt "Username or part of username"
	$un="*$un*"
	$un=(Get-ADUser -Filter {samaccountname -like $un})  | Out-GridView -PassThru
	$sp=Get-ADUser $un -Properties scriptpath | ft scriptpath -HideTableHeaders | Out-String
	$sp=$sp.Replace("`n","").replace("`r","")
	$sp="\\dc\netlogon\"+$sp

	write-host "Logon script: $sp`n"
	write-host "Do you wish to modify this logon script?`n"

	$choice = Read-Host -prompt "Please enter your response (y/n)"
	write-host
	while("y","n" -notcontains $choice)
	{
	 $choice = Read-Host -prompt "Please enter your response (y/n)"
	 write-host
	}

	if($choice -eq "y")
	{
		notepad $sp
	}

}

function JTFindGroup {

	$grp = read-host -prompt 'Group Name'
	write-host
	write-host 'finding groups, please wait...'

	Get-ADGroup -properties name,description -Filter * | ? {$_.name -like "*$grp*"} | ft name,description -AutoSize
}

function JTModifyGroup {
	$modgrp = read-host -prompt 'Group Name'
	write-host
	$uname = read-host -prompt 'Username'

		while("y","n" -notcontains $choice)
	{
	 $choice = Read-Host -prompt "Add $uname to $modgrp? (y/n)"
	 write-host
	}

	if($choice -eq "y")
	{
		add-adgroupmember -identity $modgrp -members $uname
	}
}
# SIG # Begin signature block
# MIIJNgYJKoZIhvcNAQcCoIIJJzCCCSMCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUvmoNaLSM97rx+uYfLN+TrL6H
# gUqgggaBMIIGfTCCBWWgAwIBAgITNwAtmTVHaTIVRs++iAABAC2ZNTANBgkqhkiG
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
# FgQUQVci0IE1f0lDItfRAVBaxFAUQJAwDQYJKoZIhvcNAQEBBQAEggEAsyjNKPjN
# B0DLdXq5z1/YXtLnAw57zyjUzP28d4qDAnoTdveP7IkOUnOLyilNnHDXo7xpoUoa
# H66bu7bgUDQOjDwMigLqEuhjUNvMS1tR92AjU9zJwnWLIJVxgzLDkgwzHcTzFtXj
# lFhRefCSLjmXciCDZLZ2gdCwY9sf1oiPnI5Dgn06aJMIoLIHV5/PcJK+L3AYJ9Kh
# 603n7VqlvObydYjbhWjvl/cS0NskXgtIshscy6c0zLc/vQcQ50nRW9u7cocPNjz9
# m0e2A2ybO6trQi7WdtfwUqCFP65+lS3jTZgBlytfn/KNleJynO3uy3nnPHBuzA/e
# 7LC9WsK3nRtEFw==
# SIG # End signature block
