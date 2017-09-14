#!/bin/bash

# Ubicacion del instalador y base de los archivos
BASE_DIR=$(dirname "$(readlink -f "$0" )")

cp ${BASE_DIR}/.emacs ~/.emacs
cp -r ${BASE_DIR}/.emacs-lisp/ ~/.emacs-lisp/


