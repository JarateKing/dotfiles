(deftheme custom
  "Personal custom theme"
  :background-mode 'dark
  :kind 'color-scheme)

(let ((class '((class color) (min-colors 89))))
  (custom-theme-set-faces
   'custom
   `(default ((,class (:background "#0b1118" :foreground "#d3e8f3" :font "JetBrains Mono-10"))))
   `(cursor ((,class (:background "#55BCDA"))))
   `(fringe ((,class ())))
   `(vertical-border ((,class (:foreground "#0b1118"))))
   `(region ((,class (:background "#123040"))))
   `(mode-line ((,class (:background "#0B4677" :foreground "#ffffff" :box nil))))
   `(mode-line-inactive ((,class (:background "#0b2a4e" :foreground "#aaaaaa" :box nil))))
   `(whitespace-newline                ((t (:foreground, "#1e2a38"))))
   `(whitespace-missing-newline-at-eof ((t (:foreground, "#1e2a38"))))
   `(whitespace-space                  ((t (:foreground, "#1e2a38"))))
   `(whitespace-space-after-tab        ((t (:foreground, "#1e2a38"))))
   `(whitespace-space-before-tab       ((t (:foreground, "#1e2a38"))))
   `(whitespace-tab                    ((t (:foreground, "#1e2a38"))))
   `(whitespace-trailing               ((t (:foreground, "#1e2a38"))))
   `(whitespace-empty                  ((t (:foreground, "#1e2a38"))))
   `(powerline-active0 ((,class (:background "#0b4677" :foreground "#ffffff"))))
   `(powerline-active1 ((,class (:background "#113354" :foreground "#ffffff"))))
   `(powerline-active2 ((,class (:background "#112234" :foreground "#ffffff"))))
   `(powerline-inactive0 ((,class (:background "#0b2a4e" :foreground "#aaaaaa"))))
   `(powerline-inactive1 ((,class (:background "#0d213a" :foreground "#aaaaaa"))))
   `(powerline-inactive2 ((,class (:background "#0e1a28" :foreground "#aaaaaa"))))
   `(demap-minimap-font-face ((,class (:background "#0b1118" :family "minimap" :height 10))))
   `(demap-visible-region-face ((,class (:background "#0e1a28"))))
   `(demap-visible-region-inactive-face ((,class (:background "#0e1a28"))))
   `(demap-current-line-face ((,class (:background "#0e1a28"))))
   `(demap-current-line-inactive-face ((,class (:background "#0e1a28"))))))

(provide-theme 'custom)

