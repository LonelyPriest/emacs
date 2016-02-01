;;auto-complete
(add-to-list 'load-path "/usr/local/share/emacs/24.3/site-lisp/ruby-mode")

(add-to-list 'auto-mode-alist
	     '("\\.\\(?:gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode))
(add-to-list 'auto-mode-alist
	     '("\\(Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode))


					; must be added after any path containing old ruby-mode
(add-to-list 'load-path "/usr/local/share/emacs/24.3/site-lisp/enhanced-ruby-mode-master")

(autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))

;; optional
(setq enh-ruby-program "ruby") ; so that still works if ruby points to ruby1.8


(setq enh-ruby-bounce-deep-indent t)
(setq enh-ruby-hanging-brace-indent-level 2)


(require 'cl) ; If you don't have it already

(defun* get-closest-gemfile-root (&optional (file "Gemfile"))
  "Determine the pathname of the first instance of FILE starting from the current directory towards root.
This may not do the correct thing in presence of links. If it does not find FILE, then it shall return the name
of FILE in the current directory, suitable for creation"
  (let ((root (expand-file-name "/"))) ; the win32 builds should translate this correctly
    (loop
     for d = default-directory then (expand-file-name ".." d)
     if (file-exists-p (expand-file-name file d))
     return d
     if (equal d root)
     return nil)))

(require 'compile)

(defun rspec-compile-file ()
  (interactive)
  (compile (format "cd %s;bundle exec rspec %s"
		   (get-closest-gemfile-root)
		   (file-relative-name (buffer-file-name) (get-closest-gemfile-root))
		   ) t))

(defun rspec-compile-on-line ()
  (interactive)
  (compile (format "cd %s;bundle exec rspec %s -l %s"
		   (get-closest-gemfile-root)
		   (file-relative-name (buffer-file-name) (get-closest-gemfile-root))
		   (line-number-at-pos)
		   ) t))

(add-hook 'enh-ruby-mode-hook
	  (lambda ()
	    (local-set-key (kbd "C-c l") 'rspec-compile-on-line)
	    (local-set-key (kbd "C-c k") 'rspec-compile-file)
	    ))


(provide 'emacs-ruby)
