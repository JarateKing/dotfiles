;; packages
(require 'package)
(package-initialize)
(setq custom-file "~/.emacs.d/custom.el")

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(defvar packages-to-install
	'(all-the-icons neotree powerline markdown-mode magit)
	"Packages to install via package manager")

(defvar package-contents-refreshed nil)
(dolist (p packages-to-install)
	(when (not (package-installed-p p))
		(unless package-contents-refreshed
			(defvar package-contents-refreshed t)
			(package-refresh-contents))
		(package-install p)))

;; additional packages
(add-to-list 'load-path "~/.emacs.d/packages/")
(add-to-list 'load-path "~/.emacs.d/personal/")

(defvar package-subdirectories
	'("emacs-powerline")
	"Directories for additional packages outside of the package manager")
	
(dolist (p package-subdirectories)
	(add-to-list 'load-path (concat "~/.emacs.d/packages/" p "/")))

(load "~/.emacs.d/settings.el")
(load "~/.emacs.d/theme.el")
(load custom-file)
