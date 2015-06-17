;;;; Latex-mode
(add-hook 'LaTeX-mode-hook
	  (lambda ()
        (setq TeX-auto-save t)
        (setq TeX-parse-self t)
        (setq visual-line-mode t)
        (setq TeX-source-correlate-method 'synctex)
        (setq TeX-source-correlate-method-active t)
        (variable-pitch-mode t)
	    (flyspell-mode t)
	    (auto-fill-mode t)
	    (LaTeX-math-mode t)
	    (reftex-mode t)
        (cdlatex-mode t)
        (setq TeX-auto-untabify t     ; remove all tabs before saving
		  TeX-engine 'xetex       ; use xelatex default
		  TeX-show-compilation nil) ; don't display compilation windows
	    (TeX-global-PDF-mode t)       ; PDF mode enable, not plain
	    (setq TeX-save-query nil)
	    (setq TeX-electric-sub-and-superscript t)
	    (imenu-add-menubar-index)
	    (setq-default TeX-master nil)
	    (define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)
	    (define-key LaTeX-mode-map (kbd "RET") 'newline-and-indent)
	    ))

(defun turn-on-outline-minor-mode ()
  (outline-minor-mode 1))
(add-hook 'LaTeX-mode-hook
          'turn-on-outline-minor-mode)
(setq outline-minor-mode-prefix "\C-c \C-o") ; Or something else

(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list '(("PDF Viewer"
      "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g
      %n %o %b")))

(add-hook 'LaTeX-mode-hook (lambda () (push '("latexmk" "latexmk -pdf
  -xelatex -synctex=1 %s" TeX-run-TeX nil t :help "Run latexmk on
  file") TeX-command-list)))

(add-hook 'TeX-mode-hook '(lambda ()
  (setq TeX-command-default "latexmk")))

(provide 'latex-setting)
