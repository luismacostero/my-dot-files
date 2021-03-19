#!/bin/bash


base=$(dirname "$(readlink -f "$0" )")


echo "OJO: esto te va a borrar los ficeros ~.bash y ~/bash_config."
echo 

read -r -p "Do you want to continue? [Y/n] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    backup="/tmp/old_bash"
    echo "haciendo copia de seguridad en $backup ..."

    [ -d ${backup} ] || mkdir "$backup"
    cp ~/.bashrc $backup
    cp -r ~/bash_config $backup

    cp ${base}/bashrc $HOME/.bashrc
    cp -r ${base}/bash_config $HOME

    chmod 644 $HOME/.bashrc
    chmod 755 $HOME/bash_config
    chmod 644 $HOME/bash_config/*

    echo "Done :)"
fi
