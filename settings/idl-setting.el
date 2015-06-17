;;;; IDLWAVE

(add-hook 'idlwave-mode-hook
          (lambda ()
            (auto-complete-mode t)
            (setq idlwave-expand-generic-end t)
            (setq idlwave-reserved-word-upcase t)))

(provide 'idl-setting)
