(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")
  (load-file "~/.emacs.d/color-theme-6.6.0/color-theme-almost-monokai.el")
  (require 'color-theme)
  (eval-after-load "color-theme"
    '(progn
       (color-theme-initialize)
       (color-theme-tomorrow-night)))

;; (require 'birds-of-paradise-plus-theme)
;; (load-theme birds-of-paradise-plus t)

;; allow eshell handle ansi-color
(require 'ansi-color)
(require 'eshell)
(defun eshell-handle-ansi-color ()
  (ansi-color-apply-on-region eshell-last-output-start
                              eshell-last-output-end))
(add-to-list 'eshell-output-filter-functions 'eshell-handle-ansi-color)

(provide 'my-emacs-face-settings)
