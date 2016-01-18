(auto-install 'ggtags)
(require 'ggtags)

(setq load-path (cons "/usr/local/Cellar/global/6.5/bin/gtags" load-path))
(autoload 'gtags-mode "gtags" "" t)

(add-hook 'c-mode-common-hook
		  (lambda ()
			(when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
			  (ggtags-mode 1))))

(define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
(define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
(define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
(define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
(define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
(define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)

(define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)

(setq
 helm-gtags-ignore-case t
 helm-gtags-auto-update t
 helm-gtags-use-input-at-cursor t
 helm-gtags-pulse-at-cursor t
 helm-gtags-prefix-key "\C-cg"
 helm-gtags-suggested-key-mapping t
 )

(require 'helm-gtags)
;; Enable helm-gtags-mode
(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

(define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
(define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
(define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
(define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
(define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
(define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)

(setq-local imenu-create-index-function #'ggtags-build-imenu-index)

(auto-install 'company)

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(setq company-backends (delete 'company-semantic company-backends))

(add-to-list 'company-backends 'company-c-headers)

(auto-install 'cc-mode 'semantic)

(require 'cc-mode)
(require 'semantic)

(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)

(semantic-mode 1)

(semantic-add-system-include "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include/c++/v1/" 'c++-mode)
(semantic-add-system-include "/usr/local/include/")
(semantic-add-system-include "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/6.1.0/include/")
(semantic-add-system-include "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include/")
(semantic-add-system-include "/usr/include/")


(auto-install 'function-args)

(require 'function-args)
(fa-config-default)
(define-key c-mode-map  [(control tab)] 'moo-complete)
(define-key c++-mode-map  [(control tab)] 'moo-complete)
(define-key c-mode-map (kbd "M-o")  'fa-show)
(define-key c++-mode-map (kbd "M-o")  'fa-show)

(setq-default c-indent-tabs-mode t     ; Pressing TAB should cause indentation
			  c-indent-level 4         ; A TAB is equivilent to four spaces
			  c-argdecl-indent 0       ; Do not indent argument decl's extra
			  c-tab-always-indent t
			  backward-delete-function nil) ; DO NOT expand tabs when deleting

(require 'yasnippet)
(yas-global-mode 1)


(auto-install 'objc-font-lock)
(add-to-list 'auto-mode-alist '("\\.mm\\'" . objc-mode))

(add-to-list 'auto-mode-alist '("\\.ux\\'" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.unoproj\\'" . javascript-mode))


;;(auto-install 'multi-web-mode)
;;(require 'multi-web-mode)
;;(setq mweb-default-major-mode 'xml-mode)
;;(setq mweb-tags '((javascript-mode "<Javascript>" "</Javascript>")))
;;(setq mweb-filename-extensions '("ux"))
;;(multi-web-global-mode 1)

(auto-install 'csharp-mode)
(add-to-list 'auto-mode-alist '("\\.uno\\'" . csharp-mode))

(add-to-list 'grep-find-ignored-files "*.uxl")
(add-to-list 'grep-find-ignored-files "CPlusPlus")
(add-to-list 'grep-find-ignored-files "lib")
(eval-after-load 'helm-grep
  '(setq helm-grep-default-command helm-grep-default-recurse-command))
(defun uno-grep ()
  (interactive)
  (helm-do-grep-1 '("/usr/local/share/uno/Packages") t nil '("*.uno")))


(add-to-list 'flycheck-checkers 'swift)

(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(unless (file-exists-p "~/.emacs.d/ac-dict/swift-mode")
  (url-copy-file "https://raw.githubusercontent.com/andelf/Defines-Swift/master/misc/swift-mode"
				 "~/.emacs.d/ac-dict/swift-mode"))

(add-hook 'swift-mode-hook
		  #'(lambda ()
			  (auto-complete-mode t)
			  (add-to-list 'ac-sources 'ac-source-files-in-current-dir)
			  (electric-pair-mode t)
			  (add-to-list 'ac-sources 'ac-source-dictionary)
			  ))
