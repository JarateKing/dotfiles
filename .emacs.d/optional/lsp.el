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
  (add-to-list 'eglot-server-programs '(python-mode . ("pyright-langserver" "--stdio"))))
