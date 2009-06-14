;;
;; ~/.emacs
;;
 
;; Remove splash screen
(setq inhibit-splash-screen t)
 
;; Theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-ld-dark)
 
;; Scrollbar on the right
(setq scroll-bar-mode-explicit t)
(set-scroll-bar-mode `right)
 
;; Emacs sessions
(desktop-load-default)
(desktop-read)
 
;; Fix colored shell
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
 
;; Global syntax highlighting
;; (global-font-lock-mode 1)
 
;; AUCTeX configuration
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

;; compile
(global-set-key [f9] 'compile)
;; scroll the compile output
(setq compilation-scroll-output t)
;; change all yes/no questions to y/n
(fset 'yes-or-no-p 'y-or-n-p)
