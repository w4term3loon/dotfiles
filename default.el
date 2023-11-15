(package-initialize)

(load "~/.emacs.d/rc.el")

;; ------ APPEARENCE ------ ;;
(defun get-default-font ()
  (cond
   ((eq system-type 'windows-nt) "Consolas-13")
   ((eq system-type 'gnu/linux) "Iosevka-20")))

(add-to-list 'default-frame-alist `(font . ,(get-default-font)))

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(show-paren-mode 1)

(rc/require-theme 'gruber-darker)

(eval-after-load 'zenburn
  (set-face-attribute 'line-number nil :inherit 'default))
;; ------ APPEARENCE ------ ;;

;; ------ IDO ------ ;;
(rc/require 'smex 'ido-completing-read+)
;; You can either press C-j to accept what you have typed so far, or C-f which will drop you into regular find-file
(require 'ido-completing-read+)

(ido-mode 1)
(ido-everywhere 1)
(ido-ubiquitous-mode 1)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
;; ------ IDO ------ ;;

;; ------ C-MODE ------ ;;
(setq-default c-basic-offset 4
              c-default-style '((java-mode . "java")
                                (awk-mode . "awk")
                                (other . "bsd")))

(add-hook 'c-mode-hook (lambda ()
                         (interactive)
                         (c-toggle-comment-style -1)))
;; ------ C-MODE ------ ;;

;; ------ PAREDIT ------ ;;
(rc/require 'paredit)

(defun rc/turn-on-paredit ()
  (interactive)
  (paredit-mode 1))

(add-hook 'emacs-lisp-mode-hook  'rc/turn-on-paredit)
(add-hook 'clojure-mode-hook     'rc/turn-on-paredit)
(add-hook 'lisp-mode-hook        'rc/turn-on-paredit)
(add-hook 'common-lisp-mode-hook 'rc/turn-on-paredit)
(add-hook 'scheme-mode-hook      'rc/turn-on-paredit)
(add-hook 'racket-mode-hook      'rc/turn-on-paredit)
;; ------ PAREDIT ------ ;;

;; ------ ELISP ------ ;;
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c C-j")
                            (quote eval-print-last-sexp))))
(add-to-list 'auto-mode-alist '("Cask" . emacs-lisp-mode))
;; ------ ELISP ------ ;;

;; ------ WHITESPACE ------ ;;
(defun rc/set-up-whitespace-handling ()
  (interactive)
  (whitespace-mode 0)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace))

(add-hook 'tuareg-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'c++-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'c-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'simpc-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'emacs-lisp-mode 'rc/set-up-whitespace-handling)
(add-hook 'java-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'lua-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'rust-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'scala-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'markdown-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'haskell-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'python-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'erlang-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'asm-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'nasm-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'go-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'nim-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'yaml-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'porth-mode-hook 'rc/set-up-whitespace-handling)
;; ------ WHITESPACE ------ ;;

;; ------ MAGIT ------ ;;
(rc/require 'cl-lib)
(rc/require 'magit)

(setq magit-auto-revert-mode nil)

(global-set-key (kbd "C-c m s") 'magit-status)
(global-set-key (kbd "C-c m l") 'magit-log)
;; ------ MAGIT ------ ;;

;; ------ MULTIPLE CURSORS ------ ;;
(rc/require 'multiple-cursors)

(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-;")         'mc/skip-to-previous-like-this)
(global-set-key (kbd "M-C-<down>")  'mc/mark-next-like-this)
(global-set-key (kbd "M-C-<up>")    'mc/mark-previous-like-this)
(global-set-key (kbd "M-C <left>") 'mc/mark-all-like-this)
(global-set-key (kbd "M-C-<backspace>") 'mc/keyboard-quit)
;; ------ MULTIPLE CURSORS ------ ;;

;; ----- SCROLL ----- ;;
(setq scroll-conservatively 101)
;; ----- SCROLL ----- ;;

;; ----- BACKUP ------ ;;
(setq make-backup-files nil)
;; ----- BACKUP ------ ;;

;; ----- LINE NUMBERS ----- ;;
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)
;; ----- LINE NUMBERS ----- ;;

;; ----- EMACS SPECIALS ----- ;;
(setq save-place-mode t)
(setq comint-scroll-show-maximum-output nil)
(setq confirm-kill-emacs #'y-or-n-p)
(setq dired-dwim-target t)
(setq global-auto-revert-mode t)
;; ----- EMACS SPECIALS ----- ;;

;; ----- DIRED ----- ;;
(require 'dired-x)
(setq dired-omit-files
      (concat dired-omit-files "\\|^\\..+$"))
(setq-default dired-dwim-target t)
(setq dired-listing-switches "-alh")
;; ----- DIRED ----- ;;

;; ----- ELECTRIC PAIRS ----- ;;
(setq electric-pair-pairs '((?\" . ?\")   ; double quotes
                            (?\' . ?\')   ; single quotes
                            (?\` . ?\`))) ; backticks
(electric-pair-mode)
;; ----- ELECTRIC PAIRS ----- ;;

;; ----- TAB SETTINGS ----- ;;
(setq-default indent-tabs-mode nil)
;(setq indent-line-function 'insert-tab)
(setq-default tab-width 4)
(setq c-basic-offset 4)
;; ----- TAB SETTINGS ----- ;;

;; ----- KEY BINDINGS ----- ;;
(global-set-key (kbd "C-c o") 'other-window)
(global-set-key (kbd "TAB") 'tab-to-tab-stop)
(global-set-key (kbd "M-q") 'text-scale-decrease)
(global-set-key (kbd "M-w") 'text-scale-increase)

(global-unset-key "\C-z")
(global-set-key "\C-z" 'undo)

(global-set-key (kbd "M-g") 'gdb)
(global-set-key (kbd "C-c c") 'kill-ring-save)
(global-set-key (kbd "C-c v") 'yank)
(global-set-key (kbd "C-c x") 'kill-region)

(global-set-key (kbd "M-<down>") (lambda () (interactive) (forward-line 5)))
(global-set-key (kbd "M-<up>") (lambda () (interactive) (previous-line 5)))
(global-set-key (kbd "C-c C-a") 'auto-complete-mode)
(global-set-key (kbd "C-c C-x") 'kill-emacs)
;; ----- KEY BINDINGS ----- ;;

;; ----- WINDOW SPECIFICS ----- ;;
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(set-face-attribute 'default nil :height 162)
;(set-frame-parameter (selected-frame) 'alpha '(96 97))
;; ----- WINDOW SPECIFICS ----- ;;

;; ------ GENERATED ------ ;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (gruber-darker-theme dash-functional ws-butler use-package subatomic-theme spinner multiple-cursors markdown-mode magit lv lua-mode jsonrpc ht gitstatus git flymake external-completion datetime company auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; ------ GENERATED ------ ;;
