Write-Output "-----------------=========================================================---------------------"
New-Item -ItemType Directory -Path bin -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path src -ErrorAction SilentlyContinue
Write-Output "GSC Autocompiler - By @DoktorSAS"

try
{
    if(Test-Path -Path .\src\main.gsc)
    {
        if (Test-Path .\bin\result-compiled.gsc) 
        {
            Write-Output "Removing old result-compiled.gsc"
            Remove-Item .\bin\result-compiled.gsc
        }
        Write-Output "Loading main"
        get-content .\src\main.gsc > result-uncompiled.gsc
        Write-Output "Main file Loaded"
        Write-Output "Lodading other files"
        get-childitem -Path .\src -Filter *gsc -Exclude main.gsc -Recurse | Get-Content >> result-uncompiled.gsc
        Write-Output "*.gsc files loaded"
        Start-Process .\compiler\Compiler.exe .\result-uncompiled.gsc -Wait -NoNewWindow 
        Write-Output "Compile phase ended"
        Move-Item .\result-uncompiled-compiled.gsc .\bin\result-compiled.gsc -Force 
        Write-Output "File moved in bin folder"

        if (Test-Path -Path .\bin\result-compiled.gsc)
        {
            Add-Type -AssemblyName System.Windows.Forms 
            $global:balloon = New-Object System.Windows.Forms.NotifyIcon
            $path = (Get-Process -id $pid).Path
            $balloon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path) 
            $balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Info 
            $balloon.BalloonTipText = 'File compiled as intended'
            $currentPathLocation = Split-Path -Path $pwd -Leaf
            $balloon.BalloonTipTitle = "$currentPathLocation Compiled!" 
            $balloon.Visible = $true 
            $balloon.ShowBalloonTip(5000)
        }
        else
        {
            Add-Type -AssemblyName System.Windows.Forms 
            $global:balloon = New-Object System.Windows.Forms.NotifyIcon
            $path = (Get-Process -id $pid).Path
            $balloon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path) 
            $balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Warning 
            $balloon.BalloonTipText = 'There is an error on the source code'
            $currentPathLocation = Split-Path -Path $pwd -Leaf
            $balloon.BalloonTipTitle = "$currentPathLocation not Compiled!" 
            $balloon.Visible = $true 
            $balloon.ShowBalloonTip(5000)
        }
    }
    else
    {
    
        Add-Type -AssemblyName System.Windows.Forms 
        $global:balloon = New-Object System.Windows.Forms.NotifyIcon
        $path = (Get-Process -id $pid).Path
        $balloon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path) 
        $balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Warning 
        $balloon.BalloonTipText = 'Missing file main.gsc'
        $currentPathLocation = Split-Path -Path $pwd -Leaf
        $balloon.BalloonTipTitle = "Unable to compile the $currentPathLocation" 
        $balloon.Visible = $true 
        $balloon.ShowBalloonTip(5000)
    }
  
}
catch 
{
    if(-not(Test-Path -Path .\compiler\Compiler.exe) -or -not(Test-Path -Path .\compiler\Irony.dll))
    {
        Write-Output "I am not allowed to share the compiler for gsc scripts."
        Write-Output "This means that the compiler folder will be empty and you'll have to manually insert the two files provided by the Plutonium team."
        Write-Output "The two files to insert are in the GSC Compiler folder`n`t1) Compiler.exe`n`t2) Irony.dll"
        sleep 5
        Add-Type -AssemblyName System.Windows.Forms 
        $global:balloon = New-Object System.Windows.Forms.NotifyIcon
        $path = (Get-Process -id $pid).Path
        $balloon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path) 
        $balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Error 
        $balloon.BalloonTipText = 'Missing compiler.exe or Irony.dll'
        $currentPathLocation = Split-Path -Path $pwd -Leaf
        $balloon.BalloonTipTitle = "Unable to execute the compiler" 
        $balloon.Visible = $true 
        $balloon.ShowBalloonTip(5000)
        Start-Process "https://drive.google.com/file/d/1j_ocjFCQsFaWqF2-PfdoJt2nF_EpNL_G/view"
    }
    else
    {
        Add-Type -AssemblyName System.Windows.Forms 
        $global:balloon = New-Object System.Windows.Forms.NotifyIcon
        $path = (Get-Process -id $pid).Path
        $balloon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path) 
        $balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Error 
        $balloon.BalloonTipText = 'Something threw an exception'
        $currentPathLocation = Split-Path -Path $pwd -Leaf
        $balloon.BalloonTipTitle = "Unable to compile the $currentPathLocation" 
        $balloon.Visible = $true 
        $balloon.ShowBalloonTip(5000)
        Write-Output "Something threw an exception"
    }
    
}

Write-Output "-----------------=========================================================---------------------"