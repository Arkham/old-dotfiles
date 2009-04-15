;; Remove splash screen
(setq inhibit-splash-screen t)

;; Theme
(require 'color-theme)
(color-theme-ld-dark)

;; Scrollbar on the right
(setq scroll-bar-mode-explicit t)
(set-scroll-bar-mode `right) 

;; Global syntax highlighting
(global-font-lock-mode 1)

;; Configure TABs
(setq-default indent-tabs-mode nil)
(setq default-tab-width 4)
(setq c-basic-offset 4)
(c-set-offset 'substatement-open 0)
(setq show-trailing-whitespace t)
(setq indicate-empty-lines t)

;; Fix colored shell
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Global syntax highlighting
(global-font-lock-mode 1)

;; Cscope configuration
(load-file "/usr/share/emacs/site-lisp/xcscope.el")
(require 'xcscope)

;; AUCTeX configuration
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

;; Split windows vertically
;;(defun th-display-buffer (buffer force-other-window)
;;  "If BUFFER is visible, select it.
;;
;;   If it's not visible and there's only one window, split the
;;   current window and select BUFFER in the new window. If the
;;   current window (before the split) is more than 120 columns wide, 
;;   split horizontally, else split vertically.
;;
;;   If the current buffer contains more than one window, select
;;   BUFFER in the least recently used window.
;;
;;   This function returns the window which holds BUFFER.
;;   FORCE-OTHER-WINDOW is ignored."
;;  (or (get-buffer-window buffer)
;;      (if (one-window-p)
;;          (let ((new-win (if (> (window-width) 120)
;;                             (split-window-horizontally)
;;                           (split-window-vertically))))
;;            (set-window-buffer new-win buffer)
;;            new-win)
;;        (let ((new-win (get-lru-window)))
;;          (set-window-buffer new-win buffer)
;;          new-win))))
;;
;;(setq display-buffer-function 'th-display-buffer)

;; load the d-abbrev lib
(require 'dabbrev)

;; custom-set-variables was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
(custom-set-variables
 '(column-number-mode t)
 '(hippie-expand-try-functions-list (quote (try-expand-dabbrev try-expand-list  try-expand-line try-expand-dabbrev-all-buffers try-complete-file-name-partially try-complete-file-name)))
 '(inhibit-startup-screen t)
 '(paren-highlight-offscreen t)
 '(paren-message-linefeed-display "^J")
 '(show-paren-mode t)
 )

;; Some nice keybindings
;; autocompletion on Alt-Enter
(global-set-key [M-return] 'hippie-expand)
;; start, stop and run macros
(global-set-key [f5] 'kmacro-end-and-call-macro)
(global-set-key [f6] 'start-kbd-macro)
(global-set-key [f7] 'end-kbd-macro)
;; compile
(global-set-key [f9] 'compile)
;; scroll the compile output
(setq compilation-scroll-output t)
;; change all yes/no questions to y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; highlight TODO, FIXME,XXX, and  DONE in code
;; 
(defface my-fixme-face
  '((t :background "red" :foreground "white" :weight bold))
  "Font for showing FIXME and XXX words."
  :group 'basic-faces)

(defface my-todo-face
  '((t :background "red" :foreground "black" :weight bold))
  "Font for showing TODO words."
  :group 'basic-faces)

(defface my-done-face
  '((t :background "green" :foreground "white" :weight bold))
  "Font for showing DONE words."
  :group 'basic-faces)

(add-hook 'font-lock-mode-hook 
    (function 
        (lambda ()
	    (unless (or (eq 'diff-mode major-mode) (eq 'script-mode major-mode))
	        (font-lock-add-keywords nil	
		    '(("\\<\\(TODO:?\\)\\>" 1 'my-todo-face t)	
		     ("\\<\\(DONE:?\\)\\>" 1 'my-done-face t)	
		     ("\\<\\(FIXME:?\\|XXX\\)\\>" 1 'my-fixme-face t))
	        )
	    )
        )
    )
) 

;; Flyspell for LaTeX
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(autoload 'flyspell-delay-command "flyspell" "Delay on command." t)
(autoload 'tex-mode-flyspell-verify "flyspell" "" t)
(setq-default ispell-program-name "aspell")
(setq-default ispell-extra-args '("--mode=tex"))

;; Emacs sessions
;;(desktop-load-default)
;;(desktop-read)
(desktop-save-mode 1)
(require 'dirvars)