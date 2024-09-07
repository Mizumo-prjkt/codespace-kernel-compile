#!/bin/bash

# Using Rissu Fork of KSU instead because tiann removed the Non-GKI support
# Use tiann's installer if kernel is GKI, or modify some parts of this script to support it


case "$1" in
    "--kernel:4.19")
        HOOK_TARGET="4.19_hook_patch.diff"
        SPECIAL_TRIGGER=0
        ;;
    "--kernel:4.14")
        HOOK_TARGET="4.14_hook_patch.diff"
        SPECIAL_TRIGGER=0
        ;;
    "--kernel:4.9")
        HOOK_TARGET="4.9_hook_patch.diff"
        SPECIAL_TRIGGER=0
        ;;
    "--kernel:4.4")
        HOOK_TARGET="4.4_hook_patch.diff"
        SPECIAL_TRIGGER=0
        ;;
    [--help/-h]*)
        echo ""
        echo "KSU NON-GKI Setup src"
        echo "Brought to you by rissu (on ksu fork) and SUFandom(on this script)"
        echo "v1"
        echo ""
        echo "Usage:"
        echo "./nongki_ksu.sh --<args>"
        echo ""
        echo "Arguments"
        echo "  --help -h                   Shows this help page"
        echo "  --kernel:<version>          Uses the patch method readily available"
        echo "  --download-move-and-link    Self explainatory, just grab repo"
        echo "                              move it, and link it (not including patching)"
        echo ""
        echo "Patch:"
        echo "  Usage:"
        echo "  ./nongki_ksu.sh --kernel:4.4"
        echo ""
        echo "  Version:"
        echo "      4.4 Kernel      --kernel:4.4"
        echo "      4.9 Kernel      --kernel:4.9"
        echo "      4.14 Kernel     --kernel:4.14"
        echo "      4.19 Kernel     --kernel:4.19"
        echo ""
        echo "For GKI Kernels, do check with tiann's installer script instead"
        echo "Earlier than 4.4 isn't supported"
        echo ""
        exit
        ;;
    "--download-move-and-link")
        SPECIAL_TRIGGER=1
    *)
        ./nongki_ksu.sh --help
        exit
        ;;
esac
        



ROOT="$(pwd)" # ENV 
FULL_SRC="$ROOT/$SOURCE" # May be self-explanatory
SOURCE="" # Kernel Source
SYMLINKTO="$FULL_SRC/drivers/kernelsu" # For symlink
DRIVERS="$FULL_SRC/drivers" # also explanatory
PATCHRUN="$FULL_SRC/KernelSU/hook_patch/$HOOK_TARGET"
KSU_MOVED="$FULL_SRC/KernelSU"

function clone_service() {
    # Cloning KSU Fork
    # git clone https://github.com/rsuntk/KernelSU
    git clone https://github.com/SUFandom/KernelSU
}

function mvfile () {
    # MOVE KSU TO KERNEL SOURCE
    mv KernelSU $SOURCE/
}

function linkit() {
    # Link KSU
    cd $DRIVERS
    ln -sf "$SYMLINKTO" "$KSU_MOVED/kernel"
}

function patch() {
    cd $FULL_SRC # Force redir to repo
    git apply --stat --check "$KSU_MOVED/$HOOK_TARGET"
    git apply --stat --check "$KSU_MOVED/Kcm-4.19-a12s.diff"
}
function revert_dir_location() {
    cd $ROOT
}

case $SPECIAL_TRIGGER in
    0)
        while true; do
            read -p "Do you want to try KSU and apply patches? [Y/n]: " ans
            case $ans in
                [Y/y]*)
                    echo "OK!"
                    break
                [N/n]*)
                    exit 1
                    exit 1 # if in doubt, double it, like gambling
                    break
                    ;;
                *)
                    echo "$ans is wrong"
                    clear
                    ;;
            esac
        done
        echo "[-] Grabbing KSU"
        clone_service
        echo "[Y] DONE"
        echo "[-] Moving"
        mvfile
        echo "[Y] DONE"
        echo "[-] Linking"
        linkit
        echo "[Y] Done"
        echo "[-] Patching"
        patch
        echo "[Y] Done"
        revert_dir_location
        exit
        ;;
    1)
        while true; do
            read -p "Do you want to try KSU? [Y/n]: " ans
            case $ans in
                [Y/y]*)
                    echo "OK!"
                    break
                [N/n]*)
                    exit 1
                    exit 1 # if in doubt, double it, like gambling
                    break
                    ;;
                *)
                    echo "$ans is wrong"
                    clear
                    ;;
            esac
        done
        echo "[-] Grabbing KSU"
        clone_service
        echo "[Y] DONE"
        echo "[-] Moving"
        mvfile
        echo "[Y] DONE"
        echo "[-] Linking"
        linkit
        echo "[Y] Done"
        revert_dir_location
        exit
        ;;



