; flymake ruby
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)
(setq ruby-deep-indent-paren nil)

; ruby shell
(require 'inf-ruby)
(global-set-key (kbd "C-c r r") 'inf-ruby)

; Integration with RVM
(require 'rvm)
(global-set-key (kbd "C-c r a") 'rvm-activate-corresponding-ruby)

(defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
  (rvm-activate-corresponding-ruby))

; project with ac
(require 'robe)
(require 'projectile)
(require 'projectile-rails)
(require 'company)
(defun global-rails-hook ()
	(setq ac-sources '(ac-source-words-in-all-buffer
										 ac-source-filename
										 ac-source-files-in-current-dir))
 	(ac-robe-setup)
	(robe-mode)
	(robe-start)
  (auto-complete-mode 1)
  (projectile-mode 1)
  (projectile-rails-on)
  (hs-minor-mode 1)
  (linum-mode 1))
(add-hook 'ruby-mode-hook 'global-rails-hook)
(add-hook 'web-mode-hook 'global-rails-hook)
(add-hook 'html-mode-hook 'global-rails-hook)
(add-hook 'coffee-mode-hook 'global-rails-hook)
(add-hook 'javascript-mode-hook 'global-rails-hook)
(add-hook 'css-mode-hook 'global-rails-hook)

; ac html
(require 'ac-html)
(require 'web-mode)
(add-hook 'html-mode-hook 'ac-html-enable)
(add-to-list 'web-mode-ac-sources-alist
             '("html" . (ac-source-html-attribute-value
                         ac-source-html-tag
                         ac-source-html-attribute)))
(setq-default tab-width 2)
(add-to-list 'auto-mode-alist '("\\.html.erb\\'" . web-mode))

; scss
(add-to-list 'auto-mode-alist '("\\.scss\\'" . css-mode))
