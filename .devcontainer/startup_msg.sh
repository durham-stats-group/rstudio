#!/bin/bash

function write_text_to_file {
    local text="$1"
    local delay="$2"
    local outfile="$3"

    for (( i=0; i<${#text}; i++ )); do
        char="${text:$i:2}"
        if [[ "$char" == '\n' ]]; then
            echo -n -e "\n" >> $outfile
            ((i+=1))
        else
            echo -n "${text:$i:1}" >> $outfile
        fi
        sleep "$delay"
    done
}

echo -e "# Codespaces RStudio Server\n\n" > README.md

write_text_to_file "Welcome to your server! 😃 I am starting up RStudio in the background now, so please hang on a moment :)\n\nLoading ." \
    "0.1" \
    "README.md"

write_text_to_file ".....\n" \
    "1.25" \
    "README.md"

write_text_to_file "\nThe server should be ready now. 🥳 Please click the following link and choose the green Open button when prompted:\n\n" \
    "0.1" \
    "README.md"

echo https://${CODESPACE_NAME}-8787.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}/ >> README.md

write_text_to_file "\nIf you get a message about R taking longer than normal to start, click Reload. If you get any other problem, close the tab and try clicking the above link again after waiting for a few moments ⏳\n\nIf you encounter any problems, please report them to 📧 louis.aslett@durham.ac.uk\n\nHappy coding! 🤓" \
    "0.1" \
    "README.md"
