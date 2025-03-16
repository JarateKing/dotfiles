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
   `(region ((,class (:background "#123040"))))
   `(mode-line ((,class (:background "#0B4677" :foreground "#FFFFFF"))))
   `(mode-line-inactive ((,class (:background "#0B2A4E" :foreground "#AAAAAA"))))))

(provide-theme 'custom)

