;;; -*- lexical-binding: t -*-

;; Force UTF-8 as the default encoding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(setq prelude-theme 'modus-vivendi)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
