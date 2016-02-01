(jde-project-file-version "1.0")


(defun add-classpath (absolute_path)
  (if (not (member absolute_path jde-global-classpath))
      (if (listp absolute_path)
	  (setq jde-global-classpath (append jde-global-classpath absolute_path))
	(setq jde-global-classpath (append jde-global-classpath (list absolute_path))))
    jde-global-classpath
  ))

(defun add-sourcepath (absolute_path)
  (if (not (member absolute_path jde-sourcepath))
      (setq jde-sourcepath (append jde-sourcepath (list absolute_path)))
    jde-sourcepath
    ))

(defun get-jar-from-dir (dir_pattern)
  (file-expand-wildcards dir_pattern)
  )

(defun add-jar-to-classpath (dir_pattern)
  (mapcar 'add-classpath (get-jar-from-dir dir_pattern))
  )


(setq prj_base_dir (expand-file-name "~/CCBU_CRM_CODE_SVN/branches/br_CRM_V300R003C40_MAIN/module/ccbm/modules"))

;; classpath
;;(add-jar-to-classpath (concat prj_base_dir "/All/code/lib/common/platform/bme"))
(add-jar-to-classpath (concat prj_base_dir "/All/code/lib/common/platform/intf/com.huawei.ebus.*.jar"))
(add-jar-to-classpath (concat prj_base_dir "/All/code/lib/common/platform/dfx/*.jar"))

(add-classpath "/usr/jdk/jre")

;; sourcepath
(add-sourcepath (concat prj_base_dir "/Platform/code/src/core/business/service"))


(setq jde-compile-option-sourcepath (list (concat prj_base_dir "/Platform/code/src/core/business/service")))

(jde-set-variables
 '(jde-project-name "CRM-C40")
 ;; '(jde-global-classpath '("./classes" "/usr/jdk/jre"))
 ;;'(jde-compile-option-directory "./classes/")
 '(jde-bug-debug-project-function (quote (jde-bug-attach-via-shared-memory)))
 ;;'(jde-sourcepath '("./src"))
 '(jde-bug-attach-shmem-name (quote (nil . "javadebug")))
 ;; '(jde-compiler '("javac"))
 '(jde-compile-option-source '("1.6"))
 '(jde-compile-option-target '("1.6"))
 '(jde-compiler (quote (("eclipse java compiler server" "/usr/share/emacs/24.3/site-lisp/jdee-2.4.1/ecj/ecj-4.3.jar"))))
 '(jde-complete-function 'jde-complete-minibuf))

