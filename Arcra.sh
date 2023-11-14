#!/bin/bash

# Greet the user
gum style \
	--foreground 255 --border-foreground 255 --border double \
	--align center --width 40 --margin "1" --padding "2" \
	'Hello and welcome to Arcra!'

delete_project=$(gum input --cursor.foreground "#FF0" --prompt.foreground "#FF0" \
    --prompt "Assuming you have an existing project already, would you like to start over? " --placeholder "Don't worry if not")
    
if [ "$delete_project" == "y" ]; then
    clear
directory=$(gum input --cursor.foreground "#FF0" --prompt.foreground "#FF0" \
    --prompt "Please enter the path to your existing project: " --placeholder "I'll wait")
    
    rm -r "$directory"
    
    echo "Old project deleted successfully."
    
else 
    echo "No worries. Moving on." && sleep 3 && clear
fi

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
