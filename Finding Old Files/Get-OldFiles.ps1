Function Get-OldFiles
 
{
 
 Param([string[]]$path,
 
       [int]$numberDays)
 
 $cutOffDate = (Get-Date).AddDays(-$numberDays)
 
 Get-ChildItem -Path $path -recurse |
 
 Where-Object {$_.LastAccessTime -le $cutOffDate}
 
}