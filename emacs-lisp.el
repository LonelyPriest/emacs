
(setq inferior-lisp-program "/usr/local/bin/sbcl") ; your Lisp system
(add-to-list 'load-path "/usr/share/emacs/24.3/site-lisp/slime-2013-04-05/slime/")  ; your SLIME directory

(require 'slime-autoloads)
(slime-setup)

(add-hook 'slime-mode-hook
          (lambda ()
            (unless (slime-connected-p)
              (save-excursion (slime)))))

(provide 'emacs-lisp)
