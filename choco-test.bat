REM This is a Chocolatey package testing in Windows Sandbox
REM Preparing environment
powershell.exe -ExecutionPolicy Unrestricted -File "C:\Users\WDAGUtilityAccount\Desktop\chocolatey-test-sandbox\shell\PrepareWindows.ps1"
powershell.exe -ExecutionPolicy Unrestricted -File "C:\Users\WDAGUtilityAccount\Desktop\chocolatey-test-sandbox\shell\InstallNet4.ps1"
powershell.exe -ExecutionPolicy Unrestricted -File "C:\Users\WDAGUtilityAccount\Desktop\chocolatey-test-sandbox\shell\InstallChocolatey.ps1"
powershell.exe -ExecutionPolicy Unrestricted -File "C:\Users\WDAGUtilityAccount\Desktop\chocolatey-test-sandbox\shell\NotifyGuiAppsOfEnvironmentChanges.ps1"

REM Now running package tests
powershell.exe -ExecutionPolicy Unrestricted -File "C:\Users\WDAGUtilityAccount\Desktop\chocolatey-test-sandbox\Run-PackageTest.ps1"
