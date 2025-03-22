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
(bind-key* "C-s" 'save-buffer)
(bind-key* "C-f" 'isearch-forward)
(bind-key* "C-y" 'undo-redo)
(bind-key* "C-<tab>" 'usage-cycle)

;; window
(if (window-system) (set-frame-size (selected-frame) 180 40)) ; default window size
(setq-default frame-title-format '("%b %f"))                  ; simplify window title
(set-fringe-mode 0)                                           ; remove padding

;; cursor
(defun contextual-cursor ()
  "Set cursor basd on minor mode context"
  (cond
   (buffer-read-only
    (setq cursor-type 'hbar))
   (overwrite-mode
    (setq cursor-type 'hollow))
   (t
    (setq cursor-type 'bar))))
(add-hook 'post-command-hook 'contextual-cursor)

;; modes
(use-package markdown-mode
  :ensure t)
(use-package rainbow-mode
  :ensure t)

;; word wrap
(add-hook 'markdown-mode-hook 'visual-line-mode)

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

;; powerline
(use-package powerline
  :ensure t
  :config
  (powerline-default-theme))

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

;; LSP
(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-keymap-prefix "C-l")
  :hook
  ((python-mode . lsp) (lsp-mode . lsp-enable-which-key-integration))
  ((c++-mode . lsp) (lsp-mode . lsp-enable-which-key-integration))
  ((c-mode . lsp) (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp
  :config
  (setq lsp-headerline-breadcrumb-enable nil))
(use-package company
  :ensure t
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))
(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode))
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/dev")
    (setq projectile-project-search-path '("~/dev")))
  (setq projectile-switch-project-action #'projectile-dired))
(use-package counsel-projectile
  :config (counsel-projectile-mode))
(use-package ccls
  :ensure t
  :config
  (setq ccls-executable "ccls")
  (setq lsp-prefer-flymake nil)
  (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
  :hook ((c-mode c++-mode objc-mode) .
         (lambda () (require 'ccls) (lsp))))
