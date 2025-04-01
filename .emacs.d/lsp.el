;; loaded from `post-init.el`
;; requires the environment variable `EMACS_LSP` to be defined

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
(use-package lsp-ltex
  :ensure t
  :hook (text-mode . (lambda () (require 'lsp-ltex) (lsp)))
  :init (setq lsp-ltex-version "15.2.0"))
(use-package flycheck
  :ensure t)
(use-package helm-lsp
  :ensure t)
(use-package helm
  :ensure t
  :config (helm-mode))
