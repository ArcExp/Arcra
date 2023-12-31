#!/bin/bash

# TODO: Add feature to sync existing files with google drive and other cloud services

counter=1

while true; do
    case $counter in
        1)
            prompt='What do you want to do?'
            ;;
        2)
            prompt='What do you want to do now?'
            ;;
        3)
            prompt='Anything else?'
            ;;
        *)
            prompt='What next?'
            ;;
    esac
    gum style \
        --foreground 255 --border-foreground 255 --border double \
        --align center --width 40 --margin "1" --padding "2" \
        'Hello and welcome to Arcra!'

    gum style "$prompt"

    choice=$(gum choose "create project" "delete existing project" "launch writing program" "create plaintext file" "read existing plaintext file" "exit")

    case "$choice" in
        "delete existing project")
            clear
            location=$(gum input --prompt "Please enter the directory containing your project, e.g Downloads: " --placeholder "Documents, perhaps?")
                
            directory=$(gum input --prompt "Now enter the name of your project folder: " --placeholder "take your time")
            clear
            cd || exit
            cd "$location" || exit
            rm -r "$directory"
            echo "Old project deleted successfully." && sleep 3 && clear
            ;;

        "create project")
            clear
            # Prompt the user for a name for their story
            story_name=$(gum input --prompt "What do you want to call your story project? " --placeholder "Any name works")
                
            location=$(gum input --prompt "And where do you want to create it - Documents, perhaps? " --placeholder "choose wisely")
            cd || exit
            cd "$location" || exit
            
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

            # Launch the chosen editor
            gum spin -s line --title 'Launching your chosen editor for you in a few seconds...' sleep 2 && clear && "$chosen_editor" >/dev/null 2>&1
            ;;

        "create plaintext file")
            clear
            file=$(gum input --prompt "What do you want to name your file? Include the file extension. " --placeholder "any name works")
            
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
   esac

    if [ "$choice" == "exit" ]; then
        clear && echo 'Alright, bye!' && sleep 3 && clear && exit
    fi

    ((counter++))
    if [ $counter -gt 3 ]; then
        counter=1
    fi
done
