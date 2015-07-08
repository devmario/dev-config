(auto-install 'auto-complete 'yasnippet 'flymake 'flycheck)

;; ac elisp
(require 'auto-complete)
(defun emacs-lisp-additional ()
  (setq ac-sources '(ac-source-functions
                     ac-source-variables
                     ac-source-features
                     ac-source-symbols
                     ac-source-words-in-same-mode-buffers))
  (add-to-list 'ac-modes 'emacs-lisp-mode)
  (auto-complete-mode 1)
  (hs-minor-mode 1))
(add-hook 'emacs-lisp-mode-hook 'emacs-lisp-additional)
(add-to-list 'auto-mode-alist '("\\.el\\'" . emacs-lisp-mode))

;; flymake emacs lisp
(require 'flymake)
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
