$toAcc = read-host "Enter user's mailbox you wish to grant access to (firstname.lastname)"
$fromAcc = read-host "Enter user who requires access (firstname.lastname)"

echo "You are about to provide $fromAcc access to the mailbox: $toAcc - is this correct?"

$yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", `
    "Grant Access."

$no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", `
    "Do not grant access."

$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)

$result = $host.ui.PromptForChoice($title, $message, $options, 0) 

switch ($result)
    {
        0 { Add-MailboxPermission -Identity $toAcc -User $fromAcc -AccessRights FullAccess }
        1 {"You selected No, permissions remain unmodified..."}
    }
 
