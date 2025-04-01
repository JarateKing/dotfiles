(use-package gptel
  :ensure t
  :config
  (setq
   gptel-model 'mistral
   gptel-backend (gptel-make-ollama "Ollama"
                 :host "localhost:11434"
                 :stream t
                 :models '(mistral))))
