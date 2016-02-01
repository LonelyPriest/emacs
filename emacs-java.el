;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Java
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "/usr/share/emacs/24.3/site-lisp/jdee-2.4.1/lisp")

(require 'jde)
(setq ecb-options-version "2.40")
(setq jde-jdk-registry (quote (("1.6.0_39" . "/usr/jdk"))))

(autoload 'jde-mode "jde" "JDE mode" t)
(setq auto-mode-alist
      (append '(("\\.java\\'" . jde-mode)) auto-mode-alist))

(defun my-java-jde-mode-hook()
  (local-set-key  (kbd "M-RET") 'jde-complete))
(add-hook 'java-mode-hook 'my-java-jde-mode-hook)

;; findbugs
(require 'jde-findbugs)
(setq jde-findbugs-directory "/usr/share/emacs/24.3/site-lisp/jdee-2.4.1/findbugs-2.0.2")
(setq jde-findbugs-class  "edu.umd.cs.findbugs.FindBugs2")

;; such as lint
(require 'pmd)
(setq md-home "/usr/share/emacs/24.3/site-lisp/jdee-2.4.1/pmd-bin-5.0.4")
(setq pmd-java-home "/usr/jdk/bin/java")
(autoload 'pmd-current-buffer "pmd" "PMD Mode" t)

;; flymake
(require 'jde-eclipse-compiler-server)
(push '(".+\\.java$" jde-ecj-flymake-init jde-ecj-flymake-cleanup) flymake-allowed-file-name-masks)

;; show error in minibuff
(defun my-flymake-display-err-minibuf ()
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (let* ((line-no             (flymake-current-line-no))
	 (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
	 (count               (length line-err-info-list)))
    (while (> count 0)
      (when line-err-info-list
	(let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
	       (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
	       (text (flymake-ler-text (nth (1- count) line-err-info-list)))
	       (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
	  (message "[%s] %s" line text)))
      (setq count (1- count)))))

;; debug
(require 'jdibug)

(provide 'emacs-java)


