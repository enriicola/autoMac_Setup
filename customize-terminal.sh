#!/usr/bin/env bash

echo "\033[0;34m Now I will customize the terminal 👀 \033[0m"

# TODO: Turn on SSH in the GUI by going to System Preferences > Sharing > Remote Login

brew install --cask fig; sudo open -a fig

touch ~/.hushlogin

filename='../.zshrc' # Define the filename
newtext="\n\nPROMPT='⚡️%B%F{green}%n@%d ~ %%%f%b '"

echo $newtext >> $filename

exec zsh