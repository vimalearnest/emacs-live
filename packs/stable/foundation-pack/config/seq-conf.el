;; seq.el is bundled for Emacs < 25. On Emacs 25+, seq is built-in.
;; Loading the old bundled version on Emacs 30+ causes infinite recursion
;; between seq-subseq and cl-subseq.
(when (version< emacs-version "25")
  (live-add-pack-lib "seq")
  (require 'seq)
  (require 'seq-25))
