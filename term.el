;; tabbar
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
								(tabbar-current-tabset)))))))))


;; magit
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
