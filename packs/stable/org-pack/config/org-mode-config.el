;; org mode config -*- lexical-binding: t; -*-

(live-add-pack-lib "org-mode/lisp")
(live-add-pack-lib "org-mode/contrib/lisp")

;; set ODT data directory to emacs-live's org-mode
(setq org-odt-data-dir (expand-file-name "./org-mode/etc" (live-pack-lib-dir)))

;; Fix conflicts (http://orgmode.org/org.html#Conflicts)

;; windmove compatibility
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)

;; Yasnippet compatibility
(defun yas-org-very-safe-expand ()
  (let ((yas-fallback-behavior 'return-nil)) (yas-expand)))

(add-hook 'org-mode-hook
          (lambda ()
            (add-to-list 'org-tab-first-hook 'yas-org-very-safe-expand)
            (define-key yas-keymap [tab] 'yas-next-field)))

(require 'org)
