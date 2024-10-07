;; blank scratch
(setq inhibit-startup-screen t)
(setq initial-scratch-message "")

;; backups
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; no bell
(setq ring-bell-function 'ignore)

;; default window size
(if (window-system) (set-frame-size (selected-frame) 180 40))

;; scrolling
(require 'smooth-scrolling)
(smooth-scrolling-mode 1)
(setq smooth-scroll-margin 5)

;; neotree
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(setq neo-show-hidden-files t)
(neotree-show)
(other-window 1)

;; line numbers
(require 'right-linum)
(add-hook 'prog-mode-hook 'right-linum-mode)
(add-hook 'conf-mode-hook 'right-linum-mode)

;; powerline theme
(require 'powerline)
(powerline-default-theme)
(set-face-attribute 'mode-line nil :foreground "#FFFFFF" :background "#0B4677" :box nil)
(set-face-attribute 'mode-line-inactive nil :foreground "#AAAAAA" :background "#0B2A4E" :box nil)
(set-face-attribute 'powerline-active0 nil :foreground "#FFFFFF" :background "#0B4677" :box nil)
(set-face-attribute 'powerline-active1 nil :foreground "#FFFFFF" :background "#113354" :box nil)
(set-face-attribute 'powerline-active2 nil :foreground "#FFFFFF" :background "#112234" :box nil)
(set-face-attribute 'powerline-inactive0 nil :foreground "#FFFFFF" :background "#0B2A4E" :box nil)
(set-face-attribute 'powerline-inactive1 nil :foreground "#FFFFFF" :background "#0d213a" :box nil)
(set-face-attribute 'powerline-inactive2 nil :foreground "#FFFFFF" :background "#0e1a28" :box nil)

;; treesitter
(use-package treesit-auto
  :config
  (global-treesit-auto-mode))

