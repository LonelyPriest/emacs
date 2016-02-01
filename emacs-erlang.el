;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Erlang
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "/usr/local/share/emacs/24.3/site-lisp/erlang-2.6.6")
(add-to-list 'load-path "/usr/local/share/emacs/24.3/site-lisp/distel-master/elisp")
;;(add-to-list 'load-path "/usr/local/share/emacs/24.3/site-lisp/flymake")

(require 'erlang-start)

(add-to-list 'auto-mode-alist '("\\.erl$" . erlang-mode))
(add-to-list 'auto-mode-alist '("\\.hrl$" . erlang-mode))
;;(add-to-list 'auto-mode-alist '("\\.yaw$" . erlang-mode))

(setq erlang-root-dir "/usr/lib/erlang")
(add-to-list 'exec-path "/usr/lib/erlang/bin")
(setq erlang-man-root-dir "/usr/lib/erlang/man")

(defun my-erlang-mode-hook ()
        ;; when starting an Erlang shell in Emacs, default in the node name
        ;; (setq inferior-erlang-machine-options '("-sname" "bxh"))
        (setq inferior-erlang-machine-options '("-sname" "'controller-knife@iZ94ef98hr7Z'"))
        ;; add Erlang functions to an imenu menu
        (imenu-add-to-menubar "imenu")
        ;; customize keys
        (local-set-key [return] 'newline-and-indent)
        (defvar inferior-erlang-prompt-timeout t)
        )

;; Some Erlang customizations
(add-hook 'erlang-mode-hook 'my-erlang-mode-hook)

(require 'distel)
(distel-setup)


;; A number of the erlang-extended-mode key bindings are useful in the shell too
(defconst distel-shell-keys
  '(("\C-\M-i"   erl-complete)
    ("\M-?"      erl-complete)
    ("\M-."      erl-find-source-under-point)
    ("\M-,"      erl-find-source-unwind)
    ("\M-*"      erl-find-source-unwind)
    )
  "Additional keys to bind when in Erlang shell.")

(add-hook 'erlang-shell-mode-hook
           (lambda ()
              ;; add some Distel bindings to the Erlang shell
              (dolist (spec distel-shell-keys)
              (define-key erlang-shell-mode-map (car spec) (cadr spec)))))

;; prevent annoying hang-on-compile

;; tell distel to default to that node
(setq erl-nodename-cache
      (make-symbol
       (concat
        "bxh@"
        ;; Mac OS X uses "name.local" instead of "name", this should work
        ;; pretty much anywhere without having to muck with NetInfo
        ;; ... but I only tested it on Mac OS X.
        (car (split-string (shell-command-to-string "hostname"))))))

(require 'erlang-flymake)

(provide 'emacs-erlang)



