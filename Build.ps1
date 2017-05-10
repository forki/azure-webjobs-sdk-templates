# Get Environmental Params
$currentPath = Get-Location
$binDirectory = Join-Path $currentPath -ChildPath "bin"
$templatesPath = Join-Path $currentPath -ChildPath "\Templates\"

# Start with a clean slate
if (Test-Path $binDirectory) {
    try {
        Remove-Item $binDirectory -Recurse -Confirm:$false
    }
    catch {
        $error[0]|format-list -force
        Write-Host -ForegroundColor Red "Unable to clean bin directory"        
        Exit 
    }    
}

New-Item $binDirectory -ItemType Directory
$x = $binDirectory
d:\tools\nuget.exe pack D:\azurefun\azure-webjobs-sdk-templates\Templates\ItemTemplates.nuspec -Version 1.0.0 -OutputDirectory $x
d:\tools\nuget.exe pack D:\azurefun\azure-webjobs-sdk-templates\Templates\PortalTemplates.nuspec -Version 1.0.0 -OutputDirectory $x
msbuild D:\azurefun\azure-webjobs-sdk-templates\ProjectTemplate\Template.proj /t:Clean;
msbuild D:\azurefun\azure-webjobs-sdk-templates\ProjectTemplate\Template.proj /p:PackageVersion=1.0.0