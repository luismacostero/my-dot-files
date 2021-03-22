#!/bin/bash

# Ubicacion del instalador y base de los archivos
base=$(dirname "$(readlink -f "$0" )")


echo "OJO: esto te va a borrar los ficeros ~.emacs y ~/emacs_config."
echo 

read -r -p "Do you want to continue? [y/n] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
   backup="/tmp/old_emacs"
    echo "haciendo copia de seguridad en $backup ..."

    [ -d ${backup} ] || mkdir "$backup"
    [ -f ~/.emacs ] && cp ~/.emacs $backup
    [ -d ~/emacs_config ] && cp -r ~/emacs_config $backup

    cp ${base}/emacs $HOME/.emacs
    cp -r ${base}/emacs_config $HOME

#chapuza de permisos. Hacer mejor la proixma vez
#    chmod 644 $HOME/.emacs

#    chmod +x $HOME/emacs_config/
#    chmod 644 $HOME/emacs_config/*

#    chmod +x $HOME/emacs_config/*/
#    chmod 644 $HOME/emacs_config/*/*

#    chmod +x $HOME/emacs_config/*/*/
#    chmod 644 $HOME/emacs_config/*/*/*

    echo "Done :)"
fi


