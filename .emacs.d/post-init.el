;;; post-init.el --- Custom Init -*- no-byte-compile: t; lexical-binding: t; -*-

;; additional package load paths
(add-to-list 'load-path "~/.emacs.d/packages/")
(add-to-list 'load-path "~/.emacs.d/personal/")

;; theme
(mapc #'disable-theme custom-enabled-themes)
(load-theme 'custom t)
(use-package all-the-icons
  :ensure t)

;; keybinds
(cua-mode t)
(setq cua-keep-region-after-copy t)
(bind-key* "C-s" 'contextual-save)
(bind-key* "C-f" 'isearch-forward)
(bind-key* "C-y" 'undo-redo)
(bind-key* "C-a" 'mark-whole-buffer)
(bind-key* "C-<tab>" 'usage-cycle)
(bind-key* "C-t" 'eat)
(bind-key* "C-n" 'yas-insert-snippet)
(bind-key* "C-d" 'org-create-and-open-drawing)
(bind-key* "C-S-d" 'org-edit-drawing)

(defun contextual-save ()
  "Save depending on mode"
  (interactive)
  (if (derived-mode-p 'chunk-edit-mode)
      (chunk-edit-save-all-chunks)
      (save-buffer)))

(defun contextual-kill ()
  "Kill buffer depending on context"
  (interactive)
  (if (derived-mode-p 'chunk-edit-mode)
      (chunk-edit-quit)
      (kill-buffer)))

;; window
(if (window-system) (set-frame-size (selected-frame) 180 40)) ; default window size
(setq-default frame-title-format '("%b %f"))                  ; simplify window title
(set-fringe-mode 0)                                           ; remove padding

;; cursor
(defun contextual-cursor ()
  "Set cursor based on minor mode context"
  (cond
   (buffer-read-only
    (setq cursor-type 'hbar))
   (overwrite-mode
    (setq cursor-type 'hollow))
   (t
    (setq cursor-type 'bar))))
(add-hook 'post-command-hook 'contextual-cursor)

(global-hl-line-mode 1)

;; modes
(use-package markdown-mode
  :ensure t)
(use-package rainbow-mode
  :ensure t)

;; mode-specific settings
(add-hook 'LaTeX-mode-hook (lambda () (local-unset-key "\"")))

;; word wrap
(add-hook 'markdown-mode-hook 'visual-line-mode)
(add-hook 'latex-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'help-mode-hook 'visual-line-mode)

;; dired
(use-package all-the-icons-dired
  :ensure t
  :hook (dired-mode . (lambda () (all-the-icons-dired-mode) (dired-hide-details-mode))))

;; magit
(use-package magit
  :ensure t)

;; line numbers
(require 'right-linum)
(add-hook 'prog-mode-hook 'right-linum-mode)
(add-hook 'conf-mode-hook 'right-linum-mode)
(add-hook 'markdown-mode-hook 'right-linum-mode)

;; minimap
(if (window-system)
  (use-package demap
    :ensure t
    :config
    (add-hook 'buffer-face-mode-hook (lambda () (setq mode-line-format nil)))
    (setq demap-minimap-window-width 13)
    (demap-open)))

;; modeline
(use-package telephone-line
  :ensure t
  :config
  (setq telephone-line-lhs
	'((accent . (telephone-line-buffer-segment))
      (nil . (telephone-line-major-mode-segment))
      (nil . (telephone-line-minor-mode-segment))))
  (setq telephone-line-rhs
	'((nil . (telephone-line-filesize-segment))
	  (accent . (telephone-line-airline-position-segment))))
  (telephone-line-mode t))

;; neotree
(if (window-system)
  (use-package neotree
    :ensure t
    :config
    (add-hook 'neo-after-create-hook (lambda (&optional dummy) (setq mode-line-format nil)))
    (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
    (setq neo-show-hidden-files t)
    (neotree-show)
    (other-window 1)))

;; scrolling
(use-package smooth-scrolling
  :ensure t
  :config
  (smooth-scrolling-mode 1)
  (setq smooth-scroll-margin 5))

;; whitespace
(setq-default whitespace-style '(face spaces empty tabs newline trailing space-mark tab-mark newline-mark))
(setq-default whitespace-display-mappings '(
  (space-mark 32 [183] [46])            ;; space -> · else .
  (newline-mark ?\n [92 ?\n])           ;; new line -> \
  (newline-mark ?\r [92])               ;; carriage return -> \
  (tab-mark ?\t [9474 ?\t] [124 ?\t]))) ;; tabs -> │ else |

;; delimiters
(use-package rainbow-delimiters
  :ensure t)

;; usage cycle
(require 'usage-cycle)

;; tex
(use-package auctex
  :ensure t)
(setq TeX-parse-self t) ;; parse on load
(setq TeX-auto-save t) ;; parse on save

;; org
(add-hook 'org-mode-hook 'org-display-inline-images)
(org-babel-do-load-languages
 'org-babel-load-languages '((shell . t) (python . t)))
(setq org-support-shift-select t)
(setq org-confirm-babel-evaluate nil)
(use-package org-modern
  :ensure t
  :hook (org-mode . org-modern-mode)
  :custom
  (org-modern-fold-stars '(("▶" . "▼")))
  (org-modern-checkbox
   '((?X . "■")
    (?- . "◪")
    (?\s . "□"))))
;; https://www.reddit.com/r/emacs/comments/1la0ztn/whiteboard_workflow_for_orgmode_using_inkscape/
(add-to-list 'org-file-apps '("\\.svg\\'" . "inkscape %s"))
(defun org-create-and-open-drawing ()
  "Insert a timestamped SVG drawing link, create the file, and open in inkscape."
  (interactive)
  (let* ((dir "drawings/")
         (filename (concat "sketch-" (format-time-string "%Y%m%d-%H%M%S") ".svg"))
         (fullpath (expand-file-name filename dir)))
    ;; Ensure drawings dir exists
    (unless (file-directory-p dir)
      (make-directory dir))
    ;; Create minimal SVG if it doesn't exist
    (unless (file-exists-p fullpath)
      (with-temp-file fullpath
        (insert "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>\n"
                "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" width=\"1024\" height=\"768\">\n"
                "</svg>")))
    ;; Insert link in org buffer
    (insert (format "[[file:%s]]\n" fullpath))
    (org-display-inline-images)
    ;; Open in Inkscape
    (start-process "inkscape" nil "inkscape" fullpath)))
(defun org-edit-drawing ()
  "Modify an existing drawing in inkscape."
  (interactive)
  (org-open-at-point)
  (org-redisplay-inline-images))

;; snippets
(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

;; terminal emulator
(use-package hide-mode-line
  :ensure t)
(use-package eat
  :ensure t
  :hook
  ((eshell-load-hook . eat-eshell-mode)
   (eshell-load-hook . eat-eshell-visual-command-mode)
   (eat-mode . hide-mode-line-mode))
  :custom
  (eat-term-name "xterm-256color")
  :config
  (setq eat-kill-buffer-on-exit t)
  (add-to-list 'display-buffer-alist
               '("\*eat\*"
               (display-buffer-in-side-window)
               (window-height . 0.25)     ; window % size of frame
               (side . bottom)
               (slot . 0))))

;; multiple files in one buffer
(use-package chunk-edit
  :vc (:url "https://github.com/vkazanov/chunk-edit.git"
       :rev :newest))
(defun multifile-buffer ()
  "Opens a buffer with multiple files based on chunk-edit"
  (interactive)
  (let ((pop-up-windows nil))
    (chunk-edit)))

;; environment-based optional configuration
(if (getenv "EMACS_LSP") (load "~/.emacs.d/optional/lsp"))
(if (getenv "EMACS_LLM") (load "~/.emacs.d/optional/llm"))
