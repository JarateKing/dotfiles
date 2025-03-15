;;; post-init.el --- Custom Init -*- no-byte-compile: t; lexical-binding: t; -*-

;; themes
(mapc #'disable-theme custom-enabled-themes)
(load-theme 'custom t)
