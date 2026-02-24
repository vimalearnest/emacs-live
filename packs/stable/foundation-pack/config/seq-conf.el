;; Only load the bundled seq library on Emacs < 25.
;; Emacs 25+ ships seq built-in, and the old bundled seq-subseq calls cl-subseq
;; which in Emacs 30 calls seq-subseq back, causing infinite recursion.
(when (version< emacs-version "25")
  (live-add-pack-lib "seq")
  (require 'seq)
  (require 'seq-25))
