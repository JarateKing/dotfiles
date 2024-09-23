;; window style
(setq-default frame-title-format '("%b %f"))    ; simplify window title
(set-fringe-mode 0)                             ; remove padding on sides
(scroll-bar-mode -1)                            ; remove scrollbars
(menu-bar-mode -1)                              ; remove dropdown menus
(tool-bar-mode -1)                              ; remove toolbar ribbon

;; theme
(add-to-list 'default-frame-alist '(foreground-color . "#D3E8F3"))
(add-to-list 'default-frame-alist '(background-color . "#0B1118"))
(add-to-list 'initial-frame-alist '(internal-border-width . 8))
(add-to-list 'initial-frame-alist '(top-visible . 100))
(set-face-foreground 'vertical-border "#000000")

;; cursor
(add-to-list 'default-frame-alist '(cursor-color . "#55BCDA"))
(setq-default cursor-type 'bar)

;; line highlighting
(global-hl-line-mode 1)
(set-face-background 'hl-line "#1b2128")
(set-face-foreground 'highlight 'nil)

