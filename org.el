(defun devmario::publish-org ()
  (interactive)
  (org-html-export-to-html)
  (shell-command (concat devmario::rootDir "publish_devmario_org.sh")))

(defun itunes::next ()
  (interactive)
  (shell-command (concat devmario::rootDir "bash-itunes/itunes next")))

(defun itunes::prev ()
  (interactive)
  (shell-command (concat devmario::rootDir "bash-itunes/itunes prev")))

