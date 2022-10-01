[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")|Out-Null

$Path
$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$OpenFileDialog.InitialDirectory = $PSScriptRoot
$OpenFileDialog.filter = "Image Files(*.PNG;*.JPG;*.SVG;*.BMP)|*.PNG;*.JPG;*.SVG;*.BMP"
$OpenFileDialog.FileName

if($OpenFileDialog.ShowDialog() -eq "OK")
{
    $Path = $OpenFileDialog.FileName
}
return $Path