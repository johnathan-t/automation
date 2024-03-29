﻿# Find out who has a certain drive mapped, if using legacy logon scripts
# in Active Directory.
#
# Johnathan Tracz 2019-03-05

Write-Host "Enumerating logon scripts, please wait..."
$files = Get-ChildItem \\dc\NETLOGON\* -Include *.bat,*.cmd
#$AllLines = @();

$sstring = Read-Host "Search String ";

foreach($script in $files)
{
    $x = (get-content $script | select-string $sstring);
    if($x)
    {
        Write-Host "Batch file '$script' contains `"$sstring`" -> $x";
        $x = $null;
    }
    #$AllLines += Get-Content($script)
}

#$AllLines = $AllLines.tolower()
#$AllLines | group-object -NoElement | sort -Property count -Descending | ft count,name > mappingLowerCase.txt

pause
# SIG # Begin signature block
# MIIJNgYJKoZIhvcNAQcCoIIJJzCCCSMCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU4EKVYRSMQXkvlmZn5Tbsu+Pf
# ZVugggaBMIIGfTCCBWWgAwIBAgITNwAtmTVHaTIVRs++iAABAC2ZNTANBgkqhkiG
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
# FgQUS9IkzL0chCkJ0WMwoTfWjSBEkfswDQYJKoZIhvcNAQEBBQAEggEANaj4FWxG
# m+6sw3mYjViQvu6SjSt55OIt0b30PmVqE9pe1Vhm5YXexsBAzJ1k9QNw93aHz7Y0
# w9ytAumYSamne6LXgklc9wluGQ7m8ZNsDssoCnju308gg5gZacyEbntUpqi5HboQ
# z5BM3i5DNC0H0Uo+lJ40vocC8fjgM35r4yFztFFoCWOtzWniLmUqRo73m2qcfNVC
# SaiuI992+4b4A96m0uSoDAkWhaoUokT8Wa2V7FqifFnXFrEizqyz6HkIe5g+yi54
# hTZ5aT/GTPlBiVWmDghevxm/KJ22C6+BZ3zreUSV1XCCASVKr1/TqXJbw66NYdhZ
# XHsTbXGHQ7kGRw==
# SIG # End signature block
