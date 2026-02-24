(live-add-pack-lib "company-mode")
(require 'company)

(global-company-mode t)

(setq company-idle-delay 0.2)
(setq company-minimum-prefix-length 2)
(setq company-show-quick-access t)
(setq company-tooltip-align-annotations t)
(setq company-dabbrev-downcase nil)
(setq company-dabbrev-ignore-case t)

;; Use company-capf as primary backend (works with cider, lsp, etc.)
(setq company-backends
      '(company-capf
        company-dabbrev-code
        company-keywords
        company-dabbrev))

;; Key bindings (mirrors the old auto-complete mappings)
(define-key company-active-map (kbd "C-M-n") 'company-select-next)
(define-key company-active-map (kbd "C-M-p") 'company-select-previous)
(define-key company-active-map "\t" 'company-complete-selection)
(define-key company-active-map (kbd "M-RET") 'company-show-doc-buffer)
(define-key company-active-map "\r" nil)
