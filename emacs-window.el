;; EMACS WINDOS

(require 'maxframe)
(add-hook 'window-setup-hook 'maximize-frame nil)
(add-hook 'after-make-frame-functions (lambda (frame) (select-frame frame) (maximize-frame)) nil)

;; Color
(require 'color-theme)
(color-theme-initialize)
;(color-theme-robin-hood)
;(color-theme-tty-dark)
;(color-theme-arjen)
;(color-theme-xp)
;(color-theme-classic)
;(color-theme-comidia)
;(color-theme-deep-blue)
;(color-theme-hober)
;(color-theme-jonadabian)
;(color-theme-mistyday)
;(color-theme-gnome2)

(provide 'emacs-window)
