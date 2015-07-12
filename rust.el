(auto-install 'rust-mode 'flymake-rust 'racer 'company)

(add-hook 'rust-mode-hook 'flymake-rust-load)

;; http://company-mode.github.io/

;; racer-rust-src-path는 "~"가 안먹음
(setq racer-rust-src-path "/Users/jangwonhee/Documents/rust/src")
;; https://github.com/phildawes/racer clone, build
(setq racer-cmd "~/Documents/racer/target/release/racer")
(add-to-list 'load-path "~/Documents/racer/editors/emacs")
(eval-after-load "rust-mode" '(require 'racer))

(add-hook 'rust-mode-hook
  '(lambda ()
     (racer-activate)
     (local-set-key (kbd "M-.") #'racer-find-definition)
     (local-set-key (kbd "TAB") #'racer-complete-or-indent)))

