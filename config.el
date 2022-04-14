(setq inhibit-startup-screen t)

(setq visible-bell 1)

(global-linum-mode t)

(setq initial-frame-alist '(
            (top . 40) (left . 100)
            (width . 128) (height . 40)
            )
      )

(load-theme 'gruvbox-dark-medium t) 	;don't place within custom variables (below)
;; --------------------------------------------------
;; Setup custom variables
;; --------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 ;; '(custom-enabled-themes (quote (twilight-anti-bright)))
 '(custom-enabled-themes (quote (gruvbox-dark-medium)))
 '(custom-safe-themes
   (quote
    ("3c68f48ea735abe65899f489271d11cbebbe87da7483acf9935ea4502efd0117" "b25040da50ef56b81165676fdf1aecab6eb2c928fac8a1861c5e7295d2a8d4dd" "95db78d85e3c0e735da28af774dfa59308db832f84b8a2287586f5b4f21a7a5b" "e6d83e70d2955e374e821e6785cd661ec363091edf56a463d0018dc49fbc92dd" default)))
 '(menu-bar-mode nil)
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("" . "https://stable.melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (ox-twbs htmlize yaml-mode ess poly-R r-autoyas python paredit geiser multi-term gruvbox-theme exwm alchemist))) ;twilight-anti-bright-theme
 '(tool-bar-mode nil))

(use-package vertico
  :ensure t
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

(use-package savehist
  :init
  (savehist-mode))

(use-package marginalia
  :after vertico
  :ensure t
  :custom
  (marginalia-annotators
   '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

(custom-set-faces
   ;; '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 105 :width normal :foundry "outline" :family "DejaVu Sans Mono")))))
   '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 105 :width normal :foundry "outline" :family nil)))))

(use-package magit
  :ensure t)

(add-to-list `load-path "~/.emacs.d/lisp/")

(load "stm-mode")

;; (add-to-list 'load-path "~/.emacs.d/vendor/alchemist.el/")
(use-package alchemist
  :ensure t)
;; (require 'alchemist)

;; ;; add the location of the elisp files to the load-path
;; (setq load-path (cons  "/usr/lib/erlang/lib/tools-2.6.13/emacs"
;;          load-path))
;; ;; set the location of the man page hierarchy
;; (setq erlang-root-dir "/usr/lib/erlang")
;; ;; add the home of the erlang binaries to the exec-path
;; (setq exec-path (cons "/usr/lib/bin" exec-path))
;; ;; load and eval the erlang-start package to set up 
;; ;; everything else 
;; (require 'erlang-start)

(setq inferior-ess-r-program "R")
(add-hook 'ess-mode-hook
          (lambda () 
            (ess-toggle-underscore nil)))

(add-hook 'java-mode-hook (lambda ()
			    (setq c-basic-offset 2
				  tab-width 2
				  indent-tabs-mode t)))

;;(load (expand-file-name "~/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
;;(setq inferior-lisp-program "sbcl")

(add-to-list 'auto-mode-alist '("\\.stm\\'" . mystm-mode))
(when (fboundp 'mystm-mode)

  (defun my-insert-tab-char ()
    "Insert a tab char. (ASCII 9, \t)"
    (interactive)
    (insert "\t"))

  (defun my-tab-config ()
    ;; setup tab char behavior
    (local-set-key (kbd "TAB") 'my-insert-tab-char)  
    )
  
  (add-hook 'mystm-mode-hook 'my-tab-config)
  )

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)
(use-package rust-mode
  :ensure t)
;; (require 'rust-mode)
(define-key rust-mode-map(kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)

(defun comment-line-break (&optional arg)
  "Add dashed line break comment"
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg))
  (insert-char ?- 50))
  ;; (insert-char ? 20))
(global-set-key (kbd "C-M-;") `comment-line-break)

(defun bjm-comment-box (b e)
  "draw a box comment around the region but arrange for the region to extend to at least the fill column.
place the point after the comment box."
  (interactive "r")
  (let ((e (copy-marker e t)))
    (goto-char b)
    (end-of-line)
    (insert-char ? (- fill-column (current-column)))
    (comment-box b e 1)
    (goto-char e)
    (set-marker e nil)))
;; create comment box
(global-set-key (kbd "C-c b b") `bjm-comment-box)

(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (let ((column (current-column)))
      (beginning-of-line)
      (when (or (> arg 0) (not (bobp)))
        (forward-line)
        (when (or (< arg 0) (not (eobp)))
          (transpose-lines arg)
          (when (and (eval-when-compile
                       '(and (>= emacs-major-version 24)
                             (>= emacs-minor-version 3)))
                     (< arg 0))
            (forward-line -1)))
        (forward-line -1))
      (move-to-column column t)))))

(defun move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines down."
  (interactive "*p")
  (move-text-internal arg))
(global-set-key [M-S-down] 'move-text-down)

(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines up."
  (interactive "*p")
  (move-text-internal (- arg)))
(global-set-key [M-S-up] 'move-text-up)

;; Enable Org mode
(require 'org)
;; Make Org mode work with files ending in .org
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; The above is the default in recent emacs
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(add-hook 'org-mode-hook #'visual-line-mode) ;line wrap
(setq org-hide-leading-stars t)
;; source code tab works on native language within src block
(setq org-src-tab-acts-natively t)

(setq org-agenda-files (append
			(file-expand-wildcards "~/org/gtd/gtd.org")
			(file-expand-wildcards "~/org/gtd/inbox.org")
			(file-expand-wildcards "~/org/gtd/tickler.org")))

(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/org/gtd/inbox.org" "Tasks")
                               "* TODO %i%?")
                              ("T" "Tickler" entry
                               (file+headline "~/org/gtd/tickler.org" "Tickler")
                               "* %i%? \n %U")))

(setq org-refile-targets '(("~/org/gtd/gtd.org" :maxlevel . 3)
			   ("~/org/gtd/someday.org" :level . 1)
			   ("~/org/gtd/tickler.org" :maxlevel . 2)))

(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

(setq org-agenda-custom-commands 
      '(("w" "At Work" tags-todo "@work" ((org-agenda-overriding-header "Work")
	  (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))
	("h" "At Home" tags-todo "@home" ((org-agenda-overriding-header "Home")
	  (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))
	("r" "On the Road" tags-todo "@road" ((org-agenda-overriding-header "Road")
	  (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))))

;; HELPER FUNCTIONS
(defun my-org-agenda-skip-all-siblings-but-first ()
  "Skip all but the first non-done entry."
  (let (should-skip-entry)
    (unless (org-current-is-todo)
      (setq should-skip-entry t))
    (save-excursion
      (while (and (not should-skip-entry) (org-goto-sibling t))
	(when (org-current-is-todo)
	  (setq should-skip-entry t))))
    (when should-skip-entry
      (or (outline-next-heading)
	  (goto-char (point-max))))))

(defun org-current-is-todo ()
  (string= "TODO" (org-get-todo-state)))

(setq org-html-htmlize-output-type 'css)

;; (require 'ox-twbs)
(use-package ox-twbs
  :ensure t)

(require 'ox-latex)			;manually saved to elpa folder
(unless (boundp 'org-latex-classes)
  (setq org-latex-classes nil))
;; (add-to-list 'org-latex-classes
;;              '("article"
;;                "\\documentclass{article}"
;;                ("\\section{%s}" . "\\section*{%s}")))
;; --------------------------------------------------
;; the original modifications
(add-to-list 'org-latex-classes
	     '("article"
	       "\\documentclass{article}"
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	       ("\\paragraph{%s}" . "\\paragraph*{%s}")
	       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
;; (add-to-list 'org-latex-classes
;; 	     '("book"
;; 	       "\\documentclass{book}"
;; 	       ("\\part{%s}" . "\\part*{%s}")
;; 	       ("\\chapter{%s}" . "\\chapter*{%s}")
;; 	       ("\\section{%s}" . "\\section*{%s}")
;; 	       ("\\subsection{%s}" . "\\subsection*{%s}")
;; 	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
;; --------------------------------------------------
;; (with-eval-after-load 'ox-latex
(add-to-list 'org-latex-classes
	     '("org-plain-latex"
	       "\\documentclass{article}
	   [NO-DEFAULT-PACKAGES]
	   [PACKAGES]
	   [EXTRA]"
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	       ("\\paragraph{%s}" . "\\paragraph*{%s}")
	       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(put 'downcase-region 'disabled nil)

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

(use-package plantuml-mode
  :ensure t)
(setq plantuml-default-exec-mode 'jar)
(setq plantuml-jar-path "~/org/lib/plantuml-1.2022.2.jar")
;; fix problem with autoindenting
(setq org-adapt-indentation nil)
;; (setq org-plantuml-jar-path
(setq org-plantuml-jar-path (expand-file-name "~/org/lib/plantuml-1.2022.2.jar"))
;; enable plantuml-mode for PLANTUML files
(add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))

(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '(;; other Babel languages
     (plantuml . t))))

(add-to-list 'load-path "~/org/lib/org-reveal/")
(require 'ox-reveal) 			;manually installed
;; (use-package org-reveal
;;   :ensure t)

;; (require 'simple-httpd)
(use-package simple-httpd
  :ensure t)

;; dependency for org-roam
(use-package emacsql-sqlite3
  :ensure t)
;; setup
(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory (file-truename "~/org-roam"))
  (org-roam-completion-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
	 ("C-c n f" . org-roam-node-find)
	 ("C-c n i" . org-roam-node-insert)
	 :map org-mode-map
	 ("C-M-i" . completion-at-point))
  :config
  (org-roam-db-autosync-mode))
  ;; (org-roam-setup))
;; (org-roam-db-autosync-mode)))
;; --- END HELPER FUNCTIONS ---
