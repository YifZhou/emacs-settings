;;;;This is Yifan's emacs configuration file
;;;;each setion starts with a name with four semicolon

;;;Load-Path Configuration
(add-to-list 'load-path "~/.emacs.d/settings/")
(add-to-list 'load-path "~/.emacs.d/plugins/")
(add-to-list 'load-path "~/.emacs.d/plugins/color-theme-6.6.0/")


;;;; emacs server
(require 'server)
(or (server-running-p)
    (server-start))

;;;; package.el
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(require 'el-get-setting)

;;;; misc-setting
(require 'misc-setting)
(require 'switch-window-setting)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;;;ido mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode t)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :foundry "apple" :family "Monaco"))))
 '(flymake-errline ((t (:background "#042028" :foreground "#c60007" :inverse-video nil :underline nil :slant normal :weight normal))))
 '(flymake-warnline ((t (:foreground "dark orange")))))

(setq default-frame-alist '((width . 96) (height . 32)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-includegraphics-extensions (quote ("eps" "jpe?g" "pdf" "png" "ps")))
 '(LaTeX-includegraphics-read-file (quote LaTeX-includegraphics-read-file-relative))
 '(TeX-brace-indent-level 2)
 '(TeX-check-path (quote (".")))
 '(TeX-newline-function (quote newline-and-indent))
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#ad7fa8" "#8cc4ff" "#eeeeec"])
 '(inhibit-startup-screen t)
 '(ispell-highlight-face (quote flyspell-incorrect))
 '(markdown-command
   "pandoc -f markdown -t html -s --mathjax --highlight-style espresso")
 '(send-mail-function (quote smtpmail-send-it))
 '(speedbar-default-position (quote left))
 '(speedbar-frame-parameters
   (quote
    ((minibuffer)
     (width . 30)
     (border-width . 0)
     (menu-bar-lines . 0)
     (tool-bar-lines . 0)
     (unsplittable . t)
     (left-fringe . 0))))
 '(sr-speedbar-right-side nil)
 '(sr-speedbar-width-x 30))

(global-set-key (kbd "<s-C-268632070>") 'toggle-frame-fullscreen)

;;;;Color Theme Configuration
(add-to-list 'custom-theme-load-path
"~/.emacs.d/plugins/color-theme-6.6.0/themes/emacs-color-theme-solarized-master/")
(add-to-list 'load-path
"~/.emacs.d/plugins/color-theme-6.6.0/themes/emacs-color-theme-solarized-master/")
(require 'color-theme)
;;(require 'color-theme-solarized)
;;(load-theme 'solarized-light t)
;; (setq solarized-termcolors 256)
;;(load-theme 'solarized-dark t)
;;(load-theme 'wombat t)
(load-theme 'monokai t)
;;(load-theme 'spacegray t)
;;(global-hl-line-mode 1)
;; ;(setq solarized-broken-srgb t)

(require 'latex-setting)
(require 'gnuplot-setting)
;;;; Highlight-Indentation-Mode
(require 'highlight-indentation)

(require 'markdown-setting)
(require 'idl-setting)
;;;; speedbar
(require 'sr-speedbar)
(global-set-key (kbd "C-c s") 'sr-speedbar-toggle)

(require 'multi-term-setting)
;;;; fly-spell
(eval-after-load "flyspell"
    '(progn
       (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
       (define-key flyspell-mouse-map [mouse-3] #'undefined)))

;;;; grammar check
(setq
langtool-language-tool-jar "~/LanguageTool-2.9/languagetool-commandline.jar")
(setq langtool-mother-tongue "en") ;; sadly my mother tongue is not english
(global-set-key (kbd "C-c C-g c") 'langtool-check)
(global-set-key (kbd "C-c C-g s") 'langtool-show-message-at-point)
(global-set-key (kbd "C-c C-g d") 'langtool-check-done)
(global-set-key (kbd "C-c C-g n") 'langtool-goto-next-error)
(global-set-key (kbd "C-c C-g p") 'langtool-goto-previous-error)

;;;; wrap region
(add-to-list 'load-path "~/.emacs.d/elpa/wrap-region")
(require 'wrap-region)

;;;; tramnp
(setq tramp-verbose 10)
(setq tramp-debug-buffer t)
(setq tramp-default-method "ssh")

;;;; magit
(global-set-key (kbd "s-g") 'magit-status)

(require 'pandora-setting)
(require 'auto-complete-setting)
;;;; yasnippet
(yas-global-mode t)
;;;; fill column indicator
;; (define-globalized-minor-mode
;;  global-fci-mode fci-mode (lambda () (fci-mode 1)))
;; (global-fci-mode t)
(setq-default fci-rule-column 80)
(require 'python-setting)

(put 'upcase-region 'disabled nil)
