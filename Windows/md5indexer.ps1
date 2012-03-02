#Get-Checksum function from http://www.tinyint.com/index.php/2011/09/14/get-an-md5-or-sha1-checksum-with-powershell/
function Get-Checksum {
    Param (
        [string]$File=$(throw("You must specify a filename to get the checksum of.")),
        [ValidateSet("sha1","md5")]
        [string]$Algorithm="sha1"
    )

    $fs = new-object System.IO.FileStream $File, "Open"
    $algo = [type]"System.Security.Cryptography.$Algorithm"
	$crypto = $algo::Create()
    $hash = [BitConverter]::ToString($crypto.ComputeHash($fs)).Replace("-", "")
    $fs.Close()
    if($hash) { $hash + " - " + $File } 
}

Get-ChildItem C:\ -Recurse -Include "*.exe" | ForEach-Object {Get-Checksum -Algorithm md5 -File $_.Fullname} | Out-File C:\MD5s.txt 
