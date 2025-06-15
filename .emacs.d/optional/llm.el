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

(defun llm-info-with-prompt (start end prompt)
  "Use an LLM to describe something based on a prompt"
  (interactive "r")
  (message "running LLM prompt...")
  (let ((input
    (if (region-active-p)
      (buffer-substring-no-properties (region-beginning) (region-end))
      (thing-at-point 'word))))
    (gptel-request nil
        :callback (lambda (response info)
          (with-output-to-temp-buffer "*LLM*"
            (print response)))
        :system prompt
        :context input)))

(defun llm-explain-region (start end)
  "Use an LLM to describe the current region."
  (interactive "r")
  (llm-info-with-prompt start end "Please give a short description of this word, phrase, or code snippet. Try to give some example usages and related words/phrases/functions/etc."))

(defun llm-translate-to-english (start end)
  "Use an LLM to translate the current region to English."
  (interactive "r")
  (llm-info-with-prompt start end "Please translate the following word or phrase into English. Then explain some of the word choice and potential other translations, and explain some cultural nuances that might be unclear from just the direct translation."))

(defun llm-synonyms (start end)
  "Use an LLM as a thesaurus."
  (interactive "r")
  (llm-info-with-prompt start end "List several synonyms and antonyms for:"))

(bind-key* "C-o c" 'gptel) ; chat window
(bind-key* "C-o i" 'gptel-send) ; insert from prompt
(bind-key* "C-o r" 'gptel-rewrite) ; rewrite selection with prompt
(bind-key* "C-o q" 'gptel-abort) ; quit llm usage
(bind-key* "C-o e" 'llm-explain-region) ; explain region
(bind-key* "C-o t" 'llm-translate-to-english) ; translate region to english
(bind-key* "C-o s" 'llm-synonyms) ; get synonyms and antonyms
