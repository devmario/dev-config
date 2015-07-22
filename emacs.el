;; DONE eshell include bash ENV
;; TODO fuzzy rgrep
;; TODO fuzzy auto-complete
;; https://github.com/grizzl/fiplr
;; http://stackoverflow.com/questions/1478616/is-there-a-way-to-get-emacss-anything-to-do-fuzzy-searches
;; http://hamlphp.github.io/HamlPHP/
;; https://github.com/alxlit/coffeescript-php
;; TODO php html haml javascript coffeescript mysql wordpress nginx
;; TODO C# Fuse Unity
;; TODO C/C++ ObjectiveC swift Xcode iOS MAC
;; TODO Java maven Eclipse Android
;; TODO sh bash
;; TODO SQL
;; TODO rust https://github.com/phildawes/racer
;; TODO python

;; BUG eshell auto complete error
;; TODO eshell auto complete man doc popup

;; setup repos
(require 'package)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
		("marmalade" . "https://marmalade-repo.org/packages/")
		("melpa" . "http://melpa.org/packages/")))
(package-initialize)

;; include root(mac, linux)
(if (equal system-type 'darwin)
	(setq devmario::rootDir "~/Documents/dev-config/")
  (setq devmario::rootDir "~/dev-config/"))

;; include
(defun auto-install (&rest i)
  (mapcar
   (lambda (j)
     (if (package-installed-p j)
		 nil
       (package-install j)))
   i))

;; not partial package
;; (auto-install 'rust-mode 'flymake-rust 'ac-html 'haml-mode 'flymake-haml 'coffee-mode 'jquery-doc 'css-mode 'web-mode 'flymake-coffee)

;; util
(load-file (concat devmario::rootDir "util.el"))

(load-file (concat devmario::rootDir "theme.el"))

;; auto-complete config
(load-file (concat devmario::rootDir "auto-complete.el"))

;; shell(eshell)
(load-file (concat devmario::rootDir "shell.el"))

;; org
(load-file (concat devmario::rootDir "org.el"))

;; lang
(load-file (concat devmario::rootDir "elisp.el"))

;; (load-file (concat devmario::rootDir "c++.el"))
;; (load-file (concat devmario::rootDir "rust.el"))

;; (load-file (concat devmario::rootDir "php.el"))
;; (load-file (concat devmario::rootDir "html.el"))
;; (load-file (concat devmario::rootDir "javascript.el"))
;; (load-file (concat devmario::rootDir "css.el"))

;; (load-file (concat devmario::rootDir "coffeescript.el"))
;; (load-file (concat devmario::rootDir "python.el"))
;; (load-file (concat devmario::rootDir "ruby.el"))
;; (load-file (concat devmario::rootDir "shellscript.el"))

;; (load-file (concat devmario::rootDir "objective-c.el"))
;; (load-file (concat devmario::rootDir "c#.el"))

;; dev env
;; (load-file (concat devmario::rootDir "rails.el"))
;; (load-file (concat devmario::rootDir "sql-complete.el"))
;; (load-file (concat devmario::rootDir "ios.el"))

;; project


;;(global-linum-mode t)

;; check emacs version
(if (version< emacs-version "24.4")
    (progn (message "is before 24.4"))
  (progn (message "is 24.4 or after")))

;; check emacs version
(if (or 
     (and (>= emacs-major-version 24) 
          (>= emacs-minor-version 4))
     (>= emacs-major-version 25))
    (progn (message "is 24.4 or after"))
  (progn (message "is before 24.4")))

;; check OS type
(cond
 ((string-equal system-type "windows-nt") ; Microsoft Windows
  (progn
    (message "Microsoft Windows")))
 ((string-equal system-type "darwin") ; Mac OS X
  (progn
    (message "Mac OS X")))
 ((string-equal system-type "gnu/linux") ; linux
  (progn
    (message "Linux"))))

;; done
(message "Devmario's Emacs enviropment load up finished!")
