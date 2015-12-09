#!/bin/bash

# La idea es que cada carpeta/modulo tenga su propio instalador. Este fichero solamente llama
# a todos los instaladores

INSTALL_FILENAME="INSTALL.sh"


LOAD_MODULES="emacs bash git"

for module in $LOAD_MODULES; do
    if [ -d $module ] && [ -f $module/${INSTALL_FILENAME} ]; then
	$module/${INSTALL_FILENAME}
    fi
done

