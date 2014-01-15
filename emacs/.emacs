;; Time-stamp: <2013-10-31 17:25:34 Thursday by ericyang>
(message "-------start my .emacs")
(server-start)
(set-face-attribute 'default nil :height 140 :family "DejaVu Sans Mono" :weight 'Light)
(setq-default tab-width 2)
(add-to-list 'load-path "~/.emacs.d")
(defconst my-emacs-path "~/.emacs.d/" "my emacs configuration files path")
(defconst my-emacs-my-lisps-path (concat my-emacs-path "my-lisps/") "my own lisp files")
(defconst my-emacs-lisps-path (concat my-emacs-path "lisps/") "my downloaded lisp files")
;;(defconst my-emacs-templates-path (concat my-emacs-path "templates/") "my templates")
;; (defconst my-elpa-path (concat my-emacs-path "elpa"))

(load (concat my-emacs-my-lisps-path "my-subdirs"))
;; (my-add-subdirs-to-load-path my-elpa-path)
(my-add-subdirs-to-load-path my-emacs-lisps-path)
(my-add-subdirs-to-load-path my-emacs-my-lisps-path)

(setq backup-inhibited t)
(setq auto-save-default nil)

(require 'package)
(package-initialize)

(require 'eval-after-load)
(require 'util)
(require 'ahei-misc)
(require 'coding-settings)
(require 'misc-settings)
(require 'my-mac-settings)
(require 'my-emacs-face-settings)
(require 'my-org-settings)
(require 'my-ruby-settings)
(require 'my-webdev-settings)
(require 'my-auto-complete-settings)
(require 'time-stamp-settings)
(require 'browse-kill-ring-settings)
(require 'autopair-settings)
;; (require 'rect-mark-settings)

(require 'dirtree)
(require 'tree-mode)
(require 'windata)
(autoload 'dirtree "dirtree" "Add directory to tree view" t)
(global-set-key "\C-d" 'dirtree-show)

(require 'package)
(message "start init packages")
;; (package-initialize)
;; (message "init packages end")

;; (require 'ascii)
(require 'hexview-mode)

;; change to use elpa
(require 'undo-tree)
(global-undo-tree-mode t)

;; change to use elpa
(require 'fuzzy)
(turn-on-fuzzy-isearch)

;; this fancy, but not very useful
;; (require 'highlight-tail)
;; (highlight-tail-mode)

;; Comment out, there're some format issue
;; (load-file "~/.emacs.d/online-search.el")
;; (global-set-key [(control c) (s)] 'online-search)
;; (setq is-plaintext-enable 't)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(require 'coffee-mode)
(defun coffee-custom()
  "coffee-mode-hook"
  (set (make-local-variable 'tab-width) 2))
(add-hook 'coffee-mode-hook
          '(lambda() (coffee-custom)))
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("\\.Cakefile" . coffee-mode))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq mac-option-modifier 'super)

(global-set-key [(meta =)] 'text-scale-increase)
(global-set-key [(meta +)] 'text-scale-decrease)

(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.run$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))

;; (require 'all-buffer-settings)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode t)
 '(column-number-mode t)
 '(css-indent-level 2)
 '(display-time-mode nil)
 '(inhibit-startup-screen t)
 '(js-indent-level 2)
 '(js2-basic-offset 2)
 '(js2-cleanup-whitespace t)
 '(js2-electric-keys (quote nil))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(sml/hidden-modes (quote (" hl-p" " ErgoEmacs" " Undo-Tree")))
 '(sml/show-time t)
 '(tool-bar-mode nil))

(global-linum-mode t)
(setenv "ERGOEMACS_KEYBOARD_LAYOUT" "us") ; US
(load "~/.emacs.d/ergoemacs-keybindings-5.3.9/ergoemacs-mode")
(ergoemacs-mode 1)
;; reset ctrl+f to grep-find. ergoemacs set it to search-forward, which is not suitable for me
(global-set-key [(ctrl f)] 'grep-find)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'expand-region)
(global-set-key [(meta 2)] 'er/expand-region)

(global-set-key [(meta t)] 'textmate-goto-file)
(global-set-key [(meta T)] 'textmate-goto-symbol)

;; mark
(when (require 'auto-mark nil t)
  (setq auto-mark-command-class-alist
        '((anything . anything)
          (goto-line . jump)
          (indent-for-tab-command . ignore)
          (undo . ignore)))
  (setq auto-mark-command-classifiers
        (list (lambda (command)
                (if (and (eq command 'self-insert-command)
                         (eq last-command-char ? ))
                    'ignore))))
  (global-auto-mark-mode 1))
;; visible mark mode
(require 'visible-mark)
(visible-mark-mode t)
(global-visible-mark-mode t)

;; add ack into execute path
(setq exec-path (append exec-path '("/usr/local/bin/")))

;; Create shorter aliases
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)

;; scss mode
(add-to-list 'load-path (expand-file-name "~/.emacs.d/scss-mode"))
(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
(add-to-list 'ac-modes 'coffee-mode)
(add-to-list 'ac-modes 'jade-mode)

;; markdown mode
(autoload 'markdown-mode "markdown-mode")
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; compile using marked.app
(defun markdown-preview-file ()
  "run Marked on the current file and revert the buffer"
  (interactive)
  (shell-command
   (format "open -a /Applications/Marked.app %s"
           (shell-quote-argument (buffer-file-name))))

)

(global-set-key "\C-cm" 'markdown-preview-file)

;; code folding
(require 'fold-dwim)
(global-set-key (kbd "M-9") 'fold-dwim-toggle)

;; helm, formerly anything
(require 'helm-config)
;;(helm-mode 1)
(global-set-key (kbd "M-F") 'helm-for-files)

(add-to-list 'hs-special-modes-alist
	     '(ruby-mode
	       "\\(def\\|do\\|{\\)" "\\(end\\|end\\|}\\)" "#"
	       (lambda (arg) (ruby-end-of-block)) nil))

;; tweak for ergoemacs keybinding & helm
(add-hook 'helm-before-initialize-hook #'(lambda() (ergoemacs-mode 0)))
(add-hook 'helm-cleanup-hook #'(lambda() (ergoemacs-mode 1)))

;; looks like sml from elpa doesn't autoload
(require 'smart-mode-line)
(sml/setup)

; capitalize region
(global-set-key (kbd "C-x C-c") 'capitalize-region)

;; iedit mode
(global-set-key (kbd "C-;") 'iedit-mode)

; ace jump mode
(global-set-key (kbd "C-\\") 'ace-jump-mode)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(put 'upcase-region 'disabled nil)
