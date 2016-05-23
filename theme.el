;; (auto-install 'ir-black-theme 'powerline)

;; (powerline-default-theme)

;; (load-theme 'ir-black t)

;; (let ((*mode-line-bg* "#202020")
;; 	  (*mode-line-fg* "#CCC")
;; 	  (*tabbar-default-fg* "#777")
;; 	  (*tabbar-default-bg* "#333"))

;;   (custom-set-faces
;;    ;; GUI
;;    `(minibuffer-prompt ((t (:foreground "green"))))
;;    `(mode-line ((t (:background, "yellow" :foreground, *mode-line-bg*))))
;;    `(vertical-border ((t (:background, *mode-line-bg* :foreground, *mode-line-bg*))))

;;    ;; ido flx
;;    `(flx-highlight-face ((t (:foreground, "brightred" :underline, t))))

;;    ;; tabbar
;;    `(tabbar-default ((t (:background, *tabbar-default-bg* :foreground, *tabbar-default-fg*))))
;;    `(tabbar-selected ((t (:background, "#96CBFE" :foreground, *tabbar-default-bg*))))
;;    `(tabbar-unselected ((t (:background, *tabbar-default-bg* :foreground, *tabbar-default-fg*))))
;;    `(tabbar-modified ((t (:background, *tabbar-default-bg* :foreground, "#FF6C60"))))
;;    `(tabbar-button ((t (:background, "#A245FF" :foreground, "#FF0"))))

;;    ;; iedit
;;    `(iedit-occurrence ((t (:foreground, "white" :background, "magenta"))))

;;    ;; neo tree
;;    `(neo-file-link-face ((t (:foreground, "#777"))))
;;    `(neo-dir-link-face ((t (:foreground, "#A245FF"))))
;;    `(neo-banner-face ((t (:foreground, "brightred"))))
;;    `(neo-expand-btn-face ((t (:foreground, "#00FFFF"))))
;;    `(neo-root-dir-face ((t (:foreground, "yellow"))))
;;    `(neo-header-face ((t (:foreground, "brightblue"))))
;;    `(highlight-current-line-face ((t (:background, "gray10"))))

;;    `(eshell-prompt ((t (:foreground, "#A245FF"))))

;;    ;; speedbar
;;    `(speedbar-directory-face ((t (:foreground, "#A245FF"))))

;;    ;; font-lock
;;    `(font-lock-function-name-face ((t (:foreground "green"))))))

;; ;; tabbar adding spaces
;; (defun tabbar-buffer-tab-label (tab)
;;   "Return a label for TAB.
;; That is, a string used to represent it on the tab bar."
;;   (let ((label	(if tabbar--buffer-show-groups
;; 					(format " [%s] " (tabbar-tab-tabset tab))
;; 				  (format " %s " (tabbar-tab-value tab)))))
;; 	;; Unless the tab bar auto scrolls to keep the selected tab
;; 	;; visible, shorten the tab label to keep as many tabs as possible
;;     ;; in the visible area of the tab bar.
;;     (if tabbar-auto-scroll-flag
;;         label
;;       (tabbar-shorten
;; 	   label (max 1 (/ (window-width)
;; 					   (length (tabbar-view
;; 								(tabbar-current-tabset)))))))))

;; menu bar hide
(menu-bar-mode -1)

(setq-default show-trailing-whitespace nil)
(setq-default indent-tabs-mode t)
(auto-install 'highlight-current-line 'color-theme)
(highlight-current-line-minor-mode t)
(highlight-current-line-on t)
(global-linum-mode 0)

(load-theme 'misterioso)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(eshell-prompt ((t (:foreground "#A245FF"))))
 '(flx-highlight-face ((t (:foreground "brightred" :underline t))))
 '(font-lock-function-name-face ((t (:foreground "green"))))
 '(highlight-current-line-face ((t (:background "gray10"))))
 '(iedit-occurrence ((t (:foreground "white" :background "magenta"))))
 '(minibuffer-prompt ((t (:foreground "green"))))
 '(mode-line ((t (:background "yellow" :foreground "#202020"))))
 '(neo-banner-face ((t (:foreground "brightred"))))
 '(neo-dir-link-face ((t (:foreground "#A245FF"))))
 '(neo-expand-btn-face ((t (:foreground "#00FFFF"))))
 '(neo-file-link-face ((t (:foreground "#777"))))
 '(neo-header-face ((t (:foreground "brightblue"))))
 '(neo-root-dir-face ((t (:foreground "yellow"))))
 '(speedbar-directory-face ((t (:foreground "#A245FF"))))
 '(tabbar-button ((t (:background "#A245FF" :foreground "#FF0"))))
 '(tabbar-default ((t (:background "#333" :foreground "#777"))))
 '(tabbar-modified ((t (:background "#333" :foreground "#FF6C60"))))
 '(tabbar-selected ((t (:background "#96CBFE" :foreground "#333"))))
 '(tabbar-unselected ((t (:background "#333" :foreground "#777"))))
 '(vertical-border ((t (:background "#202020" :foreground "#202020")))))
