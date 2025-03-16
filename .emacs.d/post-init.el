;;; post-init.el --- Custom Init -*- no-byte-compile: t; lexical-binding: t; -*-

;; additional package load paths
(add-to-list 'load-path "~/.emacs.d/packages/")
(add-to-list 'load-path "~/.emacs.d/personal/")

;; theme
(mapc #'disable-theme custom-enabled-themes)
(load-theme 'custom t)

;; window
(if (window-system) (set-frame-size (selected-frame) 180 40)) ; default window size
(setq-default frame-title-format '("%b %f"))                  ; simplify window title
(set-fringe-mode 0)                                           ; remove padding

;; line numbers
(require 'right-linum)
(add-hook 'prog-mode-hook 'right-linum-mode)
(add-hook 'conf-mode-hook 'right-linum-mode)
(add-hook 'markdown-mode-hook 'right-linum-mode)


