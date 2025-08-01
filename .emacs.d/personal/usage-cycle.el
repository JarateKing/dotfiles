(put 'usage-cycle-state 'state 0)

(defun usage-cycle ()
	"Cycles between different usages"
	(interactive)
	(put 'usage-cycle-state 'state (% (+ (get 'usage-cycle-state 'state) 1) 2))
	(pcase (get 'usage-cycle-state 'state)
		(0 (progn
			(rainbow-delimiters-mode 0)
			(whitespace-mode 0)
            (rainbow-mode 0))
            (if (eq major-mode 'org-mode) (org-modern-mode 1)))
		(1 (progn
			(rainbow-delimiters-mode 1)
			(whitespace-mode 1)
            (rainbow-mode 1)
            (if (eq major-mode 'org-mode) (org-modern-mode 0))))))

(provide 'usage-cycle)
