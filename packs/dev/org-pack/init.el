;; Org mode pack init file -*- lexical-binding: t; -*-
;;

;; org.el loads org-loaddefs from its own directory (org-mode/lisp/).
;; That file is gitignored in the submodule, so after a fresh clone it won't
;; exist. Copy the tracked version from the pack's lib dir if needed.
(let* ((lib-dir (live-pack-lib-dir))
       (source (concat lib-dir "org-loaddefs.el"))
       (target (concat lib-dir "org-mode/lisp/org-loaddefs.el")))
  (when (and (file-exists-p source) (not (file-exists-p target)))
    (copy-file source target)))

(require 'org-version)
(require 'org-loaddefs)
(live-load-config-file "org-mode-config.el")
