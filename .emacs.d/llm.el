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

(defun llm-explain-region (start end)
  "Use an LLM to describe the current region."
  (interactive "r")
  (unless (region-active-p)
    (error "you must have a region set"))
  (message "running LLM prompt...")
  (let ((input (buffer-substring-no-properties (region-beginning) (region-end))))
    (gptel-request nil
      :callback (lambda (response info)
        (with-output-to-temp-buffer "*LLM*"
          (print response)))
      :system "Please give a short description of this word, phrase, or code snippet. Try to give some example usages and related words/phrases/functions/etc."
      :context input)))

(defun llm-translate-to-english (start end)
  "Use an LLM to translate the current region to English."
  (interactive "r")
  (unless (region-active-p)
    (error "you must have a region set"))
  (message "running LLM prompt...")
  (let ((input (buffer-substring-no-properties (region-beginning) (region-end))))
    (gptel-request nil
      :callback (lambda (response info)
        (with-output-to-temp-buffer "*LLM*"
          (print response)))
      :system "Please translate the following word or phrase into English. Then explain some of the word choice and potential other translations, and explain some cultural nuances that might be unclear from just the direct translation."
      :context input)))

(bind-key* "C-o c" 'gptel) ; chat window
(bind-key* "C-o i" 'gptel-send) ; insert from prompt
(bind-key* "C-o r" 'gptel-rewrite) ; rewrite selection with prompt
(bind-key* "C-o q" 'gptel-abort) ; quit llm usage
(bind-key* "C-o e" 'llm-explain-region) ; explain region
(bind-key* "C-o t" 'llm-translate-to-english) ; translate region to english
