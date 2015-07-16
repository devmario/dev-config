(defun devmario::publish-org ()
  (interactive)
  (org-html-export-to-html)
  (shell-command (concat devmario::rootDir "publish_devmario_org.sh")))

