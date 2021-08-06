#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m" 
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

function hasParameter() {
    if [ -z "$1" ]; then
        echo "${RED}Error: No argument supplied. Usage: $2${END}"
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
        if hasParameter "$1" "flbu <true|false>"
        then
            buildDirExists
            echo -e "\U1F680 ${GREEN}Build appbundle: flb appbundle --no-sound-null-safety --dart-define=isQA=$1${END}"
            flb appbundle --no-sound-null-safety --dart-define=isQA=$1
        fi
    fi
}

function flbs() {
    if isFlutterProject
    then
        if hasParameter "$1" "flbs <true|false>"
        then
            buildDirExists
            echo -e "\U1F680 ${GREEN}Build appbundle: flb appbundle --dart-define=isQA=$1${END}"
            flb appbundle --dart-define=isQA=$1
        fi
    fi
}

function flku() {
    if isFlutterProject
    then
        if hasParameter "$1" "flku <true|false>"
        then
            buildDirExists
            echo -e "\U1F4E6 ${GREEN}Build APK: flb apk --split-per-abi --no-sound-null-safety --dart-define=isQA=$1${END}"
            flb apk --split-per-abi --no-sound-null-safety --dart-define=isQA=$1
        fi
    fi
}

function flks() {
    if isFlutterProject
    then
        if hasParameter "$1" "flks <true|false>"
        then
            buildDirExists
            echo -e "\U1F4E6 ${GREEN}Build APK \U1F5C2: flb apk --split-per-abi --dart-define=isQA=$1${END}"
            flb apk --split-per-abi --dart-define=isQA=$1
        fi
    fi
}

function flru() {
    if isFlutterProject
    then
        if hasParameter "$1" "flru <true|false>"
        then
            echo -e "\U1F525 ${GREEN}Running: flr --dart-define=isQA=$1${END}"
            flr --dart-define=isQA=$1
        fi
    fi
}

function flca() {
    for d in ./*/ ; do (cd "$d" && buildDirExists); done
}