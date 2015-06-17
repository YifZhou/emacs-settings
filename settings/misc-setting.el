;;;; misc-setting
(setq ns-pop-up-frame nil)
;; no tabs
(setq-default tab-width 4 indent-tabs-mode nil)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq-default cursor-type 't)
;;;; stop emacs to make sound
(setq ring-bell-function 'ignore)
(column-number-mode t)
;;;OSX should using pbpaste and pbcopy to share clipboard
;;;Cut and Past configuration
(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))
(when (string= system-type "darwin")
  (setq interprogram-cut-function 'paste-to-osx)
  (setq interprogram-paste-function 'copy-from-osx))

;;;; system path
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "PYTHONPATH")
  (exec-path-from-shell-copy-env "TINYTIM"))

(defadvice linum-update-window (around linum-dynamic activate)
  (let* ((w (length (number-to-string
                     (count-lines (point-min) (point-max)))))
         (linum-format (concat " %" (number-to-string w) "d ")))
    ad-do-it))

;;;; electric pair
(electric-pair-mode t)
(show-paren-mode 1)
(setq show-paren-delay 0)
(provide 'misc-setting)
