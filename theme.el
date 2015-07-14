(auto-install 'ir-black-theme)

(load-theme 'ir-black t)

(let ((*mode-line-bg* "#202020")
	  (*mode-line-fg* "#CCC")
	  (*tabbar-default-fg* "#777")
	  (*tabbar-default-bg* "#333"))

  (custom-set-faces
   ;; GUI
   `(minibuffer-prompt ((t (:foreground "green"))))
   `(mode-line ((t (:background, *mode-line-bg* :foreground, "yellow"))))
   `(vertical-border ((t (:background, *mode-line-bg* :foreground, "black"))))

   ;; ido flx
   `(flx-highlight-face ((t (:foreground, "brightred" :underline, t))))
   
   ;; tabbar
   `(tabbar-default ((t (:background, *tabbar-default-bg* :foreground, *tabbar-default-fg*))))
   `(tabbar-selected ((t (:background, *tabbar-default-bg* :foreground, "#96CBFE"))))
   `(tabbar-unselected ((t (:background, *tabbar-default-bg* :foreground, *tabbar-default-fg*))))
   `(tabbar-modified ((t (:background, *tabbar-default-bg* :foreground, "#FF6C60"))))

   ;; neo tree
   `(neo-file-link-face ((t (:foreground, "#777"))))
   `(neo-dir-link-face ((t (:foreground, "#A245FF"))))
   `(neo-banner-face ((t (:foreground, "brightred"))))   
   `(neo-expand-btn-face ((t (:foreground, "#00FFFF"))))
   `(neo-root-dir-face ((t (:foreground, "yellow"))))
   `(neo-header-face ((t (:foreground, "brightblue"))))

   ;; speedbar
   `(speedbar-directory-face ((t (:foreground, "#A245FF"))))
   
   ;; font-lock
   `(font-lock-function-name-face ((t (:foreground "green"))))))

;; tabbar adding spaces
(defun tabbar-buffer-tab-label (tab)
  "Return a label for TAB.
That is, a string used to represent it on the tab bar."
  (let ((label  (if tabbar--buffer-show-groups
					(format " [%s] " (tabbar-tab-tabset tab))
				  (format " %s " (tabbar-tab-value tab)))))
	;; Unless the tab bar auto scrolls to keep the selected tab
	;; visible, shorten the tab label to keep as many tabs as possible
	;; in the visible area of the tab bar.
	(if tabbar-auto-scroll-flag
		label
	  (tabbar-shorten
	   label (max 1 (/ (window-width)
					   (length (tabbar-view
								(tabbar-current-tabset)))))))))

;; menu bar hide
(menu-bar-mode -1)

