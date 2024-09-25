;;; right-linum.el --- Display line numbers to the right of buffers

;; Copyright (C) 2007, 2008  Markus Triska

;; Author: Markus Triska <markus.triska@gmx.at>
;; Keywords: convenience

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; Display line numbers for the current buffer. Copy right-linum.el to your
;; load-path and add to your .emacs:

;;    (require 'right-linum)

;; Then toggle display of line numbers with M-x right-linum-mode. To enable
;; line numbering in all buffers, use M-x global-right-linum-mode. Forked
;; from the traditional linum.el.

;; Modified by: JarateKing

;;; Code:

(defconst right-linum-version "0.9wza")

(defvar right-linum-overlays nil "Overlays used in this buffer.")
(defvar right-linum-available nil "Overlays available for reuse.")
(defvar right-linum-before-numbering-hook nil
  "Functions run in each buffer before line numbering starts.")

(mapc #'make-variable-buffer-local '(right-linum-overlays right-linum-available))

(defgroup right-linum nil
  "Show line numbers to the right of buffers"
  :group 'convenience)

;;;###autoload
(defcustom right-linum-format 'dynamic
  "Format used to display line numbers. Either a format string
like \"%7d\", 'dynamic to adapt the width as needed, or a
function that is called with a line number as its argument and
should evaluate to a string to be shown on that line. See also
`right-linum-before-numbering-hook'."
  :group 'right-linum
  :type 'sexp)

(defface right-linum
  '((t :inherit (shadow default)))
  "Face for displaying line numbers in the display margin."
  :group 'right-linum)

(defcustom right-linum-eager t
  "Whether line numbers should be updated after each command.
The conservative setting `nil' might miss some buffer changes,
and you have to scroll or press C-l to update the numbers."
  :group 'right-linum
  :type 'boolean)

(defcustom right-linum-delay nil
  "Delay updates to give Emacs a chance for other changes."
  :group 'right-linum
  :type 'boolean)

;;;###autoload
(define-minor-mode right-linum-mode
  "Toggle display of line numbers in the right marginal area."
  :lighter ""                           ; for desktop.el
  (if right-linum-mode
      (progn
        (if right-linum-eager
            (add-hook 'post-command-hook (if right-linum-delay
                                             'right-linum-schedule
                                           'right-linum-update-current) nil t)
          (add-hook 'after-change-functions 'right-linum-after-change nil t))
        (add-hook 'window-scroll-functions 'right-linum-after-scroll nil t)
        ;; mistake in Emacs: window-size-change-functions cannot be local
        (add-hook 'window-size-change-functions 'right-linum-after-size)
        (add-hook 'change-major-mode-hook 'right-linum-delete-overlays nil t)
        (add-hook 'window-configuration-change-hook
                  'right-linum-after-config nil t)
        (right-linum-update-current))
    (remove-hook 'post-command-hook 'right-linum-update-current t)
    (remove-hook 'post-command-hook 'right-linum-schedule t)
    (remove-hook 'window-size-change-functions 'right-linum-after-size)
    (remove-hook 'window-scroll-functions 'right-linum-after-scroll t)
    (remove-hook 'after-change-functions 'right-linum-after-change t)
    (remove-hook 'window-configuration-change-hook 'right-linum-after-config t)
    (remove-hook 'change-major-mode-hook 'right-linum-delete-overlays t)
    (right-linum-delete-overlays)))

;;;###autoload
(define-globalized-minor-mode global-right-linum-mode right-linum-mode right-linum-on)

(defun right-linum-on ()
  (unless (minibufferp)
    (right-linum-mode 1)))

(defun right-linum-delete-overlays ()
  "Delete all overlays displaying line numbers for this buffer."
  (mapc #'delete-overlay right-linum-overlays)
  (setq right-linum-overlays nil)
  (dolist (w (get-buffer-window-list (current-buffer) nil t))
    (set-window-margins 0 w)))

(defun right-linum-update-current ()
  "Update line numbers for the current buffer."
  (right-linum-update (current-buffer)))

(defun right-linum-update (buffer)
  "Update line numbers for all windows displaying BUFFER."
  (with-current-buffer buffer
    (when right-linum-mode
      (setq right-linum-available right-linum-overlays)
      (setq right-linum-overlays nil)
      (save-excursion
        (mapc #'right-linum-update-window
              (get-buffer-window-list buffer nil 'visible)))
      (mapc #'delete-overlay right-linum-available)
      (setq right-linum-available nil))))

(defun right-linum-update-window (win)
  "Update line numbers for the portion visible in window WIN."
  (goto-char (window-start win))
  (let ((line (line-number-at-pos))
        (limit (window-end win t))
        (fmt (cond ((stringp right-linum-format) right-linum-format)
                   ((eq right-linum-format 'dynamic)
                    (let ((w (length (number-to-string
                                      (count-lines (point-min) (point-max))))))
                      (concat "%" (number-to-string w) "d")))))
        (width 0))
    (run-hooks 'right-linum-before-numbering-hook)
    ;; Create an overlay (or reuse an existing one) for each
    ;; line visible in this window, if necessary.
    (while (and (not (eobp)) (<= (point) limit))
      (let* ((str (if fmt
                      (propertize (format fmt line) 'face 'right-linum)
                    (funcall right-linum-format line)))
             (visited (catch 'visited
                        (dolist (o (overlays-in (point) (point)))
                          (when (string= (overlay-get o 'right-linum-str) str)
                            (unless (memq o right-linum-overlays)
                              (push o right-linum-overlays))
                            (setq right-linum-available (delete o right-linum-available))
                            (throw 'visited t))))))
        (setq width (max width (length str)))
        (unless visited
          (let ((ov (if (null right-linum-available)
                        (make-overlay (point) (point))
                      (move-overlay (pop right-linum-available) (point) (point)))))
            (push ov right-linum-overlays)
            (overlay-put ov 'before-string
                         (propertize " " 'display `((margin right-margin) ,str)))
            (overlay-put ov 'right-linum-str str))))
      (forward-line)
      (setq line (1+ line)))
    (set-window-margins win 0 width)))

(defun right-linum-after-change (beg end len)
  ;; update overlays on deletions, and after newlines are inserted
  (when (or (= beg end)
            (= end (point-max))
            ;; TODO: use string-match-p with CVS or new release
            (string-match "\n" (buffer-substring-no-properties beg end)))
    (right-linum-update-current)))

(defun right-linum-after-scroll (win start)
  (right-linum-update (window-buffer win)))

(defun right-linum-after-size (frame)
  (right-linum-after-config))

(defun right-linum-schedule ()
  ;; schedule an update; the delay gives Emacs a chance for display changes
  (run-with-idle-timer 0 nil #'right-linum-update-current))

(defun right-linum-after-config ()
  (walk-windows (lambda (w) (right-linum-update (window-buffer w))) nil 'visible))

(provide 'right-linum)

