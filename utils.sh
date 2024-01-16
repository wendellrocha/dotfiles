#!/bin/bash

export RED="\e[31m"
export GREEN="\e[32m"
export YELLOW="\e[33m"
export CYAN="\e[36m"
export END="\e[0m"

# **************************************** Flutter Utils Functions -- INIT ****************************************

function isFlutterProject() {
    if [ ! -f "pubspec.yaml" ]; then
        echo -e "${RED}Error: No pubspec.yaml file found.${END}"
        echo -e "${RED}This command should be run from the root of your Flutter project.${END}"
        return 1
    else
        return 0
    fi
}

function isVscodeTerminal() {
    if [[ "$TERM_PROGRAM" == "vscode" ]]; then
        return 0
    else
        return 1
    fi
}



function buildDirExists() {
    if [[ -d "build" || -d ".dart_tool" ]]; then
        version=$(jq .flutter .fvmrc | tr -d \")
        isVscodeTerminal
        if [ ! -z "$version" ] && [ $? -eq 1 ]; then
            echo -e "${YELLOW}FVM found, using flutter local (${CYAN}version: $version${END}${YELLOW})${END}.\n ${GREEN}Running flutter clean in ${CYAN}${PWD##*/}${END}${END}"
            fvm flutter clean
            return 0;
        else
            echo "${YELLOW}FVM not found, using flutter global${END}"    
        fi
        echo -e "\U1F9F9 ${GREEN}Running flutter clean in ${PWD##*/}${END}"
        flutter clean
    else
         echo "${CYAN}Nothing to do, skipping$2${END}"
    fi
}

function flca() {
    for d in ./*/ ; do (cd "$d" && buildDirExists); done
}

function flci() {
    if isFlutterProject; then
        buildDirExists && flget
    fi
}

function flc() {
    if isFlutterProject; then
        buildDirExists
    fi
}

function fld() {
    if isFlutterProject; then
        version=$(jq .flutter .fvmrc | tr -d \")
        isVscodeTerminal
        if [ ! -z "$version" ] && [ $? -eq 1 ]; then
            echo "${YELLOW}FVM found, using flutter local (${CYAN}version: $version${END}${YELLOW})${END}.\n ${GREEN}Running flutter doctor in ${CYAN}${PWD##*/}${END}${END}"
            fvm flutter doctor
            return 0;
        else
            echo "${YELLOW}FVM not found, using flutter global${END}"
        fi
        echo -e "\U1F637 ${GREEN}Running flutter doctor in ${PWD##*/}${END}"
        flutter doctor
    fi
}

function flget() {
    if isFlutterProject; then
        version=$(jq .flutter .fvmrc | tr -d \")
        isVscodeTerminal
        if [ ! -z "$version" ] && [ $? -eq 1 ]; then
            echo "${YELLOW}FVM found, using flutter local (${CYAN}version: $version${END}${YELLOW})${END}. \n${GREEN}Running flutter pub get in ${CYAN}${PWD##*/}${END}${END}"
            fvm flutter pub get
            return 0;
        else
            echo "${YELLOW}FVM not found, using flutter global${END}"
        fi
        echo -e "\U1F9F9 ${GREEN}Running flutter pub get in ${PWD##*/}${END}"
        flutter pub get
    fi
}

# **************************************** Flutter Utils Functions -- END ****************************************


function rcd() {
    if [[ -z "$1" ]]; then
        echo "${RED}Error: No argument supplied. Usage: rcd <command> ${END}"
        return 1
    else
        for d in ./*/ ; do (cd "$d" && "$@"); done
    fi
}

function emulator() {
    EMULATOR_DIR=""

    if [[ "$OSTYPE" == "darwin"* ]]; then
        EMULATOR_DIR=$ANDROID_HOME/emulator
    else
        EMULATOR_DIR=/home/$USER/Android/sdk/emulator/
    fi

    $EMULATOR_DIR/emulator -list-avds | cat -n
    echo "${YELLOW}Please select an avd:${END}"
    read index
    avd=$($EMULATOR_DIR/emulator -list-avds | sed "${index}q;d")
    [[ -n $avd ]] || { echo "${RED}Invalid choice. Please try again.${END}" >&2; return 1; }
    echo "${GREEN}Selected${END} ${CYAN}$avd${END}"
    $EMULATOR_DIR/emulator -avd $avd -no-audio > /dev/null 2>&1 &;disown
}

function hasParameters() {
    if [[ -z "$1" || -z "$2" ]]; then
        echo "${RED}Error: No argument supplied. Usage: $3${END}"
        return 1
    else
        return 0
    fi
}

function clear-branches() {
    if [[ ! -d ".git" ]]; then
        echo "${RED}Nothing to do, exiting...${END}"
        return 1
    fi
    
    git branch -vv | grep ': gone]'|  grep -v "\*" | awk '{ print $1; }' | xargs -r git branch -d
}

function cfile() {
    if [[ -z "$1" || -z "$2" ]]; then
        echo "${RED}Error: No argument supplied. Usage: cfile <movie> <extension>${END}"
        return 1
    else
        fileName=$(echo $1 | cut -d "." -f 1)
        ffmpeg -i $1 "$fileName.$2"
    fi
}

function getIp() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2
    else
        ip a | grep "scope" | grep -Po '(?<=inet )[\d.]+'
    fi
}

function countfiles() {
  find $1 -type f | wc -l
}


function website-status() {
  curl -s --head --request GET $1 | grep "200 OK"
}

function copy () {
  pbcopy < $1
}

function update-nvm() {
  (
    cd "$NVM_DIR"
    git fetch --tags origin
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
  ) && \. "$NVM_DIR/nvm.sh"
}

function update-zprezto() {
  zprezto-update && (cd $HOME/.zprezto-contrib && git pull --recurse-submodules)
}

function connect-device() {
  default=$(adb shell settings get system screen_off_timeout)
  adb shell settings put system screen_off_timeout 43200000 ; scrcpy -Sw ; adb shell settings put system screen_off_timeout $default;
}

if [[ "$OSTYPE" == "darwin"* ]]; then
    source $HOME/dotfiles/macos/update-all.zsh
fi