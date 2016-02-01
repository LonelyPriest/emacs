;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; dir 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'dired)
(require 'dired-x)

(when (require 'mwheel nil 'noerror)
  (mouse-wheel-mode t))

(add-to-list 'load-path "/usr/local/share/emacs/24.3/site-lisp/dir-mode")
(require 'files+)
(require 'ls-lisp+)
(require 'mouse3)
(require 'dired-aux)
(require 'dired+)
(require 'dired-filetype-face)
(require 'dired-view)

(add-hook 'dired-mode-hook 'dired-view-minor-mode-on)
(define-key dired-mode-map (kbd ";") 'dired-view-minor-mode-toggle)
(define-key dired-mode-map (kbd ":") 'dired-view-minor-mode-dired-toggle)

;; omit uninteresting files
(add-hook 'dired-mode-hook
          (lambda ()
            (setq dired-omit-files "^#\\|^\\..*") ; omit all hidden file which starts with `.'
            (dired-omit-mode 1)))                 ; initially omit unintrested files

;; recursive copy or delete directory using dired
(setq dired-recursive-copies 'top)
(setq dired-recursive-deletes 'top)

(require 'dired-single)
(add-hook 'dired-load-hook
          (lambda ()
            (define-key dired-mode-map (kbd "RET") 'dired-single-buffer)
            (define-key dired-mode-map (kbd "<mouse-1>") 'dired-single-buffer-mouse)
            (define-key dired-mode-map (kbd "^")
              (lambda ()
                (interactive)
                (dired-single-buffer "..")))
            (setq dired-use-magic-buffer t)
            (setq dired-magic-buffer-name "*dired*")))


(global-set-key (kbd "C-x d") 'dired-single-magic-buffer)
(global-set-key (kbd "C-x C-d") (function
      	(lambda nil (interactive)
              (dired-single-magic-buffer default-directory))))
(global-set-key [(shift f5)] (function
	        (lambda nil (interactive)
              (message "Current directory is: %s" default-directory))))
(global-set-key (kbd "C-x t") 'dired-single-toggle-buffer-name)


(require 'dired-details+)

(provide 'emacs-dired)


