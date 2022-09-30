[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")|Out-Null

$foldername = New-Object System.Windows.Forms.FolderBrowserDialog
$foldername.Description = "Select a folder"
$foldername.rootfolder = "MyComputer"
$foldername.SelectedPath = $PSScriptRoot

if($foldername.ShowDialog() -eq "OK")
{
    $folder += $foldername.SelectedPath
}
return $folder