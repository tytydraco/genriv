#!/usr/bin/env bash

COMMAND="$1"

WORKING="working"
TEMPLATE="template"

RIV_FILE="input.riv"
RIV_ANDROID="$WORKING/android/app/src/main/res/raw/input.riv"
RIV_FLUTTER="$WORKING/flutter/assets/input.riv"
RIV_IOS="$WORKING/ios/input.riv"

WORKING_ANDROID="$WORKING/android"
WORKING_FLUTTER="$WORKING/flutter"
WORKING_IOS="$WORKING/ios"
TEMPLATE_ANDROID="$TEMPLATE/android"
TEMPLATE_FLUTTER="$TEMPLATE/flutter"
TEMPLATE_IOS="$TEMPLATE/ios"

# Prepare the working directory.
mkdir -p "$WORKING"

# Clear the working directory.
function clear() {
    rm -rf "$WORKING"/*
}

# Inject the Rive file into the working directory.
function inject() {
    if [ ! -f "$RIV_FILE" ]; then
        echo "Rive file not found: $RIV_FILE"
        exit 1
    fi

    if [ -d "$WORKING_ANDROID" ]; then
        cp "$RIV_FILE" "$RIV_ANDROID"
        echo "Rive file copied to: $RIV_ANDROID"
    else
        echo "Android project not found: $WORKING_ANDROID"
    fi

    if [ -d "$WORKING_FLUTTER" ]; then
        cp "$RIV_FILE" "$RIV_FLUTTER"
        echo "Rive file copied to: $RIV_FLUTTER"
    else
        echo "Flutter project not found: $WORKING_FLUTTER"
    fi

    if [ -d "$WORKING_IOS" ]; then
        cp "$RIV_FILE" "$RIV_IOS"
        echo "Rive file copied to: $RIV_IOS"
    else
        echo "iOS project not found: $WORKING_IOS"
    fi
}

# Clone the template project to the working directory.
function clone() {
    cp -r "$TEMPLATE_ANDROID" "$WORKING_ANDROID"
    echo "Android project cloned to: $WORKING_ANDROID"

    cp -r "$TEMPLATE_FLUTTER" "$WORKING_FLUTTER"
    echo "Flutter project cloned to: $WORKING_FLUTTER"

    cp -r "$TEMPLATE_IOS" "$WORKING_IOS"
    echo "iOS project cloned to: $WORKING_IOS"

    [ -f "$RIV_FILE" ] && inject 
}

# Show the usage.
function usage() {
    echo "Usage: $0 <command>"
    echo "Commands:"
    echo -e "\tclear\tClear the working directory."
    echo -e "\tclone\tClone the template project to the working directory."
    echo -e "\tinject\tInject the Rive file into the working directory."
    echo -e "\tusage\tShow the usage."
}

# Process the command.
case "$COMMAND" in
    "clear")
        clear
        ;;
    "clone")
        clone
        ;;
    "inject")
        inject
        ;;
    "usage")
        usage
        ;;
    *)
        echo "Invalid command: $COMMAND"
        echo
        usage
        exit 1
esac