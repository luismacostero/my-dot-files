#!/bin/bash

# La idea es que cada carpeta/modulo tenga su propio instalador. Este fichero solamente llama
# a todos los instaladores

INSTALL_FILENAME="INSTALL.sh"
# Ubicacion del instalador y base de los archivos
BASE_DIR=$(dirname "$(readlink -f "$0" )")


LOAD_MODULES="emacs bash git"

for module in $LOAD_MODULES; do
    if [ -d $module ] && [ -f $BASE_DIR/$module/${INSTALL_FILENAME} ]; then
	$BASE_DIR/$module/${INSTALL_FILENAME}
    fi
done

