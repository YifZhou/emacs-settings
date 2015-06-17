;;;; switch between window
(windmove-default-keybindings 'super)
(global-set-key (kbd "C-x o") 'switch-window)
(global-set-key (kbd "<s-C-268632074>") 'windmove-left)
(global-set-key (kbd "<s-C-268632075>") 'windmove-down)
(global-set-key (kbd "<s-C-268632073>") 'windmove-up)
(global-set-key (kbd "<s-C-268632076>") 'windmove-right)
(provide 'switch-window-setting)
