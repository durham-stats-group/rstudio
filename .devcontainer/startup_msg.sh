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

echo -e "# Codespaces RStudio Server\n" > README.md

write_text_to_file "Welcome " \
    "0.1" \
    "README.md"

if [ -e "/home/rstudio/.notfirst" ]; then
    write_text_to_file "back " \
        "0.1" \
        "README.md"
fi

write_text_to_file "to your server! 😃 I am starting up RStudio in the background now, so please hang on a moment :)\n\n" \
    "0.1" \
    "README.md"

if [ ! -e "/home/rstudio/.notfirst" ]; then
    write_text_to_file "Note: I see this is the first time running this server, so it takes a bit longer to start than when you re-run the same server in future, sorry for the wait!\n\nStarting ..." \
        "0.1" \
        "README.md"
    t=100
else
    t=20
fi

for ((i=1; i<=${t}; i++)); do
    sed -i '$d' README.md
    percentage=$((i * 100 / t))
    printf "%d%% complete" "${percentage}" >> README.md
    sleep 1
done

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

touch /home/rstudio/.notfirst
