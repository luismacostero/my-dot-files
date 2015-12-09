;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;; Una mezcla de varios sitios, principalmente:
;;
;;    Mio propio
;;    http://www.emacswiki.org/emacs/VictorPeinado
;;    http://dahoiv.net/.emacs
;;    http://snarfed.org 
;;     http://emacs-fu.blogspot.com.es/2009/01/counting-words.html ((cuenta num palabras)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


;; --- Modos iniciales y por defecto ---

;; No quiero barra de scroll
(scroll-bar-mode -1)

;; Ni barra de herramientas
(tool-bar-mode -1)

;; Ni barra de menu
(menu-bar-mode -1)

;; La tecla 'Supr' borra la parte seleccionada
(pending-delete-mode 1)

;; Evita añadir líneas en blanco al final del fichero...
(setq next-line-add-newlines nil)

;; ... aunque todos los archivos terminan con línea en blanco
(setq require-final-newline t)

;; La barra del título muestra el nombre del buffer actual 
(setq frame-title-format '("emacs: %*%+ %b"))

;; No muestres los mensajes de inicio, ya los conozco
(setq inhibit-startup-message t)

;; No muestres claves en el buffer
(add-hook 'comint-mode-hook
          (lambda ()
            (add-to-list 'comint-output-filter-functions
                         'comint-watch-for-password-prompt)))

;; Usa y/n en lugar de yes/no 
(fset 'yes-or-no-p 'y-or-n-p)

;; Mis ficheros elisp están en 
(setq my-lisp-directory (expand-file-name "~/.emacs-lisp/"))

;; Carga el directorio de los ficheros elisp
(add-to-list 'load-path my-lisp-directory)

(setq load-path (cons "~/.emacs-lisp/" load-path))


;; No crees ficheros temporales xxx~
(setq make-backup-files nil)    

;; Remarca la zona seleccionada
(transient-mark-mode +1)

;; Tamanyo del frame original
(add-to-list 'default-frame-alist '(height . 50))
(add-to-list 'default-frame-alist '(width . 150))

;; ancho de columna automatico a 75 char
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook
  '(lambda() (set-fill-column 75)))

;; Muestra el número de línea y de columna
(global-linum-mode t)
(column-number-mode 't)

;; Apaga el beep molesto
(setq ring-bell-function 'ignore)

;; muestra los parentesis emparejados
(show-paren-mode t)

;; F7: arranca la shell con el modo eshell
(global-set-key [f7] ' shell) 

;; marca la linea actual (solo si estamos en un entorno gráfico
(set-face-background 'highlight "#555753")

(if (display-graphic-p)
  (global-hl-line-mode 1)
)

;; La rueda del raton solamente desplaza una linea
;;(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
;;(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
;(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
;(setq scroll-step 1) ;; keyboard scroll one line at a time

;;copy-paste para X-clientes
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;;colores oscuros por defecto
(setq default-frame-alist
      (append
       '((background-color     ."#2E3436")
	 (foreground-color     ."white")
	) default-frame-alist))




;;Web-mode
(require 'web-mode)
;; Para asociar extensiones al modo
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))

;; Tabular para html css y javascript
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)

;;En CSS, si se define un color se colorea de ese color.
(setq web-mode-enable-css-colorization t)

;;En html, empareja cada etiqueta con su cierre
(setq web-mode-enable-current-element-highlight t)

;;;;MAUDE-Mode
(require 'maude-mode)
(add-to-list 'auto-mode-alist '("\\.maude\\'" . maude-mode))


;;C-c h (o shift-Mouse2 para contraer xml regions)
;;-------- 
(require 'hideshow)
(require 'sgml-mode)
(require 'nxml-mode)
(add-to-list 'hs-special-modes-alist
             '(nxml-mode
               "<!--\\|<[^/>]*[^/]>"
               "-->\\|</[^/>]*[^/]>"

               "<!--"
               sgml-skip-tag-forward
               nil))
(add-hook 'nxml-mode-hook 'hs-minor-mode)
;; optional key bindings, easier than hs defaults
;; Por defecto, tmb funciona shift+Mouse-2 (rueda raton).
(define-key nxml-mode-map (kbd "C-c h") 'hs-toggle-hiding)

;;--------


;;C-tab para desplazar entre buffers
(global-set-key [\C-tab]                  'yic-next-buffer)
(global-set-key [\C-S-iso-lefttab]     'yic-prev-buffer)


;; ----------------------------------------------------------------------
;;     Original yic-buffer.el
;;     From: choo@cs.yale.edu (young-il choo)
;;     Date: 7 Aug 90 23:39:19 GMT
;;
;;     Modified 
;; ----------------------------------------------------------------------

(defun yic-ignore (str)
  (or
   ;;buffers I don't want to switch to 
   (string-match "\\*Buffer List\\*" str)
   (string-match "^TAGS" str)
   (string-match "^\\*Messages\\*$" str)
   (string-match "^\\*Completions\\*$" str)
   (string-match "^ " str)

   ;;Test to see if the windw is visible on an existing visible frame.
   ;;Because I can always ALT-TAB to that visible frame, I never want to 
   ;;Ctrl-TAB to that buffer in the current frame.  That would cause 
   ;;a duplicate top-level buffer inside two frames.
   (memq str                
         (mapcar 
          (lambda (x) 
            (buffer-name 
             (window-buffer 
              (frame-selected-window x))))
          (visible-frame-list)))
   ))

(defun yic-next (ls)
  "Switch to next buffer in ls skipping unwanted ones."
  (let* ((ptr ls)
         bf bn go
         )
    (while (and ptr (null go))
      (setq bf (car ptr)  bn (buffer-name bf))
      (if (null (yic-ignore bn))        ;skip over
   (setq go bf)
        (setq ptr (cdr ptr))
        )
      )
    (if go
        (switch-to-buffer go))))

(defun yic-prev-buffer ()
  "Switch to previous buffer in current window."
  (interactive)
  (yic-next (reverse (buffer-list))))

(defun yic-next-buffer ()
  "Switch to the other buffer (2nd in list-buffer) in current window."
  (interactive)
  (bury-buffer (current-buffer))
  (yic-next (buffer-list)))
;;end of yic buffer-switching methods

;(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
; '(safe-local-variable-values (quote ((TeX-master . "master")))))


;------------------------------------------------------------
; Mejoras para la shell  --  http://snarfed.org  --
;------------------------------------------------------------

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(comint-completion-addsuffix t)
 '(comint-completion-autolist t)
 '(comint-input-ignoredups t)
 '(comint-scroll-show-maximum-output t)
 '(comint-scroll-to-bottom-on-input t)
 '(comint-scroll-to-bottom-on-output t))

; interpret and use ansi color codes in shell output windows
(ansi-color-for-comint-mode-on)

; make completion buffers disappear after 3 seconds.
;(add-hook 'completion-setup-hook
;  (lambda () (run-at-time 5 nil
;    (lambda () (delete-windows-on "*Completions*")))))

;; run a few shells.
;(shell "*shell5*")


; C-5 para cambiar a la shell en caso de existir
(global-set-key [(control \5)]
  (lambda () (interactive) (switch-to-buffer "*shell*")))


; cuenta el numero de palabras
;-------------------------------------------
(defun count-words (&optional begin end)
  "count words between BEGIN and END (region); if no region defined, count words in buffer"
  (interactive "r")
  (let ((b (if mark-active begin (point-min)))
      (e (if mark-active end (point-max))))
    (message "Word count: %s" (how-many "\\w+" b e))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(set-default-font "Inconsolata 12")
(put 'dired-find-alternate-file 'disabled nil)

;; pdf zoom
;;--------------------
(global-set-key [C-mouse-wheel-up-event]  'text-scale-increase)
(global-set-key  [C-mouse-wheel-down-event] 'text-scale-decrease)
