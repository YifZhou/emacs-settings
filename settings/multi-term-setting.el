;;;; multi-term
;;(require 'multi-term)
(setq multi-term-program "/usr/local/bin/zsh")
(add-hook 'term-mode-hook
          (lambda ()
            (yas-minor-mode -1)
            (add-to-list 'term-bind-key-alist '("M-["
                                                . multi-term-prev))
            (add-to-list 'term-bind-key-alist '("M-]"
            . multi-term-next))
            (define-key term-raw-map (kbd "C-c C-j")
              'term-line-mode)))

(global-set-key (kbd "s-T") 'multi-term)
(global-set-key (kbd "C-c z") 'multi-term-next)
(provide 'multi-term-setting)
