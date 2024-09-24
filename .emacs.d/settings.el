;; blank scratch
(setq inhibit-startup-screen t)
(setq initial-scratch-message "")

;; neotree
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(setq neo-show-hidden-files t)
(neotree-show)

;; setup powerline theme
(require 'powerline)
(powerline-default-theme)
(setq powerline-arrow-shape 'curve)
(set-face-attribute 'mode-line nil :foreground "#FFFFFF" :background "#0B4677" :box nil)
(set-face-attribute 'mode-line-inactive nil :foreground "#AAAAAA" :background "#0B2A4E" :box nil)
(set-face-attribute 'powerline-active0 nil :foreground "#FFFFFF" :background "#0B4677" :box nil)
(set-face-attribute 'powerline-active1 nil :foreground "#FFFFFF" :background "#113354" :box nil)
(set-face-attribute 'powerline-active2 nil :foreground "#FFFFFF" :background "#112234" :box nil)
(set-face-attribute 'powerline-inactive0 nil :foreground "#FFFFFF" :background "#0B2A4E" :box nil)
(set-face-attribute 'powerline-inactive1 nil :foreground "#FFFFFF" :background "#0d213a" :box nil)
(set-face-attribute 'powerline-inactive2 nil :foreground "#FFFFFF" :background "#0e1a28" :box nil)
