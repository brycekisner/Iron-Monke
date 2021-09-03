# Builds a .qmod file for loading with QuestPatcher
$NDKPath = Get-Content $PSScriptRoot/ndkpath.txt

$buildScript = "$NDKPath/build/ndk-build"
if (-not ($PSVersionTable.PSEdition -eq "Core")) {
    $buildScript += ".cmd"
}

$ArchiveName = "ironmonke_v1.1.1.qmod"
$TempArchiveName = "ironmonke_v1.1.1.qmod.zip"

& $buildScript NDK_PROJECT_PATH=$PSScriptRoot APP_BUILD_SCRIPT=$PSScriptRoot/Android.mk NDK_APPLICATION_MK=$PSScriptRoot/Application.mk
Compress-Archive -Path "./libs/arm64-v8a/libironmonke.so", "./libs/arm64-v8a/libbeatsaber-hook_2_2_5.so", "./mod.json", "./ironMonke.png" -DestinationPath $TempArchiveName -Force
Move-Item $TempArchiveName $ArchiveName -Force