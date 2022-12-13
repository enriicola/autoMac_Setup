#!/usr/bin/env bash
##!/bin/sh
cd ..
echo "\033[0;36m Welcome! 🦆 \n my-automated-mac-setup started! 🚀 \033[0m" 

# TODO preferenzesys->angoli attivi (basso-sx=nota rapida, basso-dx=mostra desktop)
# TODO preferenzesys->dock e barra dei menù->ingrandimento on, dimensioni max, ingrandimento 50%, nascondi dock on(cmd+option+d), nascondi recenti
# TODO preferenzesys->dock->centro controllo->schermo->mostra barra dei menu off
# TODO preferenzesys->dock->centro controllo->suono->mostra barra dei menu off
# TODO preferenzesys->dock->centro controllo->riproduzione->mostra barra dei menu off
# TODO preferenzesys->dock->altrimoduli->accessibilità->* off
# TODO preferenzesys->dock->altrimoduli->batteria->barra menù=on, centrocontrollo=off, percentuale=on
# TODO preferenzesys->dock->altrimoduli->spotlight->off
# TODO preferenzesys->dock->altrimoduli->siri->off
# TODO preferenzesys->accountinternet->imposta icloud (on: foto, portachiavi, calendari, promemoria, note, safari, trova il mio mac, siri)
# TODO preferenzesys->accountinternet->imposta unige.it (on: mail)
# TODO preferenzesys->accountinternet->imposta outlook (on: mail, contatti)
# TODO preferenzesys->estensioni->(on: dropover, onedrive, telegram)
# TODO preferenzesys->estensioni->(on: dropover, onedrive, telegram)
# TODO preferenzesys->tastiera->(on: regola luminosità, disattiva retroilluminazione dopo 5 minuti)
# TODO preferenzesys->tastiera->abbreviazioni->azioni rapide->aggiungi workflow onedrive trash (cmd+ì)
# TODO preferenzesys->trackpad->velocità=max, clic silenzioso=on
# TODO preferenzesys->batteria->disattiva schermo=mai, disattiva dishi=on, oscura schermo=off, caricamento ottimizzato=off
# TODO preferenzesys->batteria->alimentatore->disattiva schermo=mai, impedisci etc=on, attiva per accesso rete=on
# TODO ordina preferenze da a a z

# TODO mail preferences->togli caselle smart + aggiungi ai preferiti cestino(tutte), spam(tutte), archivio + ordinale 

# TODO remove all widget; aggiungi meteo(grande) e sotto eventiCalendario(grande)
# TODO apri preferenze finder e modificale + modifica barra strumenti Finder + modifica barra laterale
# TODO apri preferenze safari e modificale + modifica barra strumenti safari
# TODO change profile picture for the mac/icloud
# TODO try to uninstall some defualt apps

# TODO apri impostazioni sfondo scrivania
# TODO imposta sfondo dinamico catalina
# TODO imposta sfondo secondario dinamico big sur
# TODO calibra colori schermo secondario
# TODO cambia foto profilo mac :)
# TODO disattiva salvaschermo

#osascript # TODO impostare sfondo catalina dinamico (+ sfondo secondario big sur dinamico)
#tell application "Finder"
#set desktop picture to POSIX file "/Library/Desktop Pictures/Solid Colors/Catalina.madesktop"
#end tell

# TODO in alternativa prova a registrare le tue azioni tramite automator e salvarle in un app da eseguire... 


echo "\033[0;34m Setting to 0 the wait time for showing the dock ⏲ \033[0m"
defaults write com.apple.dock autohide-delay -float 0; defaults write com.apple.dock autohide-time-modifier -int 0;killall Dock
# undo: defaults write com.apple.dock autohide-delay -float 0.5; defaults write com.apple.dock autohide-time-modifier -int 0.5; killall Dock

echo "\033[0;34m Disabling annoying disk warning when unmounting external devices 💾 \033[0m"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.DiskArbitration.diskarbitrationd.plist DADisableEjectNotification -bool YES && sudo pkill diskarbitrationd
echo -e "\033[1;31m Must restart Mac to take effect 🔁 \033[0m"
# re-enable annoyng disk warning:
# sudo defaults delete /Library/Preferences/SystemConfiguration/com.apple.DiskArbitration.diskarbitrationd.plist DADisableEjectNotification && sudo pkill diskarbitrationd

echo "\033[0;34m Changing screenshot default to jpg (replace with png to undo) 📸 \033[0m"
defaults write com.apple.screencapture type jpg

echo "\033[0;34m Making hidden apps transparent 🫥 \033[0m"
defaults write com.apple.Dock showhidden -bool TRUE && killall Dock

echo "\033[0;34m Opening some link to apps you have to manually download (no brew script) 🛠 \033[0m"
open https://apps.apple.com/us/app/accelerate-for-safari/id1459809092 
open https://apps.apple.com/it/app/piper/id1421915518?mt=12
open https://apps.apple.com/it/app/enki-learn-coding-programming/id993753145
open https://apps.apple.com/il/app/etoro-trade-stocks-crypto/id674984916
open https://apps.apple.com/it/app/nightshift-dark-mode/id1561604170?mt=12
open https://apps.apple.com/it/app/adguard-per-safari/id1440147259?mt=12
open https://apps.apple.com/it/app/pages/id409201541?mt=12
open https://apps.apple.com/it/app/keynote/id409183694?mt=12
open https://apps.apple.com/it/app/numbers/id409203825?mt=12
open https://apps.apple.com/it/app/dropover-easier-drag-drop/id1355679052?mt=12
open https://aka.ms/vs/mac/download
echo -e "\033[1;31m Wait for the Visual Studio download to be done! 🛑 \033[0m"
read -p "Press enter to continue 😬"

echo -e "\033[0;33m This next command will be a little slow 🐢\n In case of failure, you'll have to install VS manually 🥶 \033[0m"
sudo chmod -R 777 Downloads/visualstudioformacinstaller-*.dmg
sudo hdiutil attach Downloads/visualstudioformacinstaller-*.dmg
sudo cp -R "/Volumes/Visual Studio for Mac Installer/Install Visual Studio for Mac.app" /Applications
sudo codesign --force --deep --sign - /Applications/Install\ Visual\ Studio\ for\ Mac.app
sudo xattr -d -r com.apple.quarantine /Applications/Install\ Visual\ Studio\ for\ Mac.app 
sudo chmod -R 755 /Applications/Install\ Visual\ Studio\ for\ Mac.app/Contents/MacOS/Install_Visual_Studio 
sudo open -a /Applications/Install\ Visual\ Studio\ for\ Mac.app
hdiutil unmount /Volumes/Visual\ Studio\ for\ Mac\ Installer
rm /Users/enrico/Downloads/visualstudioformacinstaller-*.dmg

echo "\033[0;34m Installing Homebrew! 🍺 \033[0m"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "\033[0;34m Installing all the other apps i need (also I'll open them to setup some preferences) 💻🖥 \033[0m"
brew install --cask onedrive; sudo open -a onedrive
# TODO "scarica subito tutti i file di onedrive"=on
brew install --cask aldente; sudo open -a aldente
brew install git
git config --global user.email "enrico.pezzano@outlook.it"
git config --global user.name "EnricoPezzano"
brew install --cask microsoft-teams; sudo open -a "microsoft teams"
brew install --cask whatsapp; sudo open -a whatsapp
brew install --cask telegram; sudo open -a telegram
brew install --cask adguard-vpn; sudo open -a "adguard vpn"
brew install --cask iterm2; sudo open -a iterm2
brew install --cask rectangle; sudo open -a rectangle
brew install python #-tk@3.9
brew install python-tk@3.9
brew install --cask google-chrome; sudo open -a "Google Chrome" 
brew install --cask chromedriver
brew install --cask mamp; rm -rf /Applications/MAMP\ PRO.app; sudo open -a mamp
brew install --cask utm; sudo open -a utm
brew install --cask vlc; sudo open -a vlc
brew install --cask firefox; sudo open -a firefox
brew install --cask visual-studio-code; sudo open -a "visual studio code"
brew install --cask 4k-video-downloader; sudo open -a "4k video downloader"
brew install --cask discord; sudo open -a discord
brew install --cask intellij-idea; sudo open -a "intellij idea"
brew install --cask alt-tab; sudo open -a alttab
brew install --cask cheatsheet; sudo open -a cheatsheet
brew install --cask appcleaner; sudo open -a appcleaner
brew install --cask lunar; sudo open -a lunar
brew install maven
brew install --cask handbrake; sudo open -a handbrake
brew install --cask eclipse-java; sudo open -a "eclipse java"
brew install --cask spotify; sudo open -a spotify
brew install --cask the-unarchiver; sudo open -a "the unarchiver"
brew install --cask visual-studio; sudo open -a "visual studio"
brew install --cask oracle-jdk-javadoc
brew upgrade # just to be sure :)

echo "\033[0;34m Hopefully the following apps are installed at this time...opening them to setup some preferences 🔩 \033[0m"
open -a enki
open -a accelerate
open -a piper
open -a etoro
open -a nigthshift
open -a "adguard for safari"
open -a pages
open -a keynote
open -a numbers
open -a dropover

echo "\033[0;34m The next script will rename all to lowercase...and remove directories i don't use 🔡 \033[0m"
cd; for f in *; do mv "$f" "$f.tmp"; mv "$f.tmp" "`echo $f | tr "[:upper:]" "[:lower:]"`"; done
rm -r movies && rm bin && rmdir applicazioni

echo "\033[0;34m Syncing OneDrive on desktop... 🌥 \033[0m"
sudo rm -r /Users/enrico/Desktop && ln -s -n /Users/enrico/onedrive\ -\ unige.it /Users/enrico/Desktop

echo "\033[0;34m Adding my scripts to the local user bin directory 🤓 \033[0m"
sudo mkdir ../../usr/local/bin 
sudo cp onedrive\ -\ unige.it/my_projects/copy-of-bin/* ../../usr/local/bin
sudo chmod -R 777 ../../usr/local/bin/*

echo "\033[0;34m At this point Visual Studio for mac should be installed, so I'll remove the installer app 😏 \033[0m"
sudo rm -rf ../../Applications/Install\ Visual\ Studio\ for\ Mac.app

echo -e "\033[1;31m Wait for the UTM's virtual machine download from OneDrive to be done! 🛑 \n Next I will move VMs to the right directory 📂 \033[0m"
read -p "Press enter to continue 😬"
sudo mv onedrive\ -\ unige.it/Windows-arm.utm /Users/enrico/Library/Containers/com.utmapp.UTM/Data/Documents
sudo mv onedrive\ -\ unige.it/ubuntu-arm.utm /Users/enrico/Library/Containers/com.utmapp.UTM/Data/Documents

echo "\033[0;34m Finally I'll execute a bash script to check if it's all installed correctly 🥰 \033[0m"
cd /Applications
ls >> /Users/enrico/app-list.txt
cd
actual=$(cat app-list.txt)
expected=$(cat "automated-macos-setup/app-list.txt")
status=$(cmp --silent -- "$actual" "$expected")

if status==0; then
    echo -e "\033[0;32m Nothing went wrong! 😄 \033[0m"
    rm app-list.txt
else
    echo -e "\033[1;31m Something went wrong...check which apps is not in actual-app-list.txt 🙁 \033[0m"
    open automated-macos-setup/app-list.txt
    open app-list.txt
    exit
fi


echo "\033[0;36m Now I will edit some dock's preferences 🌟 \033[0m"
defaults write com.apple.dock persistent-apps -array
# TODO ordine app dock: safari mail foto calendario promemoria note appstore imovie monitoraggioattività enki etoro terminale teams discord mamp eclipse intellij vs vsc utm iterm2 +...
#                      ...adguardvpn handbrake vlc firefox spotify telegram whatsapp appcleaner onedrivetrash downloads
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Safari.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"

# defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Foto.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"

    # queste funzionano
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Enki.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Visual Studio.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
killall cfprefsd
killall Dock


# TODO trascrivi come commenti la disposizione delle app nel launchpad
# TODO disposizione launchpad: Altro(app che non uso etc), Produttività (pages etc), Estensioni safari(piper, aceelerate, adguard, nightshift), 
#                              Utility(rectangle, dropover, alttab, aldente, the-unarchiver, cheatsheet, lunar), Strumenti dev(intellij, vs, vsc, developer, eclpipse) + altre app

# TODO tagga come blu(unige) "cd; ../../usr/local/bin", "onedrive/unige", "onedrive/unige/pthread-barrier*" e "onedrive/img_7757.jpg"
# TODO tagga come rosso "onedrive/appunti n.parodi", "od/auto-setup", "cd; ../../usr/local/bin", cartelle dei corsi correnti (cs, fis, ssgs, icdd, tap), "od/documenti/CV", ...
                        #..."on/fis/davide.scarra", "od/doc/foto.danni", "od/doc/numbers", "hurt feeling report", "190kg deadlift", "da provare su tinder", "deadlift reel", ...
                        #..."IMG 4458.PNG, IMG_4459.PNG, IMG_4710.PNG, IMG_4818.PNG, IMG_5816.PNG, IMG_8873.PNG, IMG_8874.PNG, IMG_8875.PNG, IMG_8910.PNG, IMG_8911.PNG, IMG_8912...
                        #...IMG_8913.PNG, IMG_8914.PNG, IMG_8915.PNG, IMG_8916.PNG, IMG_8917.PNG, IMG_8918.PNG, IMG_8919.PNG, IMG_8921.PNG, IMG_8994.PNG", "just don't quit cbum"...
                        #..."od/doc/incidente/preventivo danni", "gym/programmazione ntc", "gym/RPReplay_Final1650020006.MP4", "gym/RPReplay_Final1654850997.MP4", ...
                        #..."scheda filippo d'🌲", "senza nome.pages"




read -p "Press enter to restart MacOs 🔁"
sudo shutdown -r now
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Old script: 
# brew install --cask xampp
# brew install --cask rider
# brew install --cask atom
# brew install --cask pgadmin4
# brew install --cask github
# brew install --cask visual-paradigm-ce
# brew install --cask xquartz
# brew install exiftool
# /usr/bin/automator ~/OneDrive\ -\ unige.it/scrivania/my_projects/automated_setup/OneDrive_aliasses_for_Desktop.workflow

# ANSI escape codes:
# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37

# curl -o /tmp/hblock 'https://raw.githubusercontent.com/hectorm/hblock/v3.4.0/hblock' \
#   && echo '4031d86cd04fd7c6cb1b7e9acb1ffdbe9a3f84f693bfb287c68e1f1fa2c14c3b  /tmp/hblock' | shasum -c \
#   && sudo mv /tmp/hblock /usr/local/bin/hblock \
#   && sudo chown 0:0 /usr/local/bin/hblock \
#   && sudo chmod 755 /usr/local/bin/hblock

# To instead install a .pkg, use this command:
# sudo installer -package /path/to/package -target "/Volumes/Macintosh HD"

# less fun alternative to manually install VS for mac
# sudo open -W  Downloads/visualstudioformacinstaller-*.dmg