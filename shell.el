(auto-install 'eshell 'exec-path-from-shell 'auto-complete)

;; exec-path-from-shell

;; This sets $MANPATH, $PATH and exec-path from your shell, but only on OS X.
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; customizing
;; (exec-path-from-shell-copy-env "PYTHONPATH")

;; help
;; C-h f exec-path-from-shell-initialize
;; C-h f exec-path-from-shell-copy-env


;; http://emacswiki.org/emacs/EshellCompletion

;; Eshell offers you completion of filenames. If several filenames are possible, the most recently modified file will be used first.
(setq eshell-cmpl-compare-entry-function
	  (function
	   (lambda (left right)
		 (let ((exts completion-ignored-extensions) found)
		   (while exts
			 (if (string-match (concat "\\" (car exts) "$") right)
				 (setq found t exts nil))
			 (setq exts (cdr exts)))
		   (if found
			   nil
			 (file-newer-than-file-p left right))))))

(defadvice pcomplete (around avoid-remote-connections activate)
  (let ((file-name-handler-alist (copy-alist file-name-handler-alist)))
	(setq file-name-handler-alist
		  (delete (rassoc 'tramp-completion-file-name-handler
						  file-name-handler-alist) file-name-handler-alist))
	ad-do-it))

(setq eshell-prompt-function
 	  (lambda ()
 		(concat "" (eshell/pwd) " "
 				(if (= (user-uid) 0) "# " "$ "))))

;; (setq eshell-prompt-function
;;	  (lambda ()
;;		(concat "[" (format "%s" (first (last (split-string (eshell/pwd) "/" t)))) "]$")))

(setq eshell-prompt-regexp "^[^#$\n]*[#$] ")


(add-hook 'eshell-mode-hook
		  '(lambda () (define-key eshell-mode-map "\t" 'pcomplete-list)))

(setq eshell-cmpl-cycle-completions nil)


;; TODO 명령어 중간에 '치고 다른거치고'닫은 곳에 커서가서 치면 에러남
;; TODO emacs24.3 cl-flet to flet
(defun ac-pcomplete ()
  ;; eshell uses `insert-and-inherit' to insert a \t if no completion
  ;; can be found, but this must not happen as auto-complete source
  (cl-flet ((insert-and-inherit (&rest args)))
    ;; this code is stolen from `pcomplete' in pcomplete.el
    (let* (tramp-mode ;; do not automatically complete remote stuff
           (pcomplete-stub)
           (pcomplete-show-list t) ;; inhibit patterns like * being deleted
           pcomplete-seen pcomplete-norm-func
           pcomplete-args pcomplete-last pcomplete-index
           (pcomplete-autolist pcomplete-autolist)
           (pcomplete-suffix-list pcomplete-suffix-list)
           (candidates (pcomplete-completions))
           (beg (pcomplete-begin))
           ;; note, buffer text and completion argument may be
           ;; different because the buffer text may bet transformed
           ;; before being completed (e.g. variables like $HOME may be
           ;; expanded)
           (buftext (buffer-substring beg (point)))
           (arg (nth pcomplete-index pcomplete-args)))
      ;; we auto-complete only if the stub is non-empty and matches
      ;; the end of the buffer text
      (when (and (not (zerop (length pcomplete-stub)))
                 (or (string= pcomplete-stub ; Emacs 23
                              (substring buftext
                                         (max 0
                                              (- (length buftext)
                                                 (length pcomplete-stub)))))
                     (string= pcomplete-stub ; Emacs 24
                              (substring arg
                                         (max 0
                                              (- (length arg)
                                                 (length pcomplete-stub)))))))
        ;; Collect all possible completions for the stub. Note that
        ;; `candidates` may be a function, that's why we use
        ;; `all-completions`.
        (let* ((cnds (all-completions pcomplete-stub candidates))
               (bnds (completion-boundaries pcomplete-stub
                                            candidates
                                            nil
                                            ""))
               (skip (- (length pcomplete-stub) (car bnds))))
          ;; We replace the stub at the beginning of each candidate by
          ;; the real buffer content.
          (mapcar #'(lambda (cand) (concat buftext (substring cand skip)))
                  cnds))))))

(defvar ac-source-pcomplete
  '((candidates . ac-pcomplete)))

(add-hook 'eshell-mode-hook #'(lambda () (setq ac-sources '(ac-source-pcomplete))))
(add-to-list 'ac-modes 'eshell-mode)

(add-hook 'eshell-mode-hook 'auto-complete-mode)

(message "DONE")
