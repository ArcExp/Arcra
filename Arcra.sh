#!/bin/bash

# TODO: Restructure script to let the user choose what to do, adding code to choose a directory to create their story project in, read existant files in their story project directory and possibly sync with a google drive account in addition to the features that currently exist in this script

# Greet the user
gum style \
	--foreground 255 --border-foreground 255 --border double \
	--align center --width 40 --margin "1" --padding "2" \
	'Hello and welcome to Arcra!'

gum style 'What do you want to do?'

choice=$(gum choose "create project" "delete existing project" "launch writing program" "create plaintext file" "read existing plaintext file" "exit")

# code for loop, with the following message presented after the user makes their first choice?
gum style 'What do you want to do now?'

if [ "$choice" == "delete existing project" ]; then
clear
directory=$(gum input --cursor.foreground "#FF0" --prompt.foreground "#FF0" \
    --prompt "Please enter the path to your existing project: " --placeholder "I'll wait")
    
    rm -r "$directory"
    
    echo "Old project deleted successfully." && sleep 3 && clear
fi

if [ "$choice" == "create project" ]; then

# Prompt the user for a name for their story
story_name=$(gum input --cursor.foreground "#FF0" --prompt.foreground "#FF0" \
    --prompt "Please enter a name for your new story project: " --placeholder "Any name works")

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
echo "Project '$story_name' created successfully! This is what the directory looks like: " 

tree $story_name/ && sleep 3 && clear
fi

if [ "$choice" == "launch writing program" ]; then
    # Prompt the user for the app name
    chosen_editor=$(gum input --prompt "Enter your editor of choice: " --placeholder "eww, libreoffice") 

    # Launch the chosen app and close Arcra
    gum spin -s line --title 'Launching your chosen editor for you in a few seconds...' sleep 2 && clear && $chosen_editor
fi

if [ "$choice" == "create plaintext file" ]; then
    file=$(gum input --prompt "What do you want to name your file? " --placeholder "any name works")
    
    location=$(gum input --prompt "And where do you want to create it? " --placeholder "choose wisely")
    cd
    cd $location
    touch $file
    gum style 'File created successfully' && tree && sleep 3 && clear
fi

if [ "$choice" == "read existing plaintext file" ]; then
location=$(gum input --prompt "Where is this file located? " --placeholder "specify it carefully")
cd
cd $location

file=$(gum input --prompt "And what is it called? Include the file extension please " --placeholder "is it a nice name?")
gum pager < $file
fi

if [ "$choice" == "exit" ]; then
clear && echo 'Alright, bye!' && sleep 3 && clear && exit
fi
