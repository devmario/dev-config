;;??
(require 'package)
(setq package-enable-at-startup nil) ; To avoid initializing twice
(package-initialize)

;;라인넘버 켜기
(global-linum-mode 1)

;;package 서버 셋팅
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
      ("marmalade" . "https://marmalade-repo.org/packages/")
      ("melpa" . "http://melpa.org/packages/")))

;;neotree
(global-set-key [f8] 'neotree-toggle)
(global-set-key [f9] 'neotree-show)

;;eshell
(global-set-key [f10] 'eshell)

;;indent-for-comment
(global-set-key [f5] 'indent-for-tab-command)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ruby on rails
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;http://lorefnon.me/2014/02/02/configuring-emacs-for-rails.html
;;ruby shell
(global-set-key (kbd "C-c r r") 'inf-ruby)
;;rvm
(global-set-key (kbd "C-c r a") 'rvm-activate-corresponding-ruby)
;;project manage
;;global
(projectile-global-mode)
(add-hook 'ruby-mode-hook 'projectile-on)
;;ido-mode flx-ido
;;Display ido results vertically, rather than horizontally
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
(defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
  (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
(add-hook 'ido-setup-hook 'ido-define-keys)
(add-hook 'projectile-mode-hook 'projectile-rails-on)
;;Intelligent Code navigation and Completion with Robe
(add-hook 'ruby-mode-hook 'robe-mode)
(defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
  (rvm-activate-corresponding-ruby))
(global-company-mode t)
(push 'company-robe company-backends)
;;ruby syntax
(add-hook 'ruby-mode-hook 'flymake-ruby-load)
(setq ruby-deep-indent-paren nil)

;;just auto complete(conflict projectile)
;(add-hook 'ruby-mode-hook (lambda () (auto-complete-mode t)))

;;web-mode http://web-mode.org/(conflict projectile)
;(require 'web-mode)
;(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

