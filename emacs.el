																				; package list
(require 'package)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
				("marmalade" . "https://marmalade-repo.org/packages/")
				("melpa" . "http://melpa.org/packages/")))
(package-initialize)

																				; auto install
(defun auto-install (&rest i)
  (mapcar
   (lambda (j)
     (if (package-installed-p j)
				 nil
       (package-install j)))
   i))

																				; default
(auto-install 'iedit 'eshell 'neotree 'tabbar 'auto-complete 'magit 'linum-relative
							'yasnippet 'flymake 'flycheck 'company 'projectile 'ido)

(auto-install 'rust-mode 'flymake-rust 'ac-html 'auto-complete-c-headers
							'flymake-google-cpplint 'google-c-style
							'flylisp 'robe 'haml-mode 'flymake-haml
							'ruby-mode 'inf-ruby 'rvm 'flymake-ruby 'projectile-rails
							'coffee-mode 'jquery-doc 'css-mode 'web-mode 'flymake-coffee)

																				; magit face
(unless (display-graphic-p)
	(eval-after-load 'magit
		'(progn
			 (set-face-foreground 'magit-diff-add "green3")
			 (set-face-foreground 'magit-diff-del "red3")
			 (set-face-foreground 'magit-branch "red1")
			 (set-face-foreground 'magit-log-head-label-remote "black")
			 (set-face-foreground 'magit-log-head-label-local  "red")
			 (when (not window-system)
				 (set-face-background 'magit-item-highlight "black")
				 (set-face-foreground 'magit-item-highlight "white"))))
	(add-to-list 'auto-mode-alist '("COMMIT_EDITMEG$" . diff-mode))
	(eval-after-load 'diff-mode
		'(progn
			 (set-face-foreground 'diff-added "green4")
			 (set-face-foreground 'diff-removed "red3"))))

																				; cursor
(when (display-graphic-p)
  (setq-default cursor-type 'bar)
  (set-cursor-color "#ffffff"))
(blink-cursor-mode t)

																				; key setup
(defun key-setup (&rest i)
  (mapcar
   (lambda (j)
     (global-set-key (kbd (car j)) (cdr j)))
   i))

(define-key global-map (kbd "C-c ;") 'iedit-mode)

																				; window move
(key-setup '("C-x <up>" . windmove-up)
					 '("C-x <down>" . windmove-down)
					 '("C-x <right>" . windmove-right)
					 '("C-x <left>" . windmove-left))

																				; tabbar move
(require 'tabbar)
(key-setup '("C-c g <left>" . tabbar-backward-group)
					 '("C-c g <right>" . tabbar-forward-group)
					 '("C-c <left>" . tabbar-backward)
					 '("C-c <right>" . tabbar-forward))

																				; linum toggle
(require 'linum-relative)
(key-setup '("C-c l l" . linum-mode)
	   '("C-c l r" . linum-relative-toggle))

																				; tabbar face
(unless (display-graphic-p)
	(set-face-attribute
	 'tabbar-default nil
	 :background "gray60")
	(set-face-attribute
	 'tabbar-unselected nil
	 :background "gray30"
	 :foreground "white"
	 :box '(:line-width 1 :color "gray30" :style nil))
	(set-face-attribute
	 'tabbar-selected nil
	 :background "gray75"
	 :foreground "black"
	 :box '(:line-width 1 :color "gray75" :style nil))
	(set-face-attribute
	 'tabbar-highlight nil
	 :background "white"
	 :foreground "black"
	 :underline nil
	 :box '(:line-width 1 :color "white" :style nil))
	(set-face-attribute
	 'tabbar-button nil
	 :foreground "black"
	 :box '(:line-width 1 :color "gray20" :style nil))
	(set-face-attribute
	 'tabbar-separator nil
	 :background "gray20"
	 :height 0.6)
	(set-face-attribute
	 'tabbar-separator nil
	 :height 0.7)
	(custom-set-variables
	 '(tabbar-separator (quote (1.0))))
	(defun tabbar-buffer-tab-label (tab)
		(let ((label  (if tabbar--buffer-show-groups
											(format "[%s]  " (tabbar-tab-tabset tab))
										(format "(%s)" (tabbar-tab-value tab)))))
			(if tabbar-auto-scroll-flag
					label
				(tabbar-shorten
				 label (max 1 (/ (window-width)
												 (length (tabbar-view
																	(tabbar-current-tabset))))))))))

(tabbar-mode 1)

																				; neotree
(require 'neotree)
(neotree-show)

																				; scroll bar
(require 'scroll-bar)
(scroll-bar-mode t)

																				; ido
(require 'ido)
(ido-mode t)

																				; ido vertical
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
(defun ido-define-keys ()
  (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
(add-hook 'ido-setup-hook 'ido-define-keys)

																				; M-x mode ido
(global-set-key
 "\M-x"
 (lambda ()
	 (interactive)
	 (call-interactively
		(intern
		 (ido-completing-read
			"M-x "
			(all-completions "" obarray 'commandp))))))

																				; xterm mouse mode
(xterm-mouse-mode)

																				; ac bug fix
(require 'auto-complete-config)
(ac-config-default)
(ac-linum-workaround)
(setq ac-stop-flymake-on-completing 1)
(setq ac-use-quick-help 1)
(ac-syntax-checker-workaround)

																				; TODO with sql-complete => http://www.emacswiki.org/emacs/SqlComplete
																				; sql
(defcustom sql-mysql-data-dictionary
	"select concat('\\(', '\\\"', table_name, '\\\" \\\"', column_name, '\\\"', '\\)') 
     from information_schema.columns 
     order by table_name;"
	"SQL Statement to determine all tables and columns."
	:group 'SQL
	:type 'string)
(defun sql-mysql-data-dictionary ()
	(interactive)
	;; FIXME No cleanup
	(setq sql-data-dictionary
        (sql-data-dictionary sql-mysql-data-dictionary)))

(setq-default tab-width 2)

																				; load dev env
(if (equal system-type "darwin")
		(setq devmario::rootDir "~/Documents/dev-config/")
	(setq devmario::rootDir "~/dev-config/"))

(load-file (concatenate devmario::rootDir "sql-complete.el"))
(load-file (concatenate devmario::rootDir "elisp.el"))
(load-file (concatenate devmario::rootDir "rails.el"))
(load-file (concatenate devmario::rootDir "c++.el"))

(message "Devmario's Emacs enviropment load up finished!")
