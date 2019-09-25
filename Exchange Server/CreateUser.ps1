$DefaultPW = read-host "Enter password for new user" -AsSecureString
 
$Fname = read-host "Enter first name"
$Lname = read-host "Enter last name"
$username = "$Fname.$Lname"

echo "Username will be $username - is this correct?"

$yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", `
    "Creates the user."

$no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", `
    "Does not create the user."

$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)

$result = $host.ui.PromptForChoice($title, $message, $options, 0) 

switch ($result)
    {
        0 { New-Mailbox -UserPrincipalName "$username@mail.ca" -Alias "$username" -Database "DB02" -Name "$Fname $Lname" -OrganizationalUnit ORG-Users -Password $DefaultPW -FirstName $FName -LastName $LName -DisplayName "$Fname $Lname" -ResetPasswordOnNextLogon $true }
        1 {"You selected No, user creation skipped..."}
    }
 
