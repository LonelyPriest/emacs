;; js-mode
(define-mode-local-override semantic-get-local-variables
   js-mode ()  ;; use the correct mode name
   "Ignore requests for local variable declarations from the current context."
   nil)

(provide 'emacs-js)
