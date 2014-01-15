;; This file contains my setup for web development
;; Eric Yang (muyifeng1988@gmail.com)

(require 'css-mode)
(add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))
(autoload 'css-mode "css-mode" nil t)

(require 'zencoding-mode)
(add-hook 'sgml-mode-hook 'zencoding-mode)
(require 'sws-mode)
(require 'jade-mode)
(require 'cursor-chg)
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))
(add-to-list 'auto-mode-alist '("\\.hamlc$" . haml-mode))
(provide 'my-webdev-settings)
