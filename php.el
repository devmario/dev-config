
(auto-install 'php-mode 'web-mode 'jade-mode)

(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))
(add-to-list 'auto-mode-alist '("\\.php$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
(defun web-mode-additional ()
  (auto-complete-mode 1)
  (hs-minor-mode 1)
  (linum-mode 1)
  (hl-line-mode))
(add-hook 'web-mode-hook 'web-mode-additional)

