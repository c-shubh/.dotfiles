;;; -*- lexical-binding: t -*-

(defvar my/org-main-file "~/Documents/life.org"
  "The absolute path to my main org file.")

(defun my/org-add-timestamp-property ()
  "Add CREATED/DONE/CANCELLED property based on TODO state.
   Checks to ensure we don't overwrite existing timestamps."
  (let* ((state (org-get-todo-state))
         (timestamp (format-time-string (concat "[" (cdr org-time-stamp-formats) "]")))
         (property (cdr (assoc state '(("TODO"      . "CREATED")
                                       ("DONE"      . "DONE")
                                       ("CANCELLED" . "CANCELLED"))))))
    (when (and property (not (org-entry-get nil property)))
      (org-set-property property timestamp))))

(use-package org
  :ensure t

  :bind (("C-c c" . org-capture)
         ("C-c a" . org-agenda))

  :hook
  ((org-mode . org-indent-mode)
   (org-after-todo-state-change . my/org-add-timestamp-property)
   (org-capture-mode . (lambda () (when (featurep 'evil) (evil-insert-state)))))

  :config
  (setq org-default-notes-file my/org-main-file)
  (setq org-agenda-files (list my/org-main-file))

  (setq org-hide-leading-stars t)
  (setq org-todo-keyword-faces
        '(("TODO"      . "red")
          ("NEXT"      . "gold")
          ("WAITING"   . "purple")
          ("SOME"      . "royal blue")
          ("DONE"      . "forest green")
          ("CANCELLED" . "saddle brown")))

  (setq org-enforce-todo-dependencies t)
  (setq org-log-done nil)
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "WAITING(w)" "SOME(s)" "|" "DONE(d)" "CANCELLED(c)")))

  (setq org-refile-targets
        '((nil :maxlevel . 6)
          (org-agenda-files :maxlevel . 6)))
  (setq org-refile-use-outline-path 'file)
  (setq org-outline-path-complete-in-steps nil)

  (setq org-export-with-properties t
        org-export-with-tasks t
        org-export-with-planning t)

  (setq org-capture-templates
        '(("t" "Todo" entry (file my/org-main-file)
           "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:"
           :empty-lines 1)))
  )
