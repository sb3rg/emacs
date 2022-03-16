(package-initialize)
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
   '("5c9ae5b368598ea1d502be201c1b38e1364b7bf6b76954fd214bad3a99e3e60a" "3c68f48ea735abe65899f489271d11cbebbe87da7483acf9935ea4502efd0117" "b25040da50ef56b81165676fdf1aecab6eb2c928fac8a1861c5e7295d2a8d4dd" "95db78d85e3c0e735da28af774dfa59308db832f84b8a2287586f5b4f21a7a5b" "e6d83e70d2955e374e821e6785cd661ec363091edf56a463d0018dc49fbc92dd" default))
 '(menu-bar-mode nil)
 '(package-archives
   '(("gnu" . "http://elpa.gnu.org/packages/")
     ("" . "https://stable.melpa.org/packages/")))
 '(package-selected-packages
   '(plantuml-mode magit company racer cargo rust-mode ox-twbs htmlize yaml-mode ess poly-R r-autoyas python paredit geiser multi-term twilight-anti-bright-theme exwm alchemist))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 105 :width normal :foundry "outline" :family nil)))))
