;;; post-init.el --- Custom Init -*- no-byte-compile: t; lexical-binding: t; -*-

;; theme
(mapc #'disable-theme custom-enabled-themes)
(load-theme 'custom t)
(add-to-list 'default-frame-alist '(font . "JetBrains Mono-10"))

;; window
(if (window-system) (set-frame-size (selected-frame) 180 40)) ; default window size
(setq-default frame-title-format '("%b %f"))                  ; simplify window title
(set-fringe-mode 0)                                           ; remove padding
