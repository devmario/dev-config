(auto-install 'projectile-rails 'robe 'ruby-mode 'inf-ruby 'rvm 'flymake-ruby)

;; ruby shell
(require 'inf-ruby)
(global-set-key (kbd "C-c r r") 'inf-ruby)

; Integration with RVM
(require 'rvm)
(global-set-key (kbd "C-c r a") 'rvm-activate-corresponding-ruby)

(defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
  (rvm-activate-corresponding-ruby))

; ruby hs
(add-to-list 'hs-special-modes-alist
						 `(ruby-mode
							 ,(rx (or "def" "class" "module" "{" "[" "if" "when" "do"))
							 ,(rx (or "}" "]" "end"))
							 ,(rx (or "#" "=begin"))
							 ruby-forward-sexp nil))


; project with ac
(require 'robe)
(require 'projectile)
(require 'projectile-rails)
(defun on-mode-rails()
	  (auto-complete-mode 1)
		(projectile-mode 1)
		(projectile-rails-on)
		(hs-minor-mode 1))
(defun global-rails-hook ()
  (setq ac-sources '(ac-source-words-in-same-mode-buffers
										 ac-source-filename
										 ac-source-files-in-current-dir))
	(on-mode-rails))
(defun rails-ruby-hook()
  (setq ac-sources '(ac-source-words-in-same-mode-buffers
										 ac-source-filename
										 ac-source-files-in-current-dir))
  (ac-robe-setup)
  (robe-mode)
	(on-mode-rails))
(require 'ac-html)
(defun haml-ac-hook()
  (setq ac-sources '(ac-source-words-in-same-mode-buffers
										 ac-source-filename
										 ac-source-files-in-current-dir
										 ac-source-html-tag
										 ac-source-html-attribute
										 ac-source-html-attribute-value
										 ac-source-css-property))
	(ac-haml-enable)
	;(ac-robe-setup)
	;(robe-mode)
	(on-mode-rails))
(defun javascript-my-hook()
	(setq ac-sources '(ac-source-words-in-same-mode-buffers
										 ac-source-filename
										 ac-source-files-in-current-dir
										 ac-source-html-tag
										 ac-source-html-attribute
										 ac-source-html-attribute-value
										 ac-source-css-property
										 ac-source-jquery))
	(on-mode-rails))
(add-hook 'ruby-mode-hook 'rails-ruby-hook)
(add-hook 'web-mode-hook 'global-rails-hook)
(add-hook 'html-mode-hook 'global-rails-hook)
(add-hook 'coffee-mode-hook 'javascript-my-hook)
(add-hook 'javascript-mode-hook 'javascript-my-hook)
(add-hook 'css-mode-hook 'global-rails-hook)

(add-to-list 'auto-mode-alist '("\\.html.haml\\'" . haml-mode))
(require 'flymake-haml)
(add-hook 'haml-mode-hook 'haml-ac-hook)
(add-hook 'haml-mode-hook 'flymake-haml-load)

; ac html
(require 'web-mode)
(add-hook 'html-mode-hook 'ac-html-enable)
(add-to-list 'web-mode-ac-sources-alist
             '("html" . (ac-source-html-attribute-value
                         ac-source-html-tag
                         ac-source-html-attribute)))
(add-to-list 'auto-mode-alist '("\\.html.erb\\'" . web-mode))

; scss
(add-to-list 'auto-mode-alist '("\\.scss\\'" . css-mode))

; flymake ruby
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)
