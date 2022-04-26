;; NOTE: init.el is generated from config.org.  Edit that file in
;; Emacs and init.el will automatically be generated!

;; adjust thist for your system
(defvar runemacs/default-font-size 125)
(defvar runemacs/default-variable-font-size 125)

;; make frame transparency overridable
(defvar runemacs/frame-transparency '(90 . 90))

;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

(defun efs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
	   (format "%.2f seconds"
		   (float-time
		    (time-subtract after-init-time before-init-time)))
	   gcs-done))
(add-hook 'emacs-startup-hook #'efs/display-startup-time)

;; Stop showing the welcome screen
(setq inhibit-startup-screen t)
;; Deactivate bell
(setq visible-bell 1)
;; make sure line numbers apear in all text editing buffers
(global-linum-mode t)
;; setup starting frame dimensions
(setq initial-frame-alist '((top . 40) (left . 100) (width . 128) (height . 40)))

(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; custuomize theme
(when (require 'gruvbox-theme nil 'noerror)
  (load-theme 'gruvbox-dark-medium t))

(set-face-attribute 'default nil :family "DejaVu Sans Mono" :height runemacs/default-font-size)
;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :family "DejaVu Sans Mono" :height runemacs/default-font-size)
;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :family "DejaVu Sans Mono" :height runemacs/default-font-size :weight 'regular )

(setq backup-directory-alist `(("." . ,(expand-file-name "tmp/backups" user-emacs-directory))))

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

(use-package gruvbox-theme
  :ensure t)

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

(use-package helpful
  :ensure t
  :bind (("C-h F" . helpful-function)
	 ("C-h V" . helpful-variable)
	 ("C-c C-d" . helpful-at-point)))

;; (use-package magit
;;   :ensure t)

;; (use-package company
;;   :ensure t)

;; (use-package flycheck
;;   :ensure t
;;   :init (global-flycheck-mode))
;; (use-package flycheck-rust
;;   :ensure t)

;; (use-package lsp-mode
;;   :ensure t
;;   :commands (lsp lsp-deferred)
;;   :init
;;   (setq lsp-keymap-prefix "C-c l"))
;; :config
;; (lsp-enable-which-key-intergration t))

;; --- NOT SURE HOW TO PROPERLY SET THIS UP SO COMMENTING OUT
;; (use-package lsp-java
;;   :ensure t
;;   :init
;;   (setq lsp-java-java-path "/c/Users/SeanBergstedt/jdk-16.0.2/bin/java.exe")
;;   :config
;;   (add-hook 'java-mode-hook #'lsp))

;; (require 'simple-httpd)
(use-package simple-httpd
  :ensure t)

(use-package websocket
  :ensure t)

(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))

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

;; automatically tangle our config.org file when we save it
(defun efs/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
		      (expand-file-name "~/.emacs.d/config.org"))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))

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

(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

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

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t )
   (python . t )
   (java . t)
   (js . t)))

;; (add-to-list 'load-path "~/org/lib/org-reveal/")
;; (require 'ox-reveal) 			;manually installed
;; ;; (use-package org-reveal
;; ;;   :ensure t)

;; dependencies for org-roam
(use-package emacsql-sqlite3
  :ensure t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BEGIN HELPER FUNCTIONS                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; --------------------------------------------------
;; insert topic node immediately without opening buffer
;; --------------------------------------------------
(defun org-roam-node-insert-immediate (arg &rest args)
  (interactive "P")
  (let ((args (push arg args))
	(org-roam-capture-templates (list (append (car org-roam-capture-templates)
						  '(:immediate-finish t)))))
    (apply #'org-roam-node-insert args)))
;; --------------------------------------------------
;; Keep an inbox of notes and tasks
;; --------------------------------------------------
(defun my/org-roam-capture-inbox ()
  (interactive)
  (org-roam-capture- :node (org-roam-node-create)
		     :templates '(("i" "inbox" plain "** %?"
				   :if-new (file+head "Inbox.org" "#+title: Inbox\n")))))
;; --------------------------------------------------
;; build org agenda from org-roam notes
;; --------------------------------------------------
;; (defun my/org-roam-filter-by-tag (tag-name)
;;   (lambda (node)
;;     (member tag-name (org-roam-node-tags node))))
(defun my/org-roam-list-notes-by-tag (tag-name)
  (mapcar #'org-roam-node-file
	  (seq-filter
	   (lambda (node)
	     (member "Project" (org-roam-node-tags node)))
	   ;; (my/org-roam-filter-by-tag tag-name)
	   (org-roam-node-list))))
(defun my/org-roam-refresh-agenda-list ()
  (interactive)
  (setq org-agenda-files (my/org-roam-list-notes-by-tag "Project")))
;; --------------------------------------------------
;; selecting from a liste of notes with a specific tag
;; --------------------------------------------------
(defun my/org-roam-project-finalize-hook ()
  "Adds the captured project file to `org-agenda-files' if the
  capture was not aborted."
  ;; Remove the hook since it was added temporarily
  (remove-hook 'org-capture-after-finalize-hook #'my/org-roam-project-finalize-hook)
  ;; Add project file to the agenda list if the capture was confirmed
  (unless org-note-abort
    (with-current-buffer (org-capture-get :buffer)
      (add-to-list 'org-agenda-files (buffer-file-name)))))
(defun my/org-roam-find-project ()
  (interactive)
  ;; Add the project file to the agenda after capture is finished
  (add-hook 'org-capture-after-finalize-hook #'my/org-roam-project-finalize-hook)
  ;; Select a project file to open, creating it if necessary
  (org-roam-node-find
   nil
   nil
   (lambda (node)
     (member "Project" (org-roam-node-tags node)))
   ;; (my/org-roam-filter-by-tag "Project")
   :templates
   '(("p" "project" plain (file "~/org-roam/templates/ProjectTemplate.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+category: \n#+filetags: Project\n#+date: %U\n")
      :unnarrowed t))))
;; --------------------------------------------------
;; capture tasks directly into a specific project
;; --------------------------------------------------
(defun my/org-roam-capture-task ()
  (interactive)
  ;; Add the project file to the agenda after capture is finished
  (add-hook 'org-capture-after-finalize-hook #'my/org-roam-project-finalize-hook)

  ;; Capture the new task, creating the project file if necessary
  (org-roam-capture- :node (org-roam-node-read
			    nil
			    (lambda (node)
			      (member "Project" (org-roam-node-tags node))))
		     ;; (my/org-roam-filter-by-tag "Project"))
		     :templates '(("p" "project" plain "** TODO %?"
				   :if-new (file+head+olp "%<%Y%m%d%H%M%S>-${slug}.org"
							  "#+title: ${title}\n#+category: \n#+filetags: Project\n#+date: %U\n"
							  ("Tasks"))))))
;; --------------------------------------------------
;; automatically copy completed tasks to dailies
;; --------------------------------------------------
(defun my/org-roam-copy-todo-to-today ()
  (interactive)
  (let ((org-refile-keep t) ;; Set this to nil to delete the original!
	(org-roam-dailies-capture-templates
	 '(("t" "tasks" entry "%?"
	    :if-new (file+head+olp "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n" ("Accomplishments")))))
	(org-after-refile-insert-hook #'save-buffer)
	today-file
	pos)
    (save-window-excursion
      (org-roam-dailies--capture (current-time) t)
      (setq today-file (buffer-file-name))
      (setq pos (point)))
    ;; Only refile if the target file is different than the current file
    (unless (equal (file-truename today-file)
		   (file-truename (buffer-file-name)))
      (org-refile nil nil (list "Accomplishments" today-file nil pos)))))

(add-to-list 'org-after-todo-state-change-hook
	     (lambda ()
	       (when (equal org-state "DONE")
		 (my/org-roam-copy-todo-to-today))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; END HELPER FUNCTIONS                                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; org-roam setup
(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  ;; (setq org-roam-node-display-template "${directories:10} ${tags:10} ${title:100} ${backlinkscount:6}")
  :custom
  (org-roam-directory (file-truename "~/org-roam"))
  (org-roam-completion-everywhere t)
  (org-roam-capture-templates
   '(("t" "topic" plain
      (file "~/org-roam/templates/Topic.org" )
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U\n")
      :unnarrowed t)
     ("u" "quote" plain
      (file "~/org-roam/templates/QuoteTemplate.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: Quote\n#+date: %U\n")
      :unnarrowed t)
     ("b" "book reference" plain
      (file "~/org-roam/templates/BookNoteTemplate.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: Reference Document\n#+date: %U\n")
      :unnarrowed t)
     ("p" "project" plain
      (file "~/org-roam/templates/ProjectTemplate.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+category: \n#+filetags: Project\n#+date: %U\n")
      :unnarrowed t)
     ("g" "graphic" plain
      (file "~/org-roam/templates/Graphic.org" )
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U\n")
      :unnarrowed t)))
  (org-roam-dailies-capture-templates
   '(("d" "default" entry "* %<%I:%M %p>: \n%?"
      :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))
  :bind (("C-c n l" . org-roam-buffer-toggle)
	 ("C-c n f" . org-roam-node-find)
	 ("C-c n i" . org-roam-node-insert)
	 ("C-c n I" . org-roam-node-insert-immediate)
	 ("C-c n b" . my/org-roam-capture-inbox)
	 ("C-c n p" . my/org-roam-find-project)
	 ("C-c n t" . my/org-roam-capture-task)
	 :map org-mode-map
	 ("C-M-i" . completion-at-point))
  :bind-keymap
  ("C-c n d" . org-roam-dailies-map)
  :config
  (require 'org-roam-dailies)		;ensure the keymap is available
  ;; (org-roam-setup)
  (org-roam-db-autosync-mode)
  (my/org-roam-refresh-agenda-list))   ;; Build the agenda list the first time for the session)
;; --- END HELPER FUNCTIONS ---
