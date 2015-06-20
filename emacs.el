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

(auto-install 'eshell 'neotree 'tabbar 'auto-complete 'magit
	      'rust-mode 'flymake-rust
	      'flylisp 'flymake 'flycheck
	      'company 'projectile 'ido 'robe
	      'ruby-mode 'inf-ruby 'rvm 'flymake-ruby 'projectile-rails
	      'coffee-mode 'css-mode 'web-mode)

<<<<<<< HEAD
; change magit diff colors
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
     (set-face-foreground 'diff-removed "red3")))

=======
>>>>>>> d409dee16cf6c2101c0632406dfb9afefecac9bc
; cursor
(when (display-graphic-p)
  (setq-default cursor-type 'bar)
  (set-cursor-color "#ffffff"))
(blink-cursor-mode t)

; flymake emacs lisp
(defun flymake-elisp-init ()
  (unless (string-match "^ " (buffer-name))
    (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                         'flymake-create-temp-inplace))
           (local-file  (file-relative-name
                         temp-file
                         (file-name-directory buffer-file-name))))
      (list
       (expand-file-name invocation-name invocation-directory)
       (list
        "-Q" "--batch" "--eval" 
        (prin1-to-string
         (quote
          (dolist (file command-line-args-left)
            (with-temp-buffer
              (insert-file-contents file)
              (condition-case data
                  (scan-sexps (point-min) (point-max))
                (scan-error
                 (goto-char(nth 2 data))
                 (princ (format "%s:%s: error: Unmatched bracket or quote\n"
                                file (line-number-at-pos)))))))
          )
         )
        local-file)))))

(push '("\\.el$" flymake-elisp-init) flymake-allowed-file-name-masks)
(add-hook 'emacs-lisp-mode-hook
          (function (lambda () (if buffer-file-name (flymake-mode)))))

; auto complete ielm
(defun emacs-lisp-auto-complete ()
  (setq ac-sources '(ac-source-functions
                     ac-source-variables
                     ac-source-features
                     ac-source-symbols
                     ac-source-words-in-same-mode-buffers))
  (add-to-list 'ac-modes 'emacs-lisp-mode)
  (auto-complete-mode 1))

(add-hook 'emacs-lisp-mode-hook 'emacs-lisp-auto-complete)

; emacs lisp hook
(add-hook 'emacs-lisp-mode-hook 'linum-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)

; auto mode emacs lisp
(add-to-list 'auto-mode-alist '("\\.el\\'" . emacs-lisp-mode))

; auto mode web
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

; web mode hook
(add-hook 'web-mode-hook 'auto-complete-mode)

; web mode indent offset
(setq-default web-mode-markup-indent-offset tab-width)
(setq-default web-mode-css-indent-offset tab-width)
(setq-default web-mode-code-indent-offset tab-width)
(setq-default web-mode-sql-indent-offset tab-width)

; key setup
(defun key-setup (&rest i)
  (mapcar
   (lambda (j)
     (global-set-key (kbd (car j)) (cdr j)))
   i))

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

; tabbar face
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
                                (tabbar-current-tabset)))))))))
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

; xterm mouse mode
(xterm-mouse-mode)

(if (display-graphic-p)
    (progn
      (message "graphic"))
  (message "none graphic"))

(message "%s" window-system)

(message "Devmario's Emacs enviropment load up finished!")
