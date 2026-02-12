;;; -*- lexical-binding: t -*-

(setq-default display-line-numbers-grow-only t)

(defvar my/org-main-file "~/Documents/life.org"
  "The absolute path to my main org file.")

(defun my/org-add-timestamp-property ()
  "Add CREATED/DONE/CANCELLED property based on TODO state.
   Checks to ensure we don't overwrite existing timestamps."
  (let* ((state (org-get-todo-state))
         (timestamp (format-time-string (concat "[" (cdr org-time-stamp-formats) "]")))
         (property (cdr (assoc state '(("TODO"      . "CREATED")
                                       ("NEXT"      . "CREATED")
                                       ("DONE"      . "DONE")
                                       ("CANCELLED" . "CANCELLED"))))))
    (when (and property (not (org-entry-get nil property)))
      (org-set-property property timestamp))))

(use-package org
  :ensure t

  :bind (("C-c c" . org-capture)
         ("C-c a" . org-agenda)
         :map org-mode-map
         ("C-c C-j" . consult-org-heading))

  :hook
  ((org-mode . org-indent-mode)
   (org-after-todo-state-change . my/org-add-timestamp-property)
   (org-capture-mode . (lambda () (when (featurep 'evil) (evil-insert-state)))))

  :config
  (setq org-default-notes-file my/org-main-file)
  (setq org-agenda-files (list my/org-main-file))

  ;; --- LIST BEHAVIOR ---
  ;; Treat lists like sub-headlines when cycling visibility
  (setq org-cycle-include-plain-lists 'integrate)

  ;; --- APPEARANCE ---
  (setq org-hide-leading-stars t)
  (setq org-todo-keyword-faces
        '(("TODO"      . "red")
          ("NEXT"      . "gold")
          ("WAITING"   . "purple")
          ("SOME"      . "royal blue")
          ("DONE"      . "forest green")
          ("CANCELLED" . "saddle brown")))

  ;; --- TODO FLOW ---
  (setq org-enforce-todo-dependencies t)
  (setq org-log-done nil)
  (setq org-todo-keywords
        '((sequence "NEXT(n)" "TODO(t)" "WAITING(w)" "SOME(s)" "|" "CANCELLED(c)" "DONE(d)")))

  ;; --- REFILING ---
  (setq org-refile-targets
        '((nil :maxlevel . 6)
          (org-agenda-files :maxlevel . 6)))
  (setq org-refile-use-outline-path 'file)
  (setq org-outline-path-complete-in-steps nil)

  ;; --- EXPORT ---
  (setq org-export-with-properties t
        org-export-with-tasks t
        org-export-with-planning t)

  ;; --- CAPTURE ---
  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline my/org-main-file "Inbox")
           "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:"
           :empty-lines 1)))
  )
