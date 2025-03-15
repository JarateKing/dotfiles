(deftheme custom
  "Personal custom theme"
  :background-mode 'dark
  :kind 'color-scheme)

(let ((class '((class color) (min-colors 89))))
  (custom-theme-set-faces
   'custom
   `(default ((,class (:background "#0b1118" :foreground "#f6f3e8"))))
   `(cursor ((,class (:background "#656565"))))
   `(fringe ((,class ())))))


(provide-theme 'custom)
