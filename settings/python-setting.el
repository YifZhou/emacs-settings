;;;; Pymacs
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

;;;; python-mode
(require 'python)

(setq
 python-shell-interpreter "ipython"
 python-shell-interpreter-args "--matplotlib=osx --colors=Linux"
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 python-shell-completion-setup-code
   "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code
   "';'.join(module_completion('''%s'''))\n"
 python-shell-completion-string-code
   "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "pycheckers" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))

(add-hook 'flymake-mode-hook (flymake-cursor-mode t))

(setq fci-rule-width 2)
(setq fci-rule-color "#93a1a1")
(setq fci-rule-use-dashes t)

(add-hook 'python-mode-hook
	  (lambda ()
	    (unless (eq buffer-file-name nil) (flymake-mode 1))
        (auto-complete-mode t)
        (linum-mode t)
        (fci-mode t)
        (highlight-indentation-mode t)
        (highlight-indentation-current-column-mode t)))

; hack to fix ac-sources after pycomplete.el breaks it
(add-hook 'python-mode-hook
          '(lambda ()
             (setq ac-sources '(ac-source-ropemacs
                                ac-source-yasnippet
                                ac-source-abbrev
                                ac-source-dictionary
                                ac-source-words-in-same-mode-buffers))))

(add-hook 'python-mode-hook 'jedi:setup)
;;(add-to-list 'ac-sources 'ac-source-jedi-direct)
(setq jedi-config:use-system-python t)
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)

(setq jedi-config:use-system-python t)
;; ;; (setq jedi:get-in-function-call-delay 10000000)
(setq jedi:setup-keys t) 
(setq jedi:complete-on-dot t)

;;;; autopep8
(require 'py-autopep8)
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
(add-hook 'python-mode-hook
          (define-key python-mode-map (kbd "s-8") 'py-autopep8-buffer))

(provide 'python-setting)
