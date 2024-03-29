on error resume next

const L_Msg01_Text = 	"Searching for recommended updates..."
const L_Msg02_Text = 	"List of applicable items on the machine:"
const L_Msg03_Text = 	"There are no applicable updates."
const L_Msg04_Text = 	"Press return to continue..."
const L_Msg05_Text = 	"Select an option:"
const L_Msg06_Text = 	"Downloading updates..."
const L_Msg07_Text = 	"Installing updates..."
const L_Msg08_Text = 	"Listing of updates installed and individual installation results:"
const L_Msg09_Text = 	"Installation Result: "
const L_Msg10_Text = 	"Restart Required:  "
const L_Msg11_Text = 	"A restart is required to complete Windows Updates. Restart now?"
const L_Msg12_Text = 	"Press return to continue..."
const L_Msg13_Text = 	"Not Started"
const L_Msg14_Text = 	"In Progress"
const L_Msg15_Text = 	"Succeeded"
const L_Msg16_Text = 	"Succeeded with errors"
const L_Msg17_Text = 	"Failed"
const L_Msg18_Text = 	"Process stopped before completing"
const L_Msg19_Text = 	"Restart Required"
const L_Msg20_Text = 	"N"   'No
const L_Msg21_Text = 	"Y"   'Yes
const L_Msg22_Text = 	"Searching for all applicable updates..."
const L_Msg23_Text = 	"Search for for (A)ll updates or (R)ecommended updates only? "
const L_Msg24_Text = 	"A"  ' All
const L_Msg25_Text = 	"R"  ' Recommended only
const L_Msg26_Text = 	"S"  ' Single update only
const L_Msg27_Text = 	"Enter the number of the update to download and install:"
const L_Msg28_Text = 	"(A)ll updates, (N)o updates or (S)elect a single update? "


Set updateSession = CreateObject("Microsoft.Update.Session")
Set updateSearcher = updateSession.CreateupdateSearcher()
Set oShell = WScript.CreateObject ("WScript.shell")


Do
wscript.StdOut.Write L_Msg23_Text       
UpdatesToSearch = "R"
WScript.Echo

'  Case L_Msg24_Text 'All
'	WScript.Echo L_Msg22_Text & vbCRLF
'	Set searchResult = updateSearcher.Search("IsInstalled=0 and Type='Software'")

WScript.Echo L_Msg01_Text & vbCRLF
Set searchResult = updateSearcher.Search("IsInstalled=0 and Type='Software' and AutoSelectOnWebsites=1")

Loop until UpdatesToSearch=L_Msg24_Text or UpdatesToSearch=L_Msg25_Text

WScript.Echo L_Msg02_Text
WScript.Echo

For I = 0 To searchResult.Updates.Count-1
    Set update = searchResult.Updates.Item(I)
    WScript.Echo I + 1 & "> " & update.Title
Next

SingleUpdateSelected=""

If searchResult.Updates.Count = 0 Then
	WScript.Echo
	WScript.Echo L_Msg03_Text
	WScript.Echo
	wscript.StdOut.Write L_Msg04_Text
	WScript.Quit
else

	'Select updates to download

	do
	  WScript.Echo vbCRLF & L_Msg05_Text
	  Wscript.StdOut.Write L_Msg28_Text
	  UpdateSelection = "A"
	  WScript.Echo 
	loop until UpdateSelection=ucase(L_Msg20_Text) or UpdateSelection=ucase(L_Msg24_Text) or UpdateSelection=ucase(L_Msg26_Text)

	If UpdateSelection=ucase(L_Msg20_Text) Then 'No updates
		WScript.Quit
	end if
	
	If UpdateSelection=ucase(L_Msg26_Text) Then 'Single update
		Do
		    WScript.Echo  vbCRLF & L_Msg27_Text
		    SingleUpdateSelected = WScript.StdIn.Readline	
		loop until cint(SingleUpdateSelected) > 0 and cint(SingleUpdateSelected) <= searchResult.Updates.Count
	end if

End If


Set updatesToDownload = CreateObject("Microsoft.Update.UpdateColl")

For I = 0 to searchResult.Updates.Count-1
    if SingleUpdateSelected="" then 
	Set update = searchResult.Updates.Item(I)
    	updatesToDownload.Add(update)
    else
	if I=cint(SingleUpdateSelected)-1 then 
	    Set update = searchResult.Updates.Item(I)
	    updatesToDownload.Add(update)
	end if
    end if
Next

WScript.Echo vbCRLF & L_Msg06_Text
WScript.Echo

Set downloader = updateSession.CreateUpdateDownloader() 
downloader.Updates = updatesToDownload
downloader.Download()

Set updatesToInstall = CreateObject("Microsoft.Update.UpdateColl")

'Creating collection of downloaded updates to install 

For I = 0 To searchResult.Updates.Count-1
    set update = searchResult.Updates.Item(I)
    If update.IsDownloaded = true Then
        updatesToInstall.Add(update)	
    End If
Next

WScript.Echo
WScript.Echo L_Msg07_Text & vbCRLF
Set installer = updateSession.CreateUpdateInstaller()
installer.Updates = updatesToInstall
Set installationResult = installer.Install()

WScript.Echo L_Msg08_Text & vbCRLF
	
For I = 0 to updatesToInstall.Count - 1

	WScript.Echo I + 1 & "> " & _
	updatesToInstall.Item(i).Title & _
	": " & ResultCodeText(installationResult.GetUpdateResult(i).ResultCode)		
Next
	
'Output results of install
WScript.Echo
WScript.Echo L_Msg09_Text & ResultCodeText(installationResult.ResultCode)
WScript.Echo L_Msg10_Text & installationResult.RebootRequired & vbCRLF 

WScript.Echo
Wscript.StdOut.Write L_Msg12_Text
WScript.Quit	

Function ResultCodeText(resultcode)
	if resultcode=0 then ResultCodeText=L_Msg13_Text
	if resultcode=1 then ResultCodeText=L_Msg14_Text
	if resultcode=2 then ResultCodeText=L_Msg15_Text
	if resultcode=3 then ResultCodeText=L_Msg16_Text
	if resultcode=4 then ResultCodeText=L_Msg17_Text
	if resultcode=5 then ResultCodeText=L_Msg18_Text
end Function	
'' SIG '' Begin signature block
'' SIG '' MIIJNAYJKoZIhvcNAQcCoIIJJTCCCSECAQExCzAJBgUr
'' SIG '' DgMCGgUAMGcGCisGAQQBgjcCAQSgWTBXMDIGCisGAQQB
'' SIG '' gjcCAR4wJAIBAQQQTvApFpkntU2P5azhDxfrqwIBAAIB
'' SIG '' AAIBAAIBAAIBADAhMAkGBSsOAwIaBQAEFHV3sDoUjOvO
'' SIG '' 0iIQiGxf5okv1UUqoIIGgTCCBn0wggVloAMCAQICEzcA
'' SIG '' LZk1R2kyFUbPvogAAQAtmTUwDQYJKoZIhvcNAQELBQAw
'' SIG '' ZzESMBAGCgmSJomT8ixkARkWAmNhMRIwEAYKCZImiZPy
'' SIG '' LGQBGRYCb24xGDAWBgoJkiaJk/IsZAEZFghzdGpvc2hh
'' SIG '' bTESMBAGCgmSJomT8ixkARkWAmFkMQ8wDQYDVQQDEwZS
'' SIG '' T09UQ0EwHhcNMTkwNDE3MTg1MDE4WhcNMjAwNDE2MTg1
'' SIG '' MDE4WjCBgDESMBAGCgmSJomT8ixkARkWAmNhMRIwEAYK
'' SIG '' CZImiZPyLGQBGRYCb24xGDAWBgoJkiaJk/IsZAEZFghz
'' SIG '' dGpvc2hhbTESMBAGCgmSJomT8ixkARkWAmFkMQ4wDAYD
'' SIG '' VQQDEwVVc2VyczEYMBYGA1UEAxMPSm9obmF0aGFuIFRy
'' SIG '' YWN6MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
'' SIG '' AQEA818hGNszONhMJofMPL/FipJ1SRpgpOtCpthyGmXf
'' SIG '' R+sKLNhtkutm4P2VfsOdT2XyaGhiNGZK/f1+8Qpywdrh
'' SIG '' i93sVPTk2APCtKODzYFSBsqMJtdpgj6GDZr5fSF0C1bO
'' SIG '' Bd4VXnyC8BvcGf7tkCTDlq+COdCqwN7myp1UwmVPp8Xp
'' SIG '' PHRKhJ113aD3hcY16uQZl2GCJ0o1NlNeiOLSdn0V1uBi
'' SIG '' ndvnzBmnE5SBJUcQ0VQ8prQ4vYgNMew/zjmCSaIjF85O
'' SIG '' 2/VDOi7IpVlkqE194VQHWj/dMn2pn95gzdRX5kLJs4El
'' SIG '' D19nSLxtWYI0EYg/r3ZTjzymUN8By/Nuw+iZ2QIDAQAB
'' SIG '' o4IDBjCCAwIwCwYDVR0PBAQDAgeAMCUGCSsGAQQBgjcU
'' SIG '' AgQYHhYAQwBvAGQAZQBTAGkAZwBuAGkAbgBnMB0GA1Ud
'' SIG '' DgQWBBQsdZ/JTfhoYi26YJnb2r/CbLj2ijAfBgNVHSME
'' SIG '' GDAWgBSvUjZP9AeSZGiBl7t4lv29o5t15DCCARMGA1Ud
'' SIG '' HwSCAQowggEGMIIBAqCB/6CB/IaBvWxkYXA6Ly8vQ049
'' SIG '' Uk9PVENBKDEpLENOPVNKSC1DRVJULENOPUNEUCxDTj1Q
'' SIG '' dWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNl
'' SIG '' cyxDTj1Db25maWd1cmF0aW9uLERDPWFkLERDPXN0am9z
'' SIG '' aGFtLERDPW9uLERDPWNhP2NlcnRpZmljYXRlUmV2b2Nh
'' SIG '' dGlvbkxpc3Q/YmFzZT9vYmplY3RDbGFzcz1jUkxEaXN0
'' SIG '' cmlidXRpb25Qb2ludIY6aHR0cDovL1NKSC1DRVJULmFk
'' SIG '' LnN0am9zaGFtLm9uLmNhL0NlcnRFbnJvbGwvUk9PVENB
'' SIG '' KDEpLmNybDCCASkGCCsGAQUFBwEBBIIBGzCCARcwgbEG
'' SIG '' CCsGAQUFBzAChoGkbGRhcDovLy9DTj1ST09UQ0EsQ049
'' SIG '' QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENO
'' SIG '' PVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9YWQs
'' SIG '' REM9c3Rqb3NoYW0sREM9b24sREM9Y2E/Y0FDZXJ0aWZp
'' SIG '' Y2F0ZT9iYXNlP29iamVjdENsYXNzPWNlcnRpZmljYXRp
'' SIG '' b25BdXRob3JpdHkwYQYIKwYBBQUHMAKGVWh0dHA6Ly9T
'' SIG '' SkgtQ0VSVC5hZC5zdGpvc2hhbS5vbi5jYS9DZXJ0RW5y
'' SIG '' b2xsL1NKSC1DRVJULmFkLnN0am9zaGFtLm9uLmNhX1JP
'' SIG '' T1RDQSgxKS5jcnQwEwYDVR0lBAwwCgYIKwYBBQUHAwMw
'' SIG '' MwYDVR0RBCwwKqAoBgorBgEEAYI3FAIDoBoMGGp0cmFj
'' SIG '' ekBhZC5zdGpvc2hhbS5vbi5jYTANBgkqhkiG9w0BAQsF
'' SIG '' AAOCAQEAE/GCR/4Whi0Wf0LZ0EYyjkxE+pY7e/LshP3t
'' SIG '' eyWtIuZCxRQk/8C6phGcgajZJnpZE8lEcmjV4Atrso7R
'' SIG '' dKZUuHYV1Qy8DBUcsi1eVlZjxyeyPgJZZcwGa1aS/5BF
'' SIG '' UAE0J0cZzDpXLZv1K8iEWJcTIjVxkW5IdMz3XlUcGfrW
'' SIG '' Aqe2PJmhADKYxuHdCBqhAh6wnDG3M41Ei17pFXp5swbd
'' SIG '' aTdkwo/olS0YbozE0wYmgi9RmzB88Yq3WolW2jFiD8lc
'' SIG '' orMqvIQXWMj0Vq8GmuDABLm0Hb1bnvJiX/m2Lr9tAG98
'' SIG '' tt1Yb96Ie0GAgFXa9u+Hz+5J5gr9sxfezisJo/JWzDGC
'' SIG '' Ah8wggIbAgEBMH4wZzESMBAGCgmSJomT8ixkARkWAmNh
'' SIG '' MRIwEAYKCZImiZPyLGQBGRYCb24xGDAWBgoJkiaJk/Is
'' SIG '' ZAEZFghzdGpvc2hhbTESMBAGCgmSJomT8ixkARkWAmFk
'' SIG '' MQ8wDQYDVQQDEwZST09UQ0ECEzcALZk1R2kyFUbPvogA
'' SIG '' AQAtmTUwCQYFKw4DAhoFAKB4MBgGCisGAQQBgjcCAQwx
'' SIG '' CjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwGCisGAQQB
'' SIG '' gjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcC
'' SIG '' ARUwIwYJKoZIhvcNAQkEMRYEFLDvlSuC3kMsAhvMzlyj
'' SIG '' 7wgUnblOMA0GCSqGSIb3DQEBAQUABIIBAE6wumUepzlM
'' SIG '' VtyfUzPUuhYFKjLfBsgt7vvbUj7cvd6TBbtSkxJiwAI8
'' SIG '' wVLpsMHgiVTHmbmaBOjeE6bUpMnMYGl+d58ZeRL/+E+g
'' SIG '' TjnLptUw/QJEwQRBmdRv9pnAqjBPeiqlVzrKTeR8iOnf
'' SIG '' sEakz7y/stHxG5I3HFsc5TOlnCU1OpxydIKythy/X0+y
'' SIG '' hO/8IRUiNKpbFRwKaLGB0g/kLox2ISoxOFIP70BmvS1V
'' SIG '' 7o6ncBonYud3yd2eKgGzqLNSpjA1iUf0QG03w9kqiF/k
'' SIG '' 1NFZledElgWCVlH13TtDIXR5sl7+iEDKwAV0mJCM/Vn2
'' SIG '' AvB7patLr3oleKNkbbJl0l4=
'' SIG '' End signature block
