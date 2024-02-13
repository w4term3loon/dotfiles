;; ----- SCROLL ----- ;;
(setq scroll-conservatively 101)
;; ----- SCROLL ----- ;;

(setq make-backup-files nil) ; stop creating ~ files

;; ----- MARKDOWN ----- ;;
(require 'package)
(add-to-list 'package-archives
    '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)
;; ----- MARKDOWN ----- ;;

;; ----- HELM MODE ----- ;;
;;(require 'helm-config)
;;(helm-mode -1)
;; ----- HELM MODE ----- ;;

(add-hook 'prog-mode-hook #'ws-butler-global-mode)
(setq column-number-mode t)
(setq visible-bell 1)

;; ----- MULTIPLE CURSORS ----- ;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless (package-installed-p 'multiple-cursors)
  (package-refresh-contents)
  (package-install 'multiple-cursors))

(global-set-key (kbd "M-C-<down>") 'mc/mark-next-like-this)
(global-set-key (kbd "M-C-<up>") 'mc/mark-previous-like-this)
(global-set-key (kbd "M-C-<backspace>") 'mc/keyboard-quit)
;; ----- MULTIPLE CURSORS ----- ;;

;; ----- MENU DISPLAY ----- ;;
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
;; ----- MENU DISPLAY ----- ;;

;; ----- LINE NUMBERS ----- ;;
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)
(setq global-auto-revert-mode t)
;; ----- LINE NUMBERS ----- ;;

;; ----- EMACS SPECIALS ----- ;;
(setq save-place-mode t)
(setq comint-scroll-show-maximum-output nil)
(setq confirm-kill-emacs #'y-or-n-p)
(setq dired-dwim-target t)
(global-auto-revert-mode t)
;; ----- EMACS SPECIALS ----- ;;

;; ----- ELECTRIC PAIRS ----- ;;
;; Define the electric pairs
(setq electric-pair-pairs '((?\" . ?\")   ; double quotes
                            (?\' . ?\')   ; single quotes
                            (?\` . ?\`))) ; backticks
(electric-pair-mode)
;; ----- ELECTRIC PAIRS ----- ;;

;; ----- VTERM ----- ;;
;; Initialize package.el
;;(require 'package)
;;(package-initialize)

;; Add package archives
;;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)

;; Install use-package if not already installed
;;(unless (package-installed-p 'use-package)
;;  (package-refresh-contents)
;;  (package-install 'use-package))

;; Enable use-package
;;(eval-when-compile
;;  (require 'use-package))
;;(require 'bind-key)
;;(setq use-package-always-ensure t)

;; Install and configure vterm
;;(use-package vterm
;;  :ensure t)

;;(add-to-list 'load-path "~/emacs/emacs-libvterm")
;;(require 'vterm)
;; ----- VTERM ----- ;;

;; ----- TAB SETTINGS ----- ;;
;; Use spaces for indentation
(setq-default indent-tabs-mode nil)
;(setq indent-line-function 'insert-tab)
(setq-default tab-width 4)
(setq c-basic-offset 4)
;; ----- TAB SETTINGS ----- ;;

;; ----- KEY BINDINGS ----- ;;
(global-set-key (kbd "C-c o") 'other-window)
;;(global-set-key (kbd "s-<down>") 'end-of-buffer)
;;(global-set-key (kbd "s-<up>") 'beginning-of-buffer)
;;(global-set-key (kbd "ó") 'delete-char)
(global-set-key (kbd "TAB") 'tab-to-tab-stop)
(global-set-key (kbd "M-q") 'text-scale-decrease)
(global-set-key (kbd "M-w") 'text-scale-increase)

(global-unset-key "\C-z")
(global-set-key "\C-z" 'undo)

(global-set-key (kbd "M-g") 'gdb)
(global-set-key (kbd "C-c c") 'kill-ring-save)
(global-set-key (kbd "C-c v") 'yank)
(global-set-key (kbd "C-c x") 'kill-region)

;;(global-set-key (kbd "M-,") (lambda () (interactive) (insert "*")))
;;(global-set-key (kbd "M-y") (lambda () (interactive) (insert "<")))
;;(global-set-key (kbd "M-c") (lambda () (interactive) (insert ">")))
;;(global-set-key (kbd "M-í") (lambda () (interactive) (insert "|")))
;;(global-set-key (kbd "M-1") (lambda () (interactive) (insert "&")))
;;(global-set-key (kbd "M-.") (lambda () (interactive) (insert ";")))
;;(global-set-key (kbd "M-3") (lambda () (interactive) (insert "#")))
;;(global-set-key (kbd "M-n") (lambda () (interactive) (insert "~")))
;;(global-set-key (kbd "M-6") (lambda () (interactive) (insert "\\")))

;;(global-set-key (kbd "M-ö") (lambda () (interactive) (insert "()")(backward-char)))
;;(global-set-key (kbd "M-ü") (lambda () (interactive) (insert "{}")(backward-char)))
;;(global-set-key (kbd "M-ó") (lambda () (interactive) (insert "[]")(backward-char)))

(global-set-key (kbd "M-<down>") (lambda () (interactive) (forward-line 5)))
(global-set-key (kbd "M-<up>") (lambda () (interactive) (previous-line 5)))
(global-set-key (kbd "C-c C-a") 'auto-complete-mode)
;; ----- KEY BINDINGS ----- ;;

;; ----- THEME SPECIFICS ----- ;;
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(set-face-attribute 'default nil :height 162)
(set-frame-parameter (selected-frame) 'alpha '(96 97))
;; ----- THEME SPECIFICS ----- ;;

;; ----- THEME INCLUDE ----- ;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("b1a691bb67bd8bd85b76998caf2386c9a7b2ac98a116534071364ed6489b695d" "f366d4bc6d14dcac2963d45df51956b2409a15b770ec2f6d730e73ce0ca5c8a7" default)))
 '(package-selected-packages
   (quote
    (company gitstatus logview lua-mode auto-complete markdown-mode git magit ws-butler helm memory-usage subatomic-theme spacemacs-theme gruvbox-theme zenburn-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-delimiter-face ((t (:foreground "#616488")))))
;; ----- THEME INCLUDE ----- ;;

;; ----- LOAD THEME ----- ;;
(load-theme 'subatomic t)
;; ----- LOAD THEME ----- ;;


;; ----- CUSTOM COLORS ----- ;;
;; Customise cursor color
(set-cursor-color "#FAE15F")

;; Customise number line not focus color
(set-face-attribute 'line-number nil :foreground "#858599")

;; Customise number line focus color
(set-face-attribute 'line-number-current-line nil :foreground "#FAE15F")

;; Customise number line not foucus weight
(set-face-attribute 'line-number nil :weight 'normal)

;; Customise number line focus weight
(set-face-attribute 'line-number-current-line nil :weight 'normal)

;; Customise variable name color
(set-face-attribute 'font-lock-variable-name-face nil :foreground "white")

;; Customise function name color
(set-face-attribute 'font-lock-function-name-face nil :foreground "white")

;; Customise preprocessor color
(set-face-attribute 'font-lock-preprocessor-face nil :foreground "#8F6287")

;; Customise mode line
(set-face-attribute 'mode-line nil :box '(:line-width 5 :color "#262732"))

;; Customise foreground
;(set-face-attribute 'default nil :foreground "white")

;; Customise strings
;(set-face-attribute 'font-lock-string-face nil :foreground "#7eb45a")

;; Customize keyword face
(set-face-attribute 'font-lock-keyword-face nil :foreground "#FAE15F")

;; Customize comment face
;(set-face-attribute 'font-lock-comment-face nil :foreground "#b68545")

;; Customise type face
(set-face-attribute 'font-lock-type-face nil :foreground "#B9B9C5" :bold nil)

;; Customise dired mode folders
;(set-face-attribute 'dired-directory nil :foreground "white")
;; ----- CUSTOM COLORS ----- ;;
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
