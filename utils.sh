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
    /home/$USER/Android/sdk/emulator/emulator -list-avds | cat -n
    echo "${YELLOW}Please select an avd:${END}"
    read index
    avd=$(/home/$USER/Android/sdk/emulator/emulator -list-avds | sed "${index}q;d")
    [[ -n $avd ]] || { echo "${RED}Invalid choice. Please try again.${END}" >&2; return 1; }
    echo "${GREEN}Selected${END} ${CYAN}$avd${END}"
    /home/$USER/Android/sdk/emulator/emulator -avd $avd > /dev/null 2>&1 &;disown
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
        echo -e "\U1F9F9 ${GREEN}Running flc in ${PWD##*/}${END}"
        flc
    else
         echo "${YELLOW}Nothing to do, skipping$2${END}"
    fi
}

function flbu() {
    if isFlutterProject
    then
        if hasParameters "$1" "$2" "flbu <flavor> <true|false>"
        then
            buildDirExists
            echo -e "\U1F680 ${GREEN}Build appbundle: flb appbundle --no-sound-null-safety --flavor $1 --dart-define=isQA=$2${END}"
            flb appbundle --no-sound-null-safety --flavor $1 --dart-define=isQA=$2
        fi
    fi
}

function flbs() {
    if isFlutterProject
    then
        if hasParameters "$1" "$2" "flbu <flavor> <true|false>"
        then
            buildDirExists
            echo -e "\U1F680 ${GREEN}Build appbundle: flb appbundle --flavor $1 --dart-define=isQA=$2${END}"
            flb appbundle --flavor $1 --dart-define=isQA=$2
        fi
    fi
}

function flku() {
    if isFlutterProject
    then
        if hasParameters "$1" "$2" "flbu <flavor> <true|false>"
        then
            buildDirExists
            echo -e "\U1F4E6 ${GREEN}Build APK: flb apk --split-per-abi --no-sound-null-safety --flavor $1 --dart-define=isQA=$2${END}"
            flb apk --split-per-abi --no-sound-null-safety --flavor $1 --dart-define=isQA=$2
        fi
    fi
}

function flks() {
    if isFlutterProject
    then
        if hasParameters "$1" "$2" "flbu <flavor> <true|false>"
        then
            buildDirExists
            echo -e "\U1F4E6 ${GREEN}Build APK \U1F5C2: flb apk --split-per-abi --flavor $1 --dart-define=isQA=$2${END}"
            flb apk --split-per-abi --flavor $1 --dart-define=isQA=$2
        fi
    fi
}

function flru() {
    if isFlutterProject
    then
        if hasParameters "$1" "$2" "flbu <flavor> <true|false>"
        then
            echo -e "\U1F525 ${GREEN}Running: flr --flavor $1 --dart-define=isQA=$2${END}"
            flr --flavor $1 --dart-define=isQA=$2
        fi
    fi
}

function flca() {
    for d in ./*/ ; do (cd "$d" && buildDirExists); done
}

function rcd() {
    if [[ -z "$1" ]]; then
        echo "${RED}Error: No argument supplied. Usage: rcd <command> ${END}"
        return 1
    else
        for d in ./*/ ; do (cd "$d" && $1); done
    fi
}
