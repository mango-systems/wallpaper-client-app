#!/bin/bash

uncompiled_binaries_folder="./src-tauri/uncompiled-binaries"
compiled_binary_folder_path="./src-tauri/binaries"

pyinstaller_workdir="./src-tauri/uncompiled-binaries/build_files/pyinstaller_work"
# pyinstaller_distdir="./src-tauri/uncompiled-binaries/build_files/pyinstaller_dist"
pyinstaller_distdir="./src-tauri/binaries/"
# echo "$(pwd)"

# echo $uncompiled_binaries_folder

function build_binaries (){
    for binary in "$uncompiled_binaries_folder"/*
do
    # pyinstaller "$binary"
    pyinstaller --onefile --distpath $pyinstaller_distdir --workpath $pyinstaller_workdir $binary
    # echo $binary
    echo $binary
done
}


if [ -d "$compiled_binary_folder_path" ]; then
  # If the folder exists, run your command
  build_binaries
else
  # If the folder doesn't exist, create it and run your command
  mkdir "$compiled_binary_folder_path"
  build_binaries
fi
 
npm run tauri build

# add compiled binaries to .gitignore as they are platform specific

