(package-initialize)
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(load-theme 'twilight-anti-bright t)
(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(custom-enabled-themes '(twilight-anti-bright))
 '(custom-safe-themes
   '("3c68f48ea735abe65899f489271d11cbebbe87da7483acf9935ea4502efd0117" "b25040da50ef56b81165676fdf1aecab6eb2c928fac8a1861c5e7295d2a8d4dd" "95db78d85e3c0e735da28af774dfa59308db832f84b8a2287586f5b4f21a7a5b" "e6d83e70d2955e374e821e6785cd661ec363091edf56a463d0018dc49fbc92dd" default))
 '(menu-bar-mode nil)
 '(org-roam-capture-templates
   '(("d" "default" plain "
 
%?" :if-new
(file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}
")
:unnarrowed t)
     ("b" "book notes" plain "
 
* Source
 
Author: %^{Author}
Title: ${title}
Year: %^{Year}
 
* Summary
 
%?" :if-new
(file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}
")
:unnarrowed t)
     ("l" "programming language" plain "
 
* Characteristics
 
- Family: %?
-Inspired by: 
 
* Reference:
 
" :if-new
(file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}
")
:unnarrowed t)
     ("p" "project" plain "
 
* Goals
 
* Tasks
 
** TODO Add Initial tasks
 
* Dates
 
" :if-new
(file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}
#+filetags: Project")
:unnarrowed t)))
 '(org-roam-completion-everywhere t)
 '(org-roam-directory "c:/msys64/home/SeanBergstedt/org-roam")
 '(package-archives
   '(("gnu" . "http://elpa.gnu.org/packages/")
     ("" . "https://stable.melpa.org/packages/")))
 '(package-selected-packages
   '(marginalia emacsql-sqlite3 org-roam ox-twbs htmlize yaml-mode ess poly-R r-autoyas python paredit geiser multi-term twilight-anti-bright-theme exwm alchemist))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 105 :width normal :foundry "outline" :family nil)))))
