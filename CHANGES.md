# Emacs 30.1 Compatibility Changes

## Startup Error Fixes

### 1. `defmethod` removed in Emacs 30 (eieio-compat dropped)

**`packs/stable/power-pack/lib/marshal/marshal.el`**
- Replaced all `defmethod` with `cl-defmethod` throughout
- Removed `:static` qualifiers
- Changed `(obj nil)` type specializers to `(obj t)` for generic fallback dispatch
- In `marshal-defclass` macro: replaced `(marshal-get-marshal-info cls)` and `(marshal-get-type-info cls)` calls with direct `(get cls :marshal-info)` / `(get cls :type-info)` to avoid static dispatch on class symbols

**`packs/stable/power-pack/lib/gh/` (gh-api.el, gh-auth.el, gh-cache.el, gh-comments.el, gh-common.el, gh-gist.el, gh-issue-comments.el, gh-issues.el, gh-oauth.el, gh-orgs.el, gh-profile.el, gh-pull-comments.el, gh-pulls.el, gh-repos.el, gh-search.el, gh-url.el, gh-users.el, gh.el)**
- Replaced all 140 `defmethod` calls with `cl-defmethod`
- 4 `:static` methods in `gh-common.el` (`gh-object-read`, `gh-object-reader`, `gh-object-list-read`, `gh-object-list-reader`) expanded to dual instance + `(subclass gh-object)` specializer forms
- 1 `:static` method in `gh-gist.el` (`constructor`) converted to `(subclass gh-gist-gist-file)` specializer

**`packs/stable/power-pack/config/marshal-conf.el`**
- Removed `defmethod` compat macro (no longer needed after direct conversion above)

### 2. Eager macro-expansion failure (`excessive-lisp-nesting`) in Emacs 30

**`packs/stable/power-pack/lib/yasnippet/yasnippet.elc`** (created)
- Byte-compiled `yasnippet.el` (v0.12.2) to avoid Emacs 30's eager macro expansion hitting the nesting limit on large `cl-defstruct` forms

**`packs/stable/power-pack/lib/undo-tree/undo-tree.elc`** (created)
- Byte-compiled `undo-tree.el` for the same reason

### 3. `global-linum-mode` removed in Emacs 30

**`packs/stable/power-pack/lib/emacs-git-gutter/git-gutter.el`**
- Line 470: `global-linum-mode` → `(bound-and-true-p global-linum-mode)`
- Line 1024: `global-linum-mode` → `(bound-and-true-p global-linum-mode)`

### 4. `facemenu-menu` removed in Emacs 30

**`packs/stable/power-pack/lib/floobits/external/highlight.el`**
- Wrapped two `(easy-menu-add-item facemenu-menu ...)` calls with `(when (boundp 'facemenu-menu) ...)`

### 5. Bundled `seq.el` conflicts with Emacs 30 built-in

**`packs/stable/foundation-pack/config/seq-conf.el`**
- Old bundled `seq.el` (2014) defined `seq-subseq` calling `cl-subseq`, which in Emacs 30 calls `seq-subseq` back — infinite recursion
- Now only loads the bundled seq library when `(version< emacs-version "25")`; Emacs 25+ ships seq built-in

---

## Deprecation Warning Fixes

### 6. Obsolete `cl` package aliases (163 replacements across 35 files)

Replaced all obsolete cl aliases with their `cl-` prefixed equivalents:

| Old | New |
|-----|-----|
| `(loop` | `(cl-loop` |
| `(incf` | `(cl-incf` |
| `(decf` | `(cl-decf` |
| `(ecase` | `(cl-ecase` |
| `(assert` | `(cl-assert` |
| `(pushnew` | `(cl-pushnew` |
| `(letf` | `(cl-letf` |
| `(flet` | `(cl-flet` |
| `(return-from` | `(cl-return-from` |
| `(return` | `(cl-return` |
| `(multiple-value-bind` | `(cl-multiple-value-bind` |
| `(symbol-macrolet` | `(cl-symbol-macrolet` |
| `(destructuring-bind` | `(cl-destructuring-bind` |
| `(defun*` | `(cl-defun` |
| `(callf` | `(cl-callf` |
| `(labels` | `(cl-labels` |
| `(case` | `(cl-case` |
| `(do` | `(cl-do` |

**Files modified:**
- `lib/live-core.el`
- `packs/stable/clojure-pack/config/highlight-flash-conf.el`
- `packs/stable/clojure-pack/lib/auto-complete/auto-complete.el`
- `packs/stable/clojure-pack/lib/cider-eval-sexp-fu/cider-eval-sexp-fu.el`
- `packs/stable/clojure-pack/lib/cider/cider-debug.el`
- `packs/stable/clojure-pack/lib/cider/cider-macroexpansion.el`
- `packs/stable/clojure-pack/lib/cider/cider-mode.el`
- `packs/stable/clojure-pack/lib/cider/cider-popup.el`
- `packs/stable/clojure-pack/lib/cider/cider-test.el`
- `packs/stable/clojure-pack/lib/cider/nrepl-client.el`
- `packs/stable/clojure-pack/lib/clj-refactor/clj-refactor.el`
- `packs/stable/clojure-pack/lib/eval-sexp-fu/eval-sexp-fu.el`
- `packs/stable/clojure-pack/lib/fuzzy-el/fuzzy.el`
- `packs/stable/clojure-pack/lib/inflections.el`
- `packs/stable/clojure-pack/lib/mic-paren.el`
- `packs/stable/clojure-pack/lib/uuid/uuid.el`
- `packs/stable/foundation-pack/lib/ibuffer-git/ibuffer-git.el`
- `packs/stable/foundation-pack/lib/popwin/popwin.el`
- `packs/stable/foundation-pack/lib/window-number.el`
- `packs/stable/lang-pack/lib/actionscript-mode/actionscript-config.el`
- `packs/stable/lang-pack/lib/actionscript-mode/actionscript-mode.el`
- `packs/stable/lang-pack/lib/ruby-mode/ruby-mode.el`
- `packs/stable/lang-pack/lib/scel/sclang-help.el`
- `packs/stable/lang-pack/lib/scel/sclang-interp.el`
- `packs/stable/lang-pack/lib/scel/sclang-language.el`
- `packs/stable/lang-pack/lib/scel/sclang-mode.el`
- `packs/stable/lang-pack/lib/scel/sclang-server.el`
- `packs/stable/lang-pack/lib/scel/sclang-widgets.el`
- `packs/stable/org-pack/lib/org-mode/lisp/org-compat.el`
- `packs/stable/org-pack/lib/org-mode/lisp/org-src.el`
- `packs/stable/org-pack/lib/org-mode/lisp/org-table.el`
- `packs/stable/org-pack/lib/org-mode/lisp/org.el`
- `packs/stable/power-pack/lib/ace-jump-mode/ace-jump-mode.el`
- `packs/stable/power-pack/lib/browse-kill-ring/browse-kill-ring.el`
- `packs/stable/power-pack/lib/emacs-git-gutter/git-gutter.el`
- `packs/stable/power-pack/lib/expand-region/ruby-mode-expansions.el`
- `packs/stable/power-pack/lib/gh/gh-api.el`
- `packs/stable/power-pack/lib/gh/gh-profile.el`
- `packs/stable/power-pack/lib/gh/gh-url.el`
- `packs/stable/power-pack/lib/gist/gist.el`
- `packs/stable/power-pack/lib/multiple-cursors/mc-cycle-cursors.el`
- `packs/stable/power-pack/lib/multiple-cursors/mc-hide-unmatched-lines-mode.el`
- `packs/stable/power-pack/lib/multiple-cursors/multiple-cursors-core.el`
- `packs/stable/power-pack/lib/multiple-cursors/rectangular-region-mode.el`
- `packs/stable/power-pack/lib/mwe-log-commands.el`
- `packs/stable/power-pack/lib/volatile-highlights/volatile-highlights.el`

---

## Dev Pack Updates

### Switch to dev packs

**`~/.emacs-live.el`**
- Added `(live-use-dev-packs)` to load all packs from `packs/dev/` instead of `packs/stable/`

### Dev Power-Pack: excessive-lisp-nesting fix

**`packs/dev/power-pack/vendor/submodules/yasnippet/yasnippet.elc`** (created)
- Byte-compiled latest yasnippet to avoid Emacs 30's eager macro expansion nesting limit

**`packs/dev/power-pack/vendor/submodules/undo-tree/undo-tree.elc`** (created)
- Byte-compiled `undo-tree.el` (v0.8.2) for the same reason
- Required `queue.el` from `packs/dev/foundation-pack/lib/` during compilation

### Dev Clojure-Pack: Replace auto-complete/ac-cider with company-mode

**Motivation**: ac-cider is abandoned; modern cider (1.22+) uses `completion-at-point-functions` (capf) natively, which company-mode's `company-capf` backend integrates with automatically.

**Removed**:
- `ac-cider` submodule and lib symlink
- `auto-complete`, `fuzzy-el`, `popup-el` lib symlinks (no longer needed)
- `auto-complete-conf.el` loading from `init.el`
- ac-cider setup hooks from `cider-conf.el`
- Obsolete `cider-popup-stacktraces` / `cider-popup-stacktraces-in-repl` vars (removed in cider 1.22)

**Added**:
- `company-mode` submodule (`https://github.com/company-mode/company-mode.git`)
- `parseedn` submodule (`https://github.com/clojure-emacs/parseedn.git`) — cider 1.22 dependency
- `parseclj` submodule (`https://github.com/clojure-emacs/parseclj.git`) — parseedn dependency
- `sesman` submodule (`https://github.com/vspinu/sesman.git`) — cider 1.22 dependency
- `company-conf.el` — configures `company-mode` globally with `company-capf` as primary backend
- Updated `cider-conf.el` to add `parseclj`, `parseedn`, `sesman`, `cider/lisp` to load-path

**Files modified**:
- `packs/dev/clojure-pack/init.el` — load `company-conf.el` instead of `auto-complete-conf.el`
- `packs/dev/clojure-pack/config/cider-conf.el` — removed ac-cider, added new dep load-path entries
- `packs/dev/clojure-pack/config/company-conf.el` (created)

### Dev Pack Config Updates: lisp/ subdirectory paths and new dependencies

Several updated submodules moved their `.el` files into a `lisp/` subdirectory (following magit's convention). `live-add-pack-lib` calls updated accordingly.

**`packs/dev/foundation-pack/init.el`**
- `with-editor` → `with-editor/lisp`

**`packs/dev/git-pack/config/ghub-conf.el`**
- `ghub` → `ghub/lisp`
- Added `cond-let`, `llama`, `treepy` to load-path (ghub 5.0 dependencies)

**`packs/dev/git-pack/init.el`**
- Removed `magit-popup-conf.el` — magit 4.5 uses `transient` (built-in to Emacs 30) instead of magit-popup

**New submodules added to `packs/dev/git-pack/vendor/submodules/`**:
- `cond-let` (`https://github.com/tarsius/cond-let.git`)
- `llama` (`https://github.com/tarsius/llama.git`)
- `treepy` (`https://github.com/volrath/treepy.el.git`)

---

## Remaining Warnings (not yet fixed)

- `defadvice` (42 occurrences) — requires conversion to `advice-add`/`define-advice`
- `define-minor-mode` positional args (12 occurrences) — requires adding keyword arguments
- `preceding-sexp` → `elisp--preceding-sexp` (3 occurrences in eval-sexp-fu)
- `with-demoted-errors` missing format arg (3 occurrences in org.el, cider-mode.el)
- Quoted `cl-case` clauses in `browse-kill-ring.el` (6 occurrences)
