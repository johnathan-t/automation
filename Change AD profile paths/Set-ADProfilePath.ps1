import-module activedirectory

$content = get-content "C:\Users\administrator\Desktop\users.txt"

foreach ($line in $content) 
{
    $ADUser = Get-ADUser $line | select -ExpandProperty disting*
    $ADUser = [ADSI]”LDAP://$ADUser”
    $ADuser.psbase.invokeset(“terminalservicesprofilepath”,””)
    $ADUser.setinfo()
}