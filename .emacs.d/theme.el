;; window style
(setq-default frame-title-format '("%b %f"))    ; simplify window title
(set-fringe-mode 0)                             ; remove padding on sides
(scroll-bar-mode -1)                            ; remove scrollbars
(menu-bar-mode -1)                              ; remove dropdown menus
(tool-bar-mode -1)                              ; remove toolbar ribbon

;; font
(add-to-list 'default-frame-alist '(font . "JetBrains Mono-10"))

;; theme
(add-to-list 'default-frame-alist '(foreground-color . "#D3E8F3"))
(add-to-list 'default-frame-alist '(background-color . "#0B1118"))
(add-to-list 'initial-frame-alist '(internal-border-width . 8))
(add-to-list 'initial-frame-alist '(top-visible . 100))
(set-face-foreground 'vertical-border "#000000")
(set-face-attribute 'region nil :background "#123040")

;; whitespace-mode
(setq-default whitespace-style '(face spaces empty tabs newline trailing space-mark tab-mark newline-mark))
(custom-set-faces
  `(whitespace-newline                ((t (:foreground, "#1e2a38"))))
  `(whitespace-missing-newline-at-eof ((t (:foreground, "#1e2a38"))))
  `(whitespace-space                  ((t (:foreground, "#1e2a38"))))
  `(whitespace-space-after-tab        ((t (:foreground, "#1e2a38"))))
  `(whitespace-space-before-tab       ((t (:foreground, "#1e2a38"))))
  `(whitespace-tab                    ((t (:foreground, "#1e2a38"))))
  `(whitespace-trailing               ((t (:foreground, "#1e2a38"))))
  `(whitespace-empty                  ((t (:foreground, "#1e2a38")))))

;; cursor
(add-to-list 'default-frame-alist '(cursor-color . "#55BCDA"))
(setq-default cursor-type 'bar)

;; line highlighting
(global-hl-line-mode 1)
(set-face-background 'hl-line "#0e1a28")
(set-face-foreground 'highlight 'nil)

