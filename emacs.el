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
;; check OS type
(cond
 ((string-equal system-type "windows-nt") ; Microsoft Windows
  (progn
    (message "Microsoft Windows")))
 ((string-equal system-type "darwin") ; Mac OS X
  (progn
	(setq devmario::rootDir "~/Documents/dev-config/")))
 ((string-equal system-type "gnu/linux") ; linux
  (progn
    (setq devmario::rootDir "~/dev-config/"))))

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

(auto-install 'yafolding)
(define-key yafolding-mode-map (kbd "C-x y") 'yafolding-toggle-element)

;; util
(load-file (concat devmario::rootDir "util.el"))

(load-file (concat devmario::rootDir "theme.el"))

;; auto-complete confi
(load-file (concat devmario::rootDir "auto-complete.el"))

;; shell(eshell)
(load-file (concat devmario::rootDir "shell.el"))

;; org
(load-file (concat devmario::rootDir "org.el"))

;; lang
(load-file (concat devmario::rootDir "elisp.el"))

;;(load-file (concat devmario::rootDir "survive.el"))
;; (load-file (concat devmario::rootDir "myletter.el"))
;;(load-file (concat devmario::rootDir "c++.el"))
;; (load-file (concat devmario::rootDir "rust.el"))

 (load-file (concat devmario::rootDir "php.el"))
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


;; (auto-install 'js2-mode)

(add-hook 'web-mode-hook
      (lambda ()
        ;; short circuit js mode and just do everything in jsx-mode
        (if (equal web-mode-content-type "javascript")
            (web-mode-set-content-type "jsx")
          (message "now set to: %s" web-mode-content-type))))

;; ;; delay execution of this code until `web-mode' is turned on.
;; (add-hook 'web-mode-hook (lambda()
;;   ;;needed to bind a key for `js2-mode-map'
;;   (require 'js2-mode)
;;   (require 'cl)

;;   (defun my/js2-mode-on-region (start end)
;;     "Narrow on the active region, then turn on js2-mode."
;;     (interactive "r")
;;     (deactivate-mark)
;;     (narrow-to-region start end)
;;     (js2-mode))

;;   (cl-defun my/focus-javascript () ;using `cl-defun' to allow `return-from'
;;     "Automatcially narrow between <script> tags, then turn on js2-mode."
;;     (interactive)
;;     (let ((start-tag-name "<script")
;;           (end-tag-name   "</script")
;;           (start          nil)
;;           (end            nil))
;;       ;; Find start tag. Search backwards first to give priority to tag pairs
;;       ;; the cursor is currently inside.
;;       (setq start (search-backward start-tag-name nil t))
;;       (when (null start)
;;         ;; if start tag not found backwards, then try forwards.
;;         (setq start (search-forward start-tag-name nil t)))
;;       (when (null start)
;;         (message "start tag not found")
;;         (return-from my/focus-javascript nil))
;;       ;;start is found, move cursor down a line, start highlighitng
;;       (next-line)
;;       (move-beginning-of-line nil)
;;       (set-mark-command nil) ;(evil-visual-line)
;;       ;; jump to end tag. always search forward
;;       (setq end (search-forward end-tag-name nil t))
;;       (when (null end)
;;         (deactivate-mark)
;;         (message "end tag not found")
;;         (return-from my/focus-javascript nil))
;;       ;;end tag is found. now move cursor up one line
;;       (previous-line)
;;       (move-end-of-line nil)
;;       ;; turn on js2-mode for this region. (and narrow)
;;       (call-interactively #'my/js2-mode-on-region)))

;;   (defun my/unfocus-javascript ()
;;     "Undo the effects of `my/focus-javascript'."
;;     (interactive)
;;     (widen)
;;     (web-mode))

;;   ;; key bindings
;;   (define-key web-mode-map (kbd "C-c j") #'my/focus-javascript)
;;   ;; TODO: Use a different technique for this keybind. If we didn't enter
;;   ;; `js2-mode' from `web-mode' then we don't want `my/unfocus-javascript' to
;;   ;; turn on web-mode.
;;   (define-key js2-mode-map (kbd "C-c u") #'my/unfocus-javascript)))

;; done
(message "Devmario's Emacs enviropment load up finished!")
