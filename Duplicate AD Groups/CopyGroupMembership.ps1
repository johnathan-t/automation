# Copy AD groups from one user to another
#
# Johnathan Tracz 2016-03-05
#

$source = read-host "Enter username to copy membership FROM (e.g. Firstname.Lastname)"
$target = read-host "Enter (new) username to copy membership TO"

Get-ADUser -Identity $source -Properties memberof |
Select-Object -ExpandProperty memberof |
Add-ADGroupMember -Members $target -PassThru | 
Select-Object -Property SamAccountName