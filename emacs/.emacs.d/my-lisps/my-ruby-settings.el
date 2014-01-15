;; Time-stamp: <2012-09-02 13:16:54 Sunday by tyraeltong>

;; (add-to-list 'load-path "~/.emacs.d/cedet-1.0")
;; (load-file "~/.emacs.d/cedet-1.0/common/cedet.el")

;; (add-to-list 'load-path "~/.emacs.d/ecb-2.40/")
;; (require 'ecb)
;; (require 'ecb-autoloads)

(defalias 'irb 'run-ruby)

(font-lock-add-keywords 'ruby-mode '(("\\<require\\>" . font-lock-keyword-face)))

;; (eal-define-keys-commonly
;;  global-map
;;  `(("C-x r" run-ruby)
;;    ("C-x R" ri)))

(autoload 'run-ruby
  "Run an inferior Ruby process, input and output via buffer *ruby*.
If there is a process already running in `*ruby*', switch to that buffer.
With argument, allows you to edit the command line (default is value
of `ruby-program-name').  Runs the hooks `inferior-ruby-mode-hook'
\(after the `comint-mode-hook' is run).
\(Type \\[describe-mode] in the process buffer for a list of commands.)" t)

(autoload 'ri "ri-ruby"
  "Execute `ri'." t)

(defun ruby-settings ()
  "Settings for `ruby'."
  (defun complete-or-indent-for-ruby (arg)
    (interactive "P")
    (complete-or-indent arg nil 'ruby-indent-command))

  (eal-define-keys
   'ruby-mode-map
   `(("{"       self-insert-command)
     ;; ("TAB"     complete-or-indent-for-ruby)
     ;; ("C-j"     goto-line)
     ;; ("C-c C-c" comment)
     ("}"       self-insert-command)))

  (defun ruby-keys ()
    "Ruby keys definition."
    (local-set-key (kbd "<return>") 'newline-and-indent))
  (add-hook 'ruby-mode-hook
            (lambda ()
              (setq ruby-indent-level 2)
              (ruby-electric-mode nil)
              (autopair-mode 0)
              (ruby-keys)) t)

  (defun ruby-mark-defun ()
    "Put mark at end of this Ruby function, point at beginning."
    (interactive)
    (push-mark (point))
    (ruby-end-of-defun)
    (push-mark (point) nil t)
    (ruby-beginning-of-defun))

  (setq ri-ruby-script (concat my-emacs-lisps-path "ri-emacs.rb"))
  (setq ri-ruby-script "/home/ahei/emacs/lisps/ri-emacs.rb"))

(eval-after-load "ruby-mode"
  `(ruby-settings))

;;; enables outlining for ruby
;;; You may also want to bind hide-body, hide-subtree, show-substree,
;;; show-all, show-children, ... to some keys easy folding and unfolding
(add-hook 'ruby-mode-hook
              '(lambda ()
                 (outline-minor-mode)
                 (setq outline-regexp " *\\(def \\|class\\|module\\)")))

(add-hook 'coffee-mode-hook
          '(lambda()
             (outline-minor-mode)
             (setq outline-regexp " *\\(def \\|class\\|module\\|->\\|=>)")))

;; rinari
(require 'rinari)

(add-to-list 'load-path "~/.emacs.d/ruby-rails/rhtml-mode/")
(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
          (lambda () (rinari-launch)))

;; yasnippet for rails
;; (add-to-list 'load-path "~/.emacs.d/emacs-starter-kit/elpa/yasnippet-bundle-0.6.1")
;; (load "~/.emacs.d/ruby-rails/yasnippets-rails/setup.el")

;; feature mode
(require 'feature-mode)
(add-to-list 'auto-mode-alist '("\.features$" . feature-mode))

;;(setq load-path (cons "~/.emacs.d/ruby-rails/js2-mode" load-path))
;;(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; (autoload 'espresso-mode "espresso" nil t)
;; (setq js2-bounce-indent-p t)

;; emacs-rails-reload mode
;; (setq load-path (cons (expand-file-name "~/.emacs.d/ruby-rails/emacs-rails-reloaded") load-path))
;; (require 'rails-autoload)

(add-to-list 'load-path "~/.emacs.d/ruby-rails/")
;(require 'flymake-ruby)
;(add-hook 'ruby-mode-hook 'flymake-ruby-load)

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; (load "~/.emacs.d/nxhtml/autostart.el")
;; (add-to-list 'auto-mode-alist
;;              '("\\.rhtml$" . kid-rhtml-mode))
;; ;; only special background in submode
;; (setq mumamo-chunk-coloring 'submode-colored)
;; (setq nxhtml-skip-welcome t)

;; ;; do not turn on rng-validate-mode automatically, I don't like
;; ;; the anoying red underlines
;; (setq rng-nxml-auto-validate-flag nil)

;; ;; force to load another css-mode, the css-mode in nxml package
;; ;; seems failed to load under my Emacs 23
;; (let ((load-path (cons "~/emacs/extension/"
;;                        load-path)))
;;   (require 'css-mode))

;; (defun kid-rhtml-mode ()
;;   (nxhtml-mode)
;;   ;; I don't use cua-mode, but nxhtml always complains. So, OK, let's
;;   ;; define this dummy variable
;;   (make-local-variable 'cua-inhibit-cua-keys)
;;   (setq mumamo-current-chunk-family '("eRuby nXhtml Family" nxhtml-mode
;;                                       (mumamo-chunk-eruby
;;                                        mumamo-chunk-inlined-style
;;                                        mumamo-chunk-inlined-script
;;                                        mumamo-chunk-style=
;;                                        mumamo-chunk-onjs=)))
;;   (mumamo-mode)
;;   (rails-minor-mode t)
;;   (auto-fill-mode -1)
;;   (setq tab-width 2)
;;   (setq indent-tabs-mode nil))
;; (setq
;;  nxhtml-global-minor-mode t
;;  mumamo-chunk-coloring 'submode-colored
;;  nxhtml-skip-welcome t
;;  indent-region-mode t
;;  rng-nxml-auto-validate-flag nil
;;  nxml-degraded t)
;; (add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-nxhtml-mumamo))


;; (add-to-list 'load-path "~/.emacs.d/jade-mode")
;; (require 'sws-mode)
;; (require 'jade-mode)
;; (add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
;; (add-to-list 'auto-mode-alist '("\\.jade$" . sws-mode))

(require 'rvm)
(rvm-use-default)

(require 'textmate)
(textmate-mode)

(require 'slim-mode)
(add-to-list 'auto-mode-alist '("\\.skim$" . slim-mode))

;; (add-hook 'ruby-mode-hook 'ri-bind-key)
(provide 'my-ruby-settings)
