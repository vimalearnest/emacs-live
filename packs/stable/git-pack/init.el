;;; git-pack/init.el
(live-add-pack-lib "git-modes")
(require 'gitattributes-mode)
(require 'gitconfig-mode)
(require 'gitignore-mode)

(live-load-config-file "ghub-conf.el")
(live-load-config-file "magit-popup-conf.el")
(live-load-config-file "magit-conf.el")
