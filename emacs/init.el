;;==============================================================================
;; Fichero inicial de configuración de emacs. Carga todas las configuraciones
;;  en función de la forma en la que ha sido lanzado (por ejemplo si están las X
;;  activas o no)
;;==============================================================================


;;
;; General config variables
;;

;; Directorio con los ficheros de configuración
(setq emacs-config-dir (expand-file-name "~/data/tmp/emacs/"))


;;
;; Las siguientes configuración es independiente del modo en el que se ha lanzado
;;

;; General
(load-file (concat emacs-config-dir  "/general"))
;; Configuraciones para la shell
(load-file (concat emacs-config-dir  "/shell"))
;; Configuraciones de los distintos modos válidos para todas las situaciones
(load-file (concat emacs-config-dir  "/modes_config"))


;; Segun si estamos en terminal o gui, cargamos el fichero correspondiente
(if (display-graphic-p)
    (load-file (concat emacs-config-dir "/gui_config"))
  (load-file (concat emacs-config-dit "/terminal_config"))
  )
	       


