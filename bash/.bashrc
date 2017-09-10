export PATH_CONFIG__=$HOME/.bash_config

#general
if [ -f $PATH_CONFIG__/general ]; then
    source $PATH_CONFIG__/general
fi

#ficheros de alias
if [ -f $PATH_CONFIG__/alias ]; then
    source $PATH_CONFIG__/alias
fi

#ficheros de alias para ssh (usuarios y hostnames
if [ -f $PATH_CONFIG__/alias_ssh ]; then
     source $PATH_CONFIG__/alias__ssh
fi

#funciones personales
if [ -f $PATH_CONFIG__/functions ]; then
    source $PATH_CONFIG__/functions
fi

#Cargamos el fichero de configuracion de la maquina actual en caso de existir
if [ -f $PATH_CONFIG__/$HOSTNAME ]; then
    source $PATH_CONFIG__/$HOSTNAME
fi


unset -v PATH_CONFIG__
