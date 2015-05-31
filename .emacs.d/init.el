;라인넘버 켜기
(global-linum-mode 1)

;package 서버 셋팅
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
      ("marmalade" . "https://marmalade-repo.org/packages/")
      ("melpa" . "http://melpa.org/packages/")))

;neotree
(global-set-key [f8] 'neotree-toggle)
(global-set-key [f9] 'neotree-show)

(global-set-key [f10] 'eshell)
