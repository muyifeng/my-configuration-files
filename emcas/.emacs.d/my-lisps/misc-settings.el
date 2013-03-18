(setq user-mail-address "muyifeng1988@gmail.com")
(setq user-full-name "Eric Yang")

(global-font-lock-mode t) ;syntax highlight

(auto-image-file-mode t) ;picture display

(fset 'yes-or-no-p 'y-or-n-p) ;simplify

(column-number-mode t) ;show column number

(setq ido-everywhere t)
(ido-mode t) ;turn on ido mode
(setq ido-enable-flex-matching t) ;turn fuzzy matching on
(add-hook 'ido-setup-hook
          (lambda ()
            (define-key ido-completion-map [tab] 'ido-complete)))

(show-paren-mode t) ;show parenthess

(tool-bar-mode 0) ;kill the toolbar

(scroll-bar-mode nil)

(mouse-avoidance-mode 'animate)

(setq mouse-yank-at-point t)

(transient-mark-mode t)

(setq x-select-enable-clipboard t)

(setq frame-title-format "eric@%b")

(setq default-fill-column 110)

(setq-default default-directory "~")

(setq-default indicate-buffer-boundaries 'left)

(setq echo-keystrokes 0.1)

(setq system-time-locale "C")

(customize-set-variable 'scroll-bar-mode nil)

(setq column-number-mode t)

(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

(blink-cursor-mode 1)

;; (setq scroll-margin 3
;;       scroll-conservatively 10000)

(setq ring-bell-function 'ignore)

(setq enable-recursive-minibuffers t)

(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)

(require 'saveplace)
(setq-default save-place t)

(setq kill-do-not-save-duplicates t)

(setq tab-always-indent 'complete)

;; Excellent package for better scrolling in emacs
;; should be default package. But now it can be downloaded
;; from http://user.it.uu.se/~mic/pager.el
(require 'pager)
(global-set-key "\C-v"     'pager-page-down)
(global-set-key [next] 	   'pager-page-down)
(global-set-key "\ev"	   'pager-page-up)
(global-set-key [prior]	   'pager-page-up)
(global-set-key '[M-up]    'pager-row-up)
(global-set-key '[M-kp-8]  'pager-row-up)
(global-set-key '[M-down]  'pager-row-down)
(global-set-key '[M-kp-2]  'pager-row-down)

;; vi emulation of the % command
(defun goto-match-paren (arg)
  "Go to the matching  if on (){}[], similar to vi style of % "
  (interactive "p")
  ;; first, check for "outside of bracket" positions expected by forward-sexp, etc.
  (cond ((looking-at "[\[\(\{]") (forward-sexp))
        ((looking-back "[\]\)\}]" 1) (backward-sexp))
        ;; now, try to succeed from inside of a bracket
        ((looking-at "[\]\)\}]") (forward-char) (backward-sexp))
        ((looking-back "[\[\(\{]" 1) (backward-char) (forward-sexp))
        (t nil)))
(global-set-key "\C-]" 'goto-match-paren)

;; comment/uncomment for global binding
(global-set-key "\C-c\C-c" 'comment-region)
(global-set-key "\C-c\C-u" 'uncomment-region)

;; enlarge the kill ring
(setq kill-ring-max 1000)
(require 'browse-kill-ring-settings)

;; tramp for remote file access
(require 'tramp)
(setq tramp-default-method "scp")

(require 'highlight-symbol)
(global-set-key "\C-ch" 'highlight-symbol-at-point)
(global-set-key "\C-cn" 'highlight-symbol-next)
(global-set-key "\C-cp" 'highlight-symbol-prev)
(global-set-key "\C-cr" 'highlight-symbol-query-replace)

;; cursor change mode
;; (require 'cursor-change)
;; (cursor-change-mode t)
;; set fly-on-spell
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(autoload 'flyspell-delay-command "flyspell" "Delay on command." t)
(autoload 'tex-mode-flyspell-verify "flyspell" "" t)
;(global-flyspell-mode)

(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))

(global-set-key [S-left] 'windmove-left)
(global-set-key [S-right] 'windmove-right)
(global-set-key [S-up] 'windmove-up)
(global-set-key [S-down] 'windmove-down)

(global-set-key "\C-xg" 'goto-line)
(global-set-key [S-f7] 'revert-buffer)
(global-set-key [f6] 'set-left-margin)
(global-set-key [f12] 'undo)

(defun isearch-occur ()
      "Invoke `occur' from within isearch."
      (interactive)
      (let ((case-fold-search isearch-case-fold-search))
        (occur (if isearch-regexp isearch-string (regexp-quote isearch-string)))))

(define-key isearch-mode-map (kbd "M-o") 'isearch-occur)
(defmacro bind (key fn)
  "shortcut for global-set-key"
  `(global-set-key (kbd ,key)
                   ;; handle unquoted function names and lambdas
                   ,(if (listp fn)
                        fn
                      `',fn)))
(defmacro cmd (name &rest body)
  "declare an interactive command without all the boilerplate"
  `(defun ,name ()
     ,(if (stringp (car body)) (car body))
     ;; tried (let (documented (stringp (first body))) but didn't know gensym and couldn't get it work, should be pissible
     (interactive)
     ,@(if (stringp (car body)) (cdr `,body) body)))
(cmd isearch-other-window
     ;; http://www.youtube.com/watch?v=e0Kj9eVn5bI&feature=BFa&list=UUlmUI0PnpT5q_B4TsGNtOAg&lf=plcp
     (save-selected-window
       (other-window 1)
       (isearch-forward)))
(bind "M-C-;" isearch-other-window)
(provide 'misc-settings)
