;; [유용한 링크] http://pages.sachachua.com/.emacs.d/Sacha.html
;; http://sachachua.com/

;; magit only excute emacs version 24.4
(if (version< emacs-version "24.4")
	"24.4 부터만 magit 지원"
  (progn (auto-install 'egg))
  (progn (auto-install 'magit)))

(auto-install 'iedit 'neotree 'tabbar 'linum-relative 'sr-speedbar 'company 'projectile 'ido 'flylisp 'flx-ido 'flx 'ace-jump-mode 'browse-at-remote 'ir-black-theme 'helm 'helm-swoop 'hlinum)

;; iedit
(define-key global-map (kbd "C-c ;") 'iedit-mode)

;; windmove
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)

;; tabbar
(tabbar-mode t)
(global-set-key (kbd "C-c g <left>") 'tabbar-backward-group)
(global-set-key (kbd "C-c g <right>") 'tabbar-forward-group)
(global-set-key (kbd "C-c <left>") 'tabbar-backward)
(global-set-key (kbd "C-c <right>") 'tabbar-forward)

;; linum
;; (require 'hlinum)
;; (hlinum-activate)
(global-set-key (kbd "C-c l l") 'linum-mode)
;; (global-set-key (kbd "C-c l r") 'linum-relative-toggle)

;; ido
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-use-faces nil)

;; ido vertical
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
(defun ido-define-keys ()
  (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
(add-hook 'ido-setup-hook 'ido-define-keys)

;; ido M-x
(global-set-key
 "\M-x"
 (lambda ()
   (interactive)
   (call-interactively
	(intern
	 (ido-completing-read
	  "M-x "
	  (all-completions "" obarray 'commandp))))))

;; tab width
(setq-default tab-width 4)

;; ace-jump
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; helm do grep
;; https://github.com/emacs-helm/helm/wiki
(eval-after-load 'helm-grep
  '(setq helm-grep-default-command helm-grep-default-recurse-command))
(define-key global-map (kbd "C-x g") 'helm-do-grep)

;; helm swoop (find quick line)
(define-key global-map (kbd "M-s M-s") 'helm-swoop)
(define-key global-map (kbd "M-s M-a") 'helm-multi-swoop-all)
(define-key global-map (kbd "M-s M-d") 'helm-multi-swoop)

;; 어두워서 안보여서 색상 바꿈
;; (set-face-foreground 'minibuffer-prompt "green")

;; 이거 if체크 필요
;; (blink-cursor-mode t)
;; (scroll-bar-mode t)
(xterm-mouse-mode t)
;; (desktop-save-mode t)

;; (load-theme 'ir-black t)

;; http://mwolson.org/static/doc/erc.html
;; (erc-autojoin-enable)
;; (setq erc-autojoin-channels-alist '(("irc.freenote.net" "#chief-founder")))
;; (erc :server "52.69.162.111" :port "6667" :nick user-login-name :password "")

;; http://www.emacswiki.org/emacs/SmoothScrolling
(global-set-key (kbd "<mouse-4>") 'scroll-down-line)
(global-set-key (kbd "<mouse-5>") 'scroll-up-line)

;; redo
(load-file (concat devmario::rootDir "redo.el"))
(require 'redo)
;; undo default C-_
(global-set-key (kbd "C-M-_") 'redo)

;; reload process(but not wait killing process) : once try it => C-q C-c retrun, M-p return
(defun devmario::eshell-reload-process()
  (interactive)
  (eshell-kill-process)
  (eshell-previous-input 1)
  (eshell-send-input))

(message "done")
