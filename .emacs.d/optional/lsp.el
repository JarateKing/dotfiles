;; loaded from `post-init.el`
;; requires the environment variable `EMACS_LSP` to be defined

(use-package eglot
  :ensure t
  :defer t
  :hook ((c++-mode . eglot-ensure)
         (c-mode . eglot-ensure)
         (python-mode . eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
  (add-to-list 'eglot-server-programs '(python-mode . ("pyright-langserver" "--stdio")))
  (setopt eglot-ignored-server-capabilities (list :documentOnTypeFormattingProvider)))

(use-package eglot-booster
  :vc (:url "https://github.com/jdtsmith/eglot-booster.git" :rev :newest) 
  :after eglot
  :config (eglot-booster-mode))

(use-package company
  :ensure t
  :hook (eglot-managed-mode . company-mode)
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0)
  (company-tooltip-align-annotations t)
  (company-tooltip-minimum-width 70)
  (company-tooltip-maximum-width 70))
