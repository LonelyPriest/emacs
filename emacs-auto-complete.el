
;;auto-complete
(add-to-list 'load-path "/usr/local/share/emacs/24.3/site-lisp/auto-complete-1.3.1")

(require 'auto-complete-config)
(require 'auto-complete)
(require 'fuzzy)
(require 'popup)

;; After do this, isearch any string, M-: (match-data) always
;; return the list whose elements is integer
(global-auto-complete-mode 1)


(provide 'emacs-auto-complete)
