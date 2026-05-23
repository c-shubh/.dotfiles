;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!
(setq doom-font (font-spec :family "DejaVu SansM Nerd Font Propo"))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents")
(setq org-log-into-drawer t)
(defun my/org-set-created-property ()
  "Set CREATED property to current timestamp, unless it already exists."
  (interactive)
  (unless (org-entry-get nil "CREATED")
    (org-set-property "CREATED"
                      (format-time-string (concat "[" (cdr org-time-stamp-formats) "]")))))
(defun my/org-sort-by-created-then-todo ()
  "Sort children of current heading: first by CREATED property, then by TODO keyword order."
  (interactive)
  ;; Sort by property CREATED, reverse (capital R) = newest first
  (org-sort-entries nil ?R nil nil "CREATED")
  ;; Then sort by TODO order (lowercase o) = built-in keyword order
  (org-sort-entries nil ?o))
(after! org
  (setq org-default-notes-file (concat org-directory "/life.org"))
  ;; modified from https://github.com/doomemacs/doomemacs/blob/c2ff579a28ecfec90c343417bc04b2a9569d9ed7/modules/lang/org/config.el#L157
  (setq org-todo-keywords
        '((sequence
           "STRT(s!)"    ; A task that is in progress
           "NEXT(n!)"    ; A task that I'll work on next
           "TODO(t!)"    ; A task that needs doing & is ready to do
           "WAIT(w!)"    ; Something external is holding up this task
           "MAYB(m!)"    ; A task that I'll maybe work on someday
           "|"
           "CNCL(c!)"    ; Task was cancelled, aborted, or is no longer applicable
           "DONE(d!)"))) ; Task successfully completed
  (setq org-todo-keyword-faces
        '(("STRT" . +org-todo-active)
          ("NEXT" . +org-todo-active)
          ("WAIT" . +org-todo-onhold)
          ("MAYB" . +org-todo-onhold)
          ("CNCL" . +org-todo-cancel)))
  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline org-default-notes-file "Tasks")
           "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:")))
  (add-hook 'org-after-todo-state-change-hook #'my/org-set-created-property)
  (add-hook! 'org-mode-hook :append
    ;; turn off word wrap
    (visual-line-mode -1)
    (setq-local truncate-lines t)))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
