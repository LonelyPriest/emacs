;; use some smart tools to enhance editing abilities

(add-to-list 'load-path "/usr/local/share/emacs/24.3/site-lisp/smart-tools")

;; save all the file opened laste time
(require 'session)
(add-hook 'after-init-hook 'session-initialize)
(require 'desktop)
(desktop-save-mode)


;; 
(require 'ido)
(ido-mode t)
(setq ido-save-directory-list-file nil)

(require 'browse-kill-ring)
(global-set-key (kbd "C-c k") 'browse-kill-ring)
(global-set-key (kbd "C-c m") 'browse-kill-ring-quit)
(browse-kill-ring-default-keybindings)

;;
(require 'winring)
(winring-initialize)

;; Direct jump to scratch
(global-set-key (kbd "<f11>") (lambda () (interactive) (switch-to-buffer-other-window "*scratch*")))


;; Smart copy, if no region active, it simply copy the current whole line
;; M-w: copy current line
;; M-k: copy line from current position
(defadvice kill-line (before check-position activate)
  (if (member major-mode
              '(emacs-lisp-mode scheme-mode lisp-mode
                                c-mode c++-mode objc-mode js-mode
                                latex-mode plain-tex-mode))
      (if (and (eolp) (not (bolp)))
          (progn (forward-char 1)
                 (just-one-space 0)
                 (backward-char 1)))))
 
(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive (if mark-active (list (region-beginning) (region-end))
                 (message "Copied line")
                 (list (line-beginning-position)
                       (line-beginning-position 2)))))
 
(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))
 
;; Copy line from point to the end, exclude the line break
(defun qiang-copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (point)
                  (line-end-position))
                  ;; (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))
 
(global-set-key (kbd "M-k") 'qiang-copy-line)

;; Format when copy code
(dolist (command '(yank yank-pop))
  (eval
   `(defadvice ,command (after indent-region activate)
      (and (not current-prefix-arg)
           (member major-mode
                   '(emacs-lisp-mode
                     erlang-mode
                     lisp-mode
                     clojure-mode
                     scheme-mode
                     haskell-mode
                     ruby-mode
                     rspec-mode
                     python-mode
                     c-mode
                     c++-mode
                     objc-mode
                     latex-mode
                     js-mode
                     plain-tex-mode))
           (let ((mark-even-if-inactive transient-mark-mode))
             (indent-region (region-beginning) (region-end) nil))))))

;; Version Control
(setq version-control t
      kept-old-versions 2
      kept-new-versions 5
      delete-old-versions t
      backup-directory-alist
      '(("." . "~/.emacs.d")
        (cons tramp-file-name-regexp nil))
      backup-by-copying t
      backup-by-copying-when-linked t
      backup-by-copying-when-mismatch t)
(setq dired-kept-versions 1)


(defmacro after (mode &rest body)
  "`eval-after-load' MODE evaluate BODY."
  (declare (indent defun))
  `(eval-after-load ,mode
     '(progn ,@body)))

;; flymake
(add-to-list 'load-path "/usr/local/share/emacs/24.3/site-lisp/flymake")
;;(require 'flymake)

(after "flymake"
    (delete '("\\.html\\'" flymake-xml-init) flymake-allowed-file-name-masks)
    (delete '("\\.js\\'" flymake-javascript-init) flymake-allowed-file-name-masks)
    (delete '("\\.css\\'" flymake-css-init) flymake-allowed-file-name-masks)
    (delete '("\\.h\\'" flymake-master-make-header-init flymake-master-cleanup) 
                flymake-allowed-file-name-masks)
    (delete '("\\.\\(?:c\\(?:pp\\|xx\\|\\+\\+\\)?\\|CC\\)\\'" flymake-simple-make-init)
                flymake-allowed-file-name-masks)
    (set-face-background 'flymake-warnline "cyan")
    (set-face-foreground 'flymake-warnline "black")
    (set-face-background 'flymake-errline "orange red")
    (set-face-foreground 'flymake-errline "black")
    (defvar flymake-mode-map (make-sparse-keymap))
    (define-key flymake-mode-map (kbd "C-c f n") 'flymake-goto-next-error)
    (define-key flymake-mode-map (kbd "C-c f p") 'flymake-goto-prev-error)
    (or (assoc 'flymake-mode minor-mode-map-alist)
        (setq minor-mode-map-alist
              (cons (cons 'flymake-mode flymake-mode-map)
                    minor-mode-map-alist)))

    (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
        (setq flymake-check-was-interrupted t))
    (ad-activate 'flymake-post-syntax-check)
)
;; html does not to flymake
;(delete '("\\.html\\'" flymake-xml-init) flymake-allowed-file-name-masks)
;(delete '("\\.js\\'" flymake-javascript-init) flymake-allowed-file-name-masks)
;(delete '("\\.css\\'" flymake-css-init) flymake-allowed-file-name-masks)


;(set-face-background 'flymake-warnline "cyan")
;(set-face-foreground 'flymake-warnline "black")
;(set-face-background 'flymake-errline "orange red")
;(set-face-foreground 'flymake-errline "black")

;(defvar flymake-mode-map (make-sparse-keymap))
;(define-key flymake-mode-map (kbd "C-c f n") 'flymake-goto-next-error)
;(define-key flymake-mode-map (kbd "C-c f p") 'flymake-goto-prev-error)
;(or (assoc 'flymake-mode minor-mode-map-alist)
;    (setq minor-mode-map-alist
;          (cons (cons 'flymake-mode flymake-mode-map)
;                minor-mode-map-alist)))

;(defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
;    (setq flymake-check-was-interrupted t))
;(ad-activate 'flymake-post-syntax-check)

;;(require 'flymake-helper)
(require 'flymake-cursor)

;; smartparens
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
	(t (self-insert-command (or arg 1)))))

;;(global-set-key "f8" 'match-paren)
;;(global-set-key (kbd "%") 'match-paren)
(global-set-key "%" 'match-paren)


;; tags
(global-set-key (kbd "C-c .") 'find-tag)
(global-set-key (kbd "C-c t") 'visit-tags-table)


(defun ska-point-to-register()
  (interactive)
  (setq zmacs-region-stays t)
  (point-to-register 8))

(defun ska-jump-to-register()
  (interactive)
  (setq zmacs-region-stays t)
  (let ((tmp (point-marker)))
    (jump-to-register 8)
    (set-register 8 tmp)))

(global-set-key (kbd "C-c s") 'ska-point-to-register)
(global-set-key (kbd "C-c g") 'ska-jump-to-register)

(provide 'emacs-edit)
