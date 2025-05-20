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

(bind-key* "C-o c" 'gptel) ; chat window
(bind-key* "C-o i" 'gptel-send) ; insert from prompt
(bind-key* "C-o r" 'gptel-rewrite) ; rewrite selection with prompt
