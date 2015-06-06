(require 'package)
;(setq package-enable-at-startup nil) ; To avoid initializing twice

;package 서버 셋팅
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
      ("marmalade" . "https://marmalade-repo.org/packages/")
      ("melpa" . "http://melpa.org/packages/")))

(package-initialize)

;라인넘버 켜기
(global-linum-mode 1)

;indent-for-comment
(global-set-key [f5] 'indent-for-tab-command)

;neotree
(global-set-key [f6] 'neotree-toggle)

;eshell
(global-set-key [f7] 'eshell)

;; tabbar
(require 'tabbar)
(tabbar-mode)

(setq tabbar-background-color "#000000") ;; the color of the tabbar background
(custom-set-faces
 '(tabbar-default ((t (:inherit variable-pitch :background "#ffffff" :foreground "#000000" :weight bold))))
 '(tabbar-button ((t (:inherit tabbar-default :foreground "#000000"))))
 '(tabbar-button-highlight ((t (:inherit tabbar-default))))
 '(tabbar-highlight ((t (:underline t))))
 '(tabbar-selected ((t (:inherit tabbar-default :background "#00ff00"))))
 '(tabbar-separator ((t (:inherit tabbar-default :background "#ff0000"))))
 '(tabbar-unselected ((t (:inherit tabbar-default :background "#0000ff")))))
(global-set-key [f11] 'tabbar-backward-group)
(global-set-key [f12] 'tabbar-forward-group)
(global-set-key [f9] 'tabbar-backward)
(global-set-key [f10] 'tabbar-forward) ;; tabbar.el, put all the buffers on the tabs.

(global-auto-complete-mode)
(require 'auto-complete)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ruby on rails
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;http://lorefnon.me/2014/02/02/configuring-emacs-for-rails.htm

;ruby shell
(global-set-key (kbd "C-c r r") 'inf-ruby)

;rvm
(global-set-key (kbd "C-c r a") 'rvm-activate-corresponding-ruby)

;project manage
;global
;(require 'projectile)
(projectile-global-mode)
(add-hook 'ruby-mode-hook 'projectile-on)
(add-hook 'html-mode-hook 'projectile-on)

;ido-mode flx-ido
;Display ido results vertically, rather than horizontally
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
(defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
  (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
(add-hook 'ido-setup-hook 'ido-define-keys)
(add-hook 'projectile-mode-hook 'projectile-rails-on)

;Intelligent Code navigation and Completion with Robe
;(require 'robe)
;(add-hook 'ruby-mode-hook 'robe-mode)
;(eval-after-load 'company
;  '(push 'company-robe company-backends))
;(add-hook 'robe-mode-hook 'ac-robe-setup)
;
;(defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
;  (rvm-activate-corresponding-ruby))
;(require 'company)
;(global-company-mode t)
;(push 'company-robe company-backends)


;ruby ac
(add-hook 'ruby-mode-hook 'auth-complete-mode)
;ruby syntax
(add-hook 'ruby-mode-hook 'flymake-ruby-load)
;(setq ruby-deep-indent-paren nil)

;html ac
(add-hook 'html-mode-hook 'auto-complete-mode)
(add-hook 'coffee-mode-hook 'auto-complete-mode)

;just auto complete
;(add-hook 'ruby-mode-hook (lambda () (auto-complete-mode t)))

;web-mode http://web-mode.org/
;(require 'web-mode)
;(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(require 'css-mode)
(add-to-list 'auto-mode-alist '("\\.scss\\'" . css-mode))
