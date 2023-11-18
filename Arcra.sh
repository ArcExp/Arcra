#!/bin/bash

# TODO: Add feature to sync existing files with google drive and other cloud services

while true; do
    gum style \
        --foreground 255 --border-foreground 255 --border double \
        --align center --width 40 --margin "1" --padding "2" \
        'Hello and welcome to Arcra!'

    gum style 'What do you want to do? This program will loop until you choose to exit'

    choice=$(gum choose "create project" "delete existing project" "launch writing program" "create plaintext file" "read existing plaintext file" "exit")

    case "$choice" in
        "delete existing project")
            clear
            location=$(gum input --cursor.foreground "#FF0" --prompt.foreground "#FF0" \
                --prompt "Please enter the directory containing your existing project: " --placeholder "I'll wait")
                
            directory=$(gum input --cursor.foreground "#FF0" --prompt.foreground "#FF0" \
                --prompt "Now enter the name of your project folder: " --placeholder "I'll wait")
            clear
            cd || exit
            cd "$location" || exit
            rm -r "$directory"
            echo "Old project deleted successfully." && sleep 3 && clear
            ;;

        "create project")
            clear
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
            
            tree "$story_name" && sleep 3 && clear
            ;;

        "launch writing program")
            clear
            # Prompt the user for the app name
            chosen_editor=$(gum input --prompt "Enter your editor of choice: " --placeholder "eww, libreoffice") 

            # Launch the chosen app and close Arcra
            gum spin -s line --title 'Launching your chosen editor for you in a few seconds...' sleep 2 && clear && "$chosen_editor"
            ;;

        "create plaintext file")
            clear
            file=$(gum input --prompt "What do you want to name your file? Include the file extension, e.g .txt " --placeholder "any name works")
            
            location=$(gum input --prompt "And where do you want to create it? " --placeholder "choose wisely")
            cd || exit
            cd "$location" || exit
            touch "$file"
            gum style 'File created successfully' && tree && sleep 3 && clear
            ;;

        "read existing plaintext file")
            clear
            location=$(gum input --prompt "Where is this file located? " --placeholder "specify it carefully")
            cd || exit
            cd "$location" || exit

            file=$(gum input --prompt "And what is it called? Include the file extension please " --placeholder "is it a nice name?")
            gum pager < "$file"
            ;;

        "exit")
            clear && echo 'Alright, bye!' && sleep 3 && clear && exit
            ;;
    esac
done
