(use-package lsp-mode
  :ensure t
  :hook ((lsp-mode . lsp-enable-which-key-integration))
  :config (setq lsp-completion-enable-additional-text-edit nil))
(use-package lsp-ui
  :commands lsp-ui-mode
  :ensure t)
(use-package ccls
  :ensure t
  :config
  (setq ccls-executable "ccls")
  (setq lsp-prefer-flymake nil)
  (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
  :hook ((c-mode c++-mode objc-mode) .
         (lambda () (require 'ccls) (lsp))))
(use-package lsp-pyright
  :ensure t
  :custom (lsp-pyright-langserver-command "pyright")
  :hook (python-mode . (lambda () (require 'lsp-pyright) (lsp))))
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
(use-package lsp-treemacs
  :ensure t)
(use-package company
  :ensure t)
(use-package which-key
  :ensure t)
(use-package dap-mode
  :ensure t)
