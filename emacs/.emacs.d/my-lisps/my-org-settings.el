;; org mode setup
;; org-mode

;; Why doesn't C-c a call the agenda? Why don't some org keybindings work?
;; Org-mode has a few global keybindings that the user must set explicitly in an .emacs file. These keybindings include the customary shortcut for calling the agenda (C-c a). If nothing happens when you type C-c a, then make sure that the following lines are in your .emacs file:
(require 'org-install)
(require 'org-habit)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-log-done 'time)
(setq org-log-done 'note)
(global-hl-line-mode 1)
(setq-default indent-tabs-mode nil)
(setq make-backup-files nil)
(setq auto-fill-mode 1)

(autoload 'org-agenda "org" "Multi-file agenda from Org mode" t)

(require 'org-capture)
(setq org-default-notes-file "~/org/notes.org")

(define-key global-map "\C-cc" 'org-capture)
(setq org-capture-templates
      '(("t" "TODO" entry (file+headline "~/org/notes.org" "Tasks")
         "* TODO %?\n %i\n %a")
        ("h" "Thoughts" entry (file+headline "~/org/thoughts.org" "Thoughts")
         "* %?\n %i\n %a")
        ))
(setq org-todo-keywords
      '((sequence "TODO(t)" "INPROGRESS(i@/!)" "VERIFY(v@/!)" "|" "DONE(d@/!)" "COMPLETED(c@/!)" "DELEGATED(l)")))

(add-hook 'org-mode-hook
          (lambda () (setq truncate-lines nil)))

;; org-mobile setup
(setq org-directory "~/org")
(setq org-mobile-inbox-for-pull "~/org/flagged.org")
(setq org-mobile-directory "~/Dropbox/MobileOrg")

;;; integrate ido with artist-mode
(defun artist-ido-select-operation (type)
  "Use ido to select a drawing operation in artist-mode"
  (interactive (list (ido-completing-read "Drawing operation: "
                                         (list "Pen" "Pen Line" "line" "straight line" "rectangle"
                                               "square" "poly-line" "straight poly-line" "ellipse"
                                               "circle" "text see-thru" "text-overwrite" "spray-can"
                                               "erase char" "erase rectangle" "vaporize line" "vaporize lines"
                                               "cut rectangle" "cut square" "copy rectangle" "copy square"
                                               "paste" "flood-fill"))))
  (artist-select-operation type))
(defun artist-ido-select-settings (type)
  "Use ido to select a setting to change in artist-mode"
  (interactive (list (ido-completing-read "Setting: "
                                          (list "Set Fill" "Set Line" "Set Erase" "Spray-size" "Spray-chars"
                                                "Rubber-banding" "Trimming" "Borders"))))
  (if (equal type "Spray-size")
    (artist-select-operation "spray set size")
    (call-interactively (artist-fc-get-fn-from-symbol
    (cdr (assoc type '(("Set Fill" . set-fill)
		       ("Set Line" . set-line)
		       ("Set Erase" . set-erase)
		       ("Rubber-banding" . rubber-band)
		       ("Trimming" . trimming)
		       ("Borders" . borders)
		       ("Spray-chars" . spray-chars))))))))
(add-hook 'artist-mode-init-hook
   (lambda ()
     (define-key artist-mode-map (kbd "C-c C-a C-o") 'artist-ido-select-operation)
     (define-key artist-mode-map (kbd "C-c C-a C-c") 'artist-ido-select-settings)))

(require 'org-exp-blocks)

(setq org-ditaa-jar-path "~/tools/ditaa0_9.jar")

(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((ditaa . t)
   (emacs-lisp . t)
   (ruby . t)
   (R . t)
   (python . t)
   (clojure . t)
   (dot . t)
   (sh . t)))

(setq view-diary-entries-initially t
      mark-diary-entries-in-calendar t
      number-of-diary-entries 7)
(add-hook 'diary-display-hook 'fancy-diary-display)
(add-hook 'today-visible-calendar-hook 'calendar-mark-today)

(setq appt-audible (cons 3 .5)
      appt-display-duration 59
      appt-display-mode-line t
      appt-msg-countdown-list '(10 0))

(setq org-agenda-include-diary t)
;; org to appt
;;(appt-activate 1)
;(org-agenda)
(org-agenda-to-appt)

; Do not prompt to confirm evaluation
; This may be dangerous - make sure you understand the consequences
; of setting this -- see the docstring for details
(setq org-confirm-babel-evaluate nil)

(provide 'my-org-settings)
