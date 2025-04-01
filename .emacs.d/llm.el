;; loaded from `post-init.el`
;; requires the environment variable `EMACS_LLM` to be defined

(use-package gptel
  :ensure t
  :config
  (setq
   gptel-model 'mistral
   gptel-backend (gptel-make-ollama "Ollama"
                 :host "localhost:11434"
                 :stream t
                 :models '(mistral))))
