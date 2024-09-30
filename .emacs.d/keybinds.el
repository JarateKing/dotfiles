(require 'bind-key)

;; some common keybinds
(bind-key* "C-v" 'yank)
(bind-key* "C-s" 'save-buffer)
(bind-key* "C-f" 'isearch-forward)
