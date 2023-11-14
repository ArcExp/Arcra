#!/bin/bash

# Greet the user
echo "Hello, $(whoami)! Welcome to Arcra!"

# Prompt the user for a name for their story
story_name=$(gum input --cursor.foreground "#FF0" --prompt.foreground "#FF0" \
    --prompt "Please enter a name for your story project: " --placeholder "Any name works") 

# Create a directory with the entered name
mkdir "$story_name"
mkdir "$story_name/setting"
mkdir "$story_name/characters"
mkdir "$story_name/worldbuilding"
mkdir "$story_name/story_research"
mkdir "$story_name/story_outline"
mkdir "$story_name/chapters"
mkdir "$story_name/scenes"

# Display a success message
echo "Project '$story_name' created successfully! The directory contains subdirectories to help structure your story as part of your project." && sleep 3 && clear

# Ask the user if they want to launch an app
launch_app=$(gum input --prompt "Would you like to launch your favourite editor to start writing your story? " --placeholder "(y/n)") 

if [ "$launch_app" == "y" ]; then
    clear
    # Prompt the user for the app name
    chosen_editor=$(gum input --prompt "Enter your editor of choice: " --placeholder "eww, libreoffice") 

    # Launch the chosen app and close Arcra
    echo "Launching $chosen_editor for you in a few seconds. See you later $(whoami)!" && $chosen_editor && sleep 2 && clear && exit
else 
    echo "Alright. See you later $(whoami)!" && sleep 2 && clear && exit
fi
