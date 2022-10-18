#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"
END="\e[0m"

function isFlutterProject() {
    if [ ! -f "pubspec.yaml" ]; then
        echo -e "${RED}Error: No pubspec.yaml file found.${END}"
        echo -e "${RED}This command should be run from the root of your Flutter project.${END}"
        return 1
    else
        return 0
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

function buildDirExists() {
    if [[ -d "build" || -d ".dart_tool" ]]; then
        echo -e "\U1F9F9 ${GREEN}Running flutter clean in ${PWD##*/}${END}"
        version=$(cat .fvm/fvm_config.json | grep flutterSdkVersion | cut -f2 -d":" | cut -f1 -d"," | tr -d '"')
        if [[ ! -z $version ]]; then
            echo "${YELLOW}FVM found, using flutter local (version: $version)${END}"
        else 
            echo "${YELLOW}FVM not found, using flutter global${END}"
        fi
        fvm flutter clean
    else
         echo "${YELLOW}Nothing to do, skipping$2${END}"
    fi
}

function flca() {
    for d in ./*/ ; do (cd "$d" && buildDirExists); done
}

function flc() {
    if isFlutterProject
    then
        buildDirExists
    fi
}

function flget() {
    if isFlutterProject
    then
        echo -e "\U1F9F9 ${GREEN}Running flutter pub get in ${PWD##*/}${END}"
        version=$(cat .fvm/fvm_config.json | grep flutterSdkVersion | cut -f2 -d":" | cut -f1 -d"," | tr -d '"')
        if [[ ! -z $version ]]; then
            echo "${YELLOW}FVM found, using flutter local (version: $version)${END}"
        else 
            echo "${YELLOW}FVM not found, using flutter global${END}"
        fi
        fvm flutter pub get
    fi
}

function rcd() {
    if [[ -z "$1" ]]; then
        echo "${RED}Error: No argument supplied. Usage: rcd <command> ${END}"
        return 1
    else
        for d in ./*/ ; do (cd "$d" && $1); done
    fi
}

function bankeiro-run() {
    DIR_NAME=${PWD##*/}
    echo $DIR_NAME
    if [[ "$DIR_NAME" == "bankeiro_app" ]]; then
        cd packages/mobile/android && ./gradlew clean && cd ../ && yarn android --active-arch-only && yarn start --reset-cache
    else
        echo "${RED}Error: Nothing to do, exiting...${END}"
    fi
}
