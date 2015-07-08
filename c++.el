;; http://barisyuksel.com/cppmode/.emacs
(auto-install 'auto-complete-c-headers 'yasnippet 'auto-complete 'flymake-google-cpplint 'flymake-cursor 'google-c-style 'cedet)

(require 'yasnippet)
(yas-global-mode 1)

(defun devmario:c/c++-ac()
	(require 'auto-complete)
	(require 'auto-complete-config)
	(ac-config-default)
	(require 'auto-complete-c-headers)
	(add-to-list 'ac-sources 'ac-source-c-headers)
	; gcc -xc++ -E -v -
	(add-to-list 'achead:include-directories '"/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include/c++/v1")
	(add-to-list 'achead:include-directories '"/usr/local/include")
	(add-to-list 'achead:include-directories '"/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/6.1.0/include")
	(add-to-list 'achead:include-directories '"/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include")
	(add-to-list 'achead:include-directories '"/usr/include"))

(add-hook 'c-mode-hook 'devmario:c/c++-ac)
(add-hook 'c++-mode-hook 'devmario:c/c++-ac)

; sudo pip install cpplint
(defun devmario:c/c++-flymake()
	(require 'flymake-google-cpplint)
	(custom-set-variables
	 ; whereis cpplint
	 '(flymake-google-cpplint-command "/usr/local/bin/cpplint"))
	(flymake-google-cpplint-load))

(add-hook 'c-mode-hook 'devmario:c/c++-flymake)
(add-hook 'c++-mode-hook 'devmario:c/c++-flymake)

(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

(defun devmario:c/c++-semantic()
	(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
	(add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
	(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
	(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode)
	(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)

	(semantic-mode 1)
	(add-to-list 'ac-sources 'ac-source-semantic))
(add-hook 'c-mode-common-hook 'devmario:c/c++-semantic)

;(global-ede-mode 1)
;(ede-cpp-root-project "my project" :file "~/temp.cpp"
;											:include-path '("~/inc"))


;https://www.youtube.com/watch?v=NjTCjqSZOAU
;http://tuhdo.github.io/c-ide.html

