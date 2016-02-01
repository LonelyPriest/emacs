(add-to-list 'load-path "/usr/local/share/emacs/24.3/site-lisp/ecb-2.40")

(require 'ecb)

;; deactive when ECB start, colse the tips of day
(setq ecb-auto-activate nil 
      ecb-tip-of-the-day nil)

(setq stack-trace-on-error nil)

(provide 'emacs-ecb)
