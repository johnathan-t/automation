# Written by Johnathan Tracz
# Date: March 22nd, 2016
# Revision: 1.0

import-module activedirectory
Get-ADComputer -Filter {OperatingSystem -Like "*2003*"} -Property * | Format-Table Name,OperatingSystem,OperatingSystemServicePack -Wrap -Auto