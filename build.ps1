$uncompiled_binaries_folder = "./src-tauri/uncompiled-binaries"
$compiled_binary_folder_path = "./src-tauri/binaries"
$pyinstaller_workdir = "./src-tauri/uncompiled-binaries/build_files/pyinstaller_work"
$pyinstaller_distdir = "./src-tauri/binaries/"

function build_binaries {
    Get-ChildItem $uncompiled_binaries_folder | ForEach-Object {
        $binary = $_.FullName
        pyinstaller --onefile --distpath $pyinstaller_distdir --workpath $pyinstaller_workdir $binary
        Write-Host $binary
    }
}

if (Test-Path $compiled_binary_folder_path -PathType Container) {
    # If the folder exists, run your command
    build_binaries
} else {
    # If the folder doesn't exist, create it and run your command
    New-Item -ItemType Directory -Path $compiled_binary_folder_path
    build_binaries
}

npm run tauri build

# ChatGPT generated code, UNTESTED