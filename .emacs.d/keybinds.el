;; some common keybinds
(keymap-global-set "C-v" 'yank)
(keymap-global-set "C-s" 'save-buffer)
(keymap-global-set "C-f" 'isearch-forward)

;; IJKL navigation
(keymap-global-set "C-i" 'previous-line)
(keymap-global-set "C-k" 'next-line)
(keymap-global-set "C-j" 'left-char)
(keymap-global-set "C-l" 'right-char)
