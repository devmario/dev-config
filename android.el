(require 'ggtags)
(autoload 'ggtags-mode "ggtags" "" t)
(setq gtags-suggested-key-mapping t)
(global-set-key (kbd "C-c C-f") 'gtags-find-file)

(require 'auto-complete-config)
(ac-config-default)
(setq ac-ignore-case 'smart)
(setq ac-use-menu-map t)
(setq ac-source-gtags)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

;; alt . => jump
(global-set-key (kbd "C-c C-f") 'helm-gtags-dwim)


(add-hook 'eshell-preoutput-filter-functions
		  'ansi-color-filter-apply)

(add-hook 'eshell-preoutput-filter-functions
		  'ansi-color-apply)
