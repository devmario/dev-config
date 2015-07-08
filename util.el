;; magit only excute emacs version 24.4
(if (version< emacs-version "24.4")
    (progn (auto-install 'egg))
  (progn (auto-install 'magit)))

(auto-install 'iedit 'neotree 'tabbar 'linum-relative 'sr-speedbar 'company 'projectile 'ido 'flylisp 'flx-ido 'flx)

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
(global-set-key (kbd "C-c l l") 'linum-mode)
(global-set-key (kbd "C-c l r") 'linum-relative-toggle)

;; scrollbar
(scroll-bar-mode t)

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

;; blink curtor
(blink-cursor-mode t)

;; mouse
(xterm-mouse-mode t)

;; session save
(desktop-save-mode t)

;; eww history
(add-hook 'eww-mode 'eww-history-mode)
