;;;; GNUplot
(require 'gnuplot-mode)
(setq gnuplot-program "/usr/local/bin/gnuplot")
(setq auto-mode-alist
      (append '(("\\.\\(gp\\|plt\\)$" . gnuplot-mode))
              auto-mode-alist))
(provide 'gnuplot-setting)
