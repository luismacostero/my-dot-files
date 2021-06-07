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

    #setting proper permisons
    chmod 644 $HOME/.emacs
    chmod -R u+rwX,go+rX,go-w $HOME/emacs_config

    echo "Done :)"
    echo "......"
    echo "La primera ejecución de emacs puede tardar unos segundos en instalar todos los paquetes"
    echo "OJO: Antes de iniciar emacs por primera vez, asegurate de tener instalado los siquitens paquetes:"
    echo -e "\t-latex (texlive-latex-base, extra, recommended, etc, etc)"
    echo -e "\t-auctex"
    echo -e "\t-clang (libclang-.....-dev >= 3.5-deb)"
    echo -e "\t-global"
    echo -e "\t-cmake"
    echo ""
fi


