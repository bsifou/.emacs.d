;;; init.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; This file bootstraps the configuration, which is divided into
;; a number of other files.

;;; Code:

;; Produce backtraces when errors occur: can be helpful to diagnose startup issues
;;(setq debug-on-error t)

(let ((minver "25.1"))
  (when (version< emacs-version minver)
    (error "Your Emacs is too old -- this config requires v%s or higher" minver)))
(when (version< emacs-version "26.1")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'init-benchmarking) ;; Measure startup time

(defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer
(defconst *is-a-mac* (eq system-type 'darwin))

;;----------------------------------------------------------------------------
;; Adjust garbage collection thresholds during startup, and thereafter
;;----------------------------------------------------------------------------
(let ((normal-gc-cons-threshold (* 20 1024 1024))
      (init-gc-cons-threshold (* 128 1024 1024)))
  (setq gc-cons-threshold init-gc-cons-threshold)
  (add-hook 'emacs-startup-hook
            (lambda () (setq gc-cons-threshold normal-gc-cons-threshold))))

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(require 'init-utils)
(require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el
;; Calls (package-initialize)
(require 'init-elpa)      ;; Machinery for installing required packages
(require 'init-exec-path) ;; Set up $PATH

;;----------------------------------------------------------------------------
;; Allow users to provide an optional "init-preload-local.el"
;;----------------------------------------------------------------------------
(require 'init-preload-local nil t)

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------

(require-package 'diminish)
(maybe-require-package 'scratch)
(require-package 'command-log-mode)

(require 'init-frame-hooks)
(require 'init-xterm)
;; (require 'init-themes)
(require 'init-osx-keys)
(require 'init-gui-frames)
(require 'init-dired)
(require 'init-isearch)
(require 'init-grep)
(require 'init-uniquify)
(require 'init-ibuffer)
(require 'init-flycheck)

(require 'init-recentf)
(require 'init-selectrum)
(require 'init-hippie-expand)
(require 'init-company)
(require 'init-windows)
(require 'init-sessions)
(require 'init-mmm)

(require 'init-editing-utils)
(require 'init-whitespace)

(require 'init-vc)
(require 'init-darcs)
(require 'init-git)
(require 'init-github)

(require 'init-projectile)

(require 'init-compile)
(require 'init-crontab)
(require 'init-textile)
(require 'init-markdown)
(require 'init-csv)
(require 'init-erlang)
(require 'init-javascript)
(require 'init-php)
(require 'init-org)
(require 'init-nxml)
(require 'init-html)
(require 'init-css)
(require 'init-haml)
(require 'init-http)
(require 'init-python)
(require 'init-haskell)
(require 'init-elm)
(require 'init-purescript)
(require 'init-ruby)
(require 'init-rails)
(require 'init-sql)
(require 'init-ocaml)
(require 'init-j)
(require 'init-nim)
(require 'init-rust)
(require 'init-toml)
(require 'init-yaml)
(require 'init-docker)
(require 'init-terraform)
(require 'init-nix)
(maybe-require-package 'nginx-mode)

(require 'init-paredit)
(require 'init-lisp)
(require 'init-slime)
(require 'init-clojure)
(require 'init-clojure-cider)
(require 'init-common-lisp)

(when *spell-check-support-enabled*
  (require 'init-spelling))

(require 'init-misc)

(require 'init-folding)
(require 'init-dash)

;;(require 'init-twitter)
;; (require 'init-mu)
(require 'init-ledger)
;; Extra packages which don't require any configuration

(require-package 'sudo-edit)
(require-package 'gnuplot)
(require-package 'lua-mode)
(require-package 'htmlize)
(when *is-a-mac*
  (require-package 'osx-location))
(unless (eq system-type 'windows-nt)
  (maybe-require-package 'daemons))
(maybe-require-package 'dotenv-mode)
(maybe-require-package 'shfmt)

(when (maybe-require-package 'uptimes)
  (setq-default uptimes-keep-count 200)
  (add-hook 'after-init-hook (lambda () (require 'uptimes))))

(when (fboundp 'global-eldoc-mode)
  (add-hook 'after-init-hook 'global-eldoc-mode))

(require 'init-direnv)

;;----------------------------------------------------------------------------
;; Allow access from emacsclient
;;----------------------------------------------------------------------------
(add-hook 'after-init-hook
          (lambda ()
            (require 'server)
            (unless (server-running-p)
              (server-start))))

;;----------------------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------------------
(when (file-exists-p custom-file)
  (load custom-file))


;;----------------------------------------------------------------------------
;; Locales (setting them earlier in this file doesn't work in X)
;;----------------------------------------------------------------------------
(require 'init-locales)


;;----------------------------------------------------------------------------
;; Allow users to provide an optional "init-local" containing personal settings
;;----------------------------------------------------------------------------
(require 'init-local nil t)

;;; xxxx


;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)





;; (add-hook 'prog-mode-hook (lambda ()


;;                             (whitespace-mode 0)
;;                             ))



;; (global-linum-mode -1)
                                        ;(global-display-line-numbers-mode 1)


                                        ;(load-theme 'naysayer)

;; (load-theme 'graphene-meta)
;;(load-file "~/.emacs.d/elpa/clojure-mode-20191112.1948/clojure-mode.el")



                                        ; (load-file "~/.emacs.d/elpa/clojure-mode-extra-font-locking-20190712.639/clojure-mode-extra-font-locking.el")

;; c(add-to-list 'auto-mode-alist '("\\.cljs\\'" . clojurescript-mode))
;; (add-to-list 'auto-mode-alist '("\\.clj\\'" . clojure-mode))
                                        ;(require 'clojure-mode-extra-font-locking)

                                        ;(menu-bar-mode -1)
;;(menu-bar-mode -1)

(setq writeroom-fullscreen-effect 'maximized)


;; (defun fullscreen ()
;;   (interactive)
;;   (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
;;                          '(2 "_NET_WM_STATE_FULLSCREEN" 0)))

;; (fullscreen)

                                        ;(toggle-frame-fullscreen)

                                        ;(add-hook 'clojure-mode 'paren-face-mode)
                                        ;(add-hook 'clojurescript-mode 'paren-face-mode)

;; (add-hook 'clojurescript (lambda () (paren-face-mode-set-explicit t
;;                                                                    )
;;                             (paren-face-mode)))

                                        ;(load-theme 'gruvbox)

(add-to-list 'exec-path "/usr/local/Cellar/emacs-plus/HEAD-65fb048/bin")



(setq-default cursor-type 'box)
                                        ;(setq-default cursor-type 'bar)



(setq default-frame-alist '(
                            (tool-bar-lines . 0)
                                        ;(background-color . "black")
                                        ;(foreground-color . "white")
                                        ;(cursor-color . "red")
                            (left . 50)
                            (top . 50)))

                                        ; (set-background-color "black")
                                        ; (set-foreground-color "white")

;; (set-cursor-color "red")




(defun night-mode ()
  (interactive)
  (set-face-attribute 'default nil :background "black")
  (set-face-attribute 'default nil :foreground "white"))
                                        ;(set-background-color "black")
                                        ;(set-foreground-color "white")



;; (ivy-mode 1)


(set-face-attribute 'region nil :background "lightgreen")

(defun day-mode ()
  (interactive)
                                        ;(set-face-attribute 'region nil :background "lightgreen")
  (set-face-attribute 'default nil :background "white")
  (set-face-attribute 'default nil :foreground "black"))

(defun default-theme ()
  (interactive)
  (disable-theme 'green-is-the-new-black))

(defun green-black-theme ()
  (interactive)
  (enable-theme 'green-is-the-new-black))




(require 'vlf-setup)



                                        ;(set-foreground-color "#d5c4a1")
                                        ;(set-foreground-color "#fbf1c7")

(add-hook 'c-mode-hook
          (lambda ()
            (font-lock-add-keywords nil
                                    '(("\\<\\(FIXME\\):" 1
                                       font-lock-comment-face t)))))

(font-lock-add-keywords 'clojure-mode-hook
                        '(("foo" font-lock-comment-face)))
                                        ;(osx-key-mode nil)



;; (add-to-list 'load-path "~/Desktop/")
                                        ;(load "clojure-mode")

;; (defun swap-and-kill ()

;;   "Swap point and mark, then clipboard kill region"

;;   (interactive)

;;   (exchange-point-and-mark)

;;   (clipboard-kill-region (region-beginning) (region-end))

;;   (deactivate-mark)

;;   )


(global-set-key "\M-w" 'clipboard-kill-ring-save)

(global-set-key "\C-y" 'clipboard-yank)


(setq osxkeys-command-key 'alt)
(add-to-list 'auto-mode-alist '("\.ts\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))


;;(load-file "~/Desktop/clojure-mode-x.el")



                                        ;(osx-key-mode)

(setq save-interprogram-paste-before-kill t)


;;(add-hook 'clojure-mode-hook #'inf-clojure-minor-mode)

(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))


(defun font14 ()
  (interactive)
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(default ((t (:family "Fira Code Retina" :foundry "nil" :slant normal :weight normal :height 140 :width normal))))))


(defun font13  ()
  (interactive)
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(default ((t (:family "Fira Code Retina" :foundry "nil" :slant normal :weight normal :height 130 :width normal))))))

(defun font12  ()
  (interactive)
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(default ((t (:family "Fira Code Retina" :foundry "nil" :slant normal :weight normal :height 120 :width normal))))
   (setq line-spacing 0.0)))





(defun font12a  ()
  (interactive)
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(default ((t (:family "JetBrains Mono" :foundry "nil" :slant normal :weight normal :height 120 :width normal)))))
  (setq line-spacing 0.2))

(defun font13a  ()
  (interactive)
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(default ((t (:family "JetBrains Mono" :foundry "nil" :slant normal :weight normal :height 130 :width normal))))))



(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)
(setq mac-command-key-is-meta t)



(setq mac-command-modifier 'meta) ; make cmd key do Meta
(setq mac-option-modifier 'super) ; make opt key do Super
(setq mac-control-modifier 'control) ; make Control key do Control
(setq ns-function-modifier 'hyper)

(global-set-key (kbd "C-N") 'next-line)
(global-set-key (kbd "C-P") 'previous-line)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(setq-default tab-width 2)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)


;;; 1 12 3  4 4                                        ;(global-linum-mode 1)


(setq inferior-lisp-program "clojure -A:dev")
(setq inferior-lisp-program "/usr/local/bin/npx shadow-cljs -d nrepl:0.6.0 -d cider/piggieback:0.4.2 -d cider/cider-nrepl:0.23.0-SNAPSHOT server")
(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)


(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
                                        ;(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))


(setq-default truncate-lines t)
                                        ; (set-cursor-color "red")
(global-display-line-numbers-mode 1)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

(global-display-fill-column-indicator-mode 0)
;; (beacon-mode 0)
;; (setq line-spacing 0.2)
(rainbow-delimiters-mode 0)

(add-hook 'clojure-mode-hook (lambda () (paren-face-mode t)))

(scroll-all-mode 1)
                                        ; (setq-default show-trailing-whitespace 0)
(add-hook 'prog-mode-hook (lambda ()
                            (setq show-trailing-whitespace nil)))
;; (require 'clojure-mode-extra-font-locking)


;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(default ((t (:inherit nil :extend nil :stipple nil :background "#292a2f" :foreground "#cccccc" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "nil" :family "SF Mono"))))
;;  '(font-lock-string-face ((t (:foreground "#fd8273"))))
;;  '(fringe ((t (:background "#292a2f" :foreground "#999999"))))
;;  '(line-number ((t (:background "#292a2f" :foreground "#999999"))))
;;  '(mode-line ((t (:background "#515151" :foreground "#cccccc" :box (:line-width 1 :color "#515151") :weight normal))))
;;  '(symbol-overlay-default-face ((t (:inherit highlight :underline nil :weight semi-bold)))))
(setq-default word-wrap t)
(global-visual-line-mode t)
(menu-bar--wrap-long-lines-window-edge)
(provide 'init)

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
;;; init.el ends here

;; '(default ((t (:inherit nil :extend nil :stipple nil :background "#1a1a1a" :foreground "#bdbdb3" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight medium :height 130 :width medium :foundry "nil" :family "SF Mono"))))
;; (require 'indium)
;; (add-hook 'js-mode-hook #'indium-interaction-mode)

(setq js2-strict-missing-semi-warning nil)

(defun my-minibuffer-line-spacing ()
  (setq-local line-spacing 0.15))

(add-hook 'minibuffer-setup-hook #'my-minibuffer-line-spacing)

(define-key inferior-js-minor-mode-map "\C-x\C-r" 'js-send-region)
(define-key inferior-js-minor-mode-map (kbd "C-c b") 'js-send-buffer)
(define-key inferior-js-minor-mode-map (kbd "C-c C-b") 'js-send-buffer-and-go)


;; (setq js-comint-program-command "java")
;; (setq js-comint-program-arguments '("-jar" "/Users/sifoub/Downloads/rhino-1.7.13.jar"))

;; (setq js-comint-progra
;;
;;m-command "node")
;; (setq js-comint-program-arguments '("--interactive"))

;; '(line-spacing 0.24)
;; '(line-spacing 0.1)
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(default ((t (:inherit nil :extend nil :stipple nil :background "#1a1a1a" :foreground "#cacaca" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "nil" :family "SF Mono"))))
;;  '(cursor ((t (:background "#fd8273"))))
;;  '(font-lock-string-face ((t (:foreground "#fd8273"))))
;;  '(fringe ((t (:background "##1a1a1a" :foreground "#999999"))))
;;  '(line-number-current-line ((t (:inherit line-number :foreground "white" :weight bold))))
;;  '(symbol-overlay-default-face ((t (:inherit highlight :underline nil :weight medium)))))

;; (add-hook 'js2-mode-hook #'setup-tide-mode)
;; configure javascript-tide checker to run after your default javascript checker
;; (flycheck-add-next-checker 'javascript-eslint 'javascript-tide 'append)

;; (company-quickhelp-mode)

;; (set-frame-parameter nil 'ns-transparent-titlebar nil)
;; (set-frame-parameter nil 'ns-appearance 'dark)

(add-hook 'typescript-mode-hook
          (lambda ()
            (local-set-key (kbd "C-x C-e") 'ts-send-last-sexp)
            (local-set-key (kbd "C-M-x") 'ts-send-last-sexp-and-go)
            (local-set-key (kbd "C-c b") 'ts-send-buffer)
            (local-set-key (kbd "C-c C-b") 'ts-send-buffer-and-go)
            (local-set-key (kbd "C-c l") 'ts-load-file-and-go)))

;; (setq rtog/mode-repl-alist '((typescript-mode . run-ts)))

(setq rtog/fullscreen nil)
(require 'repl-toggle)
(push '(typescript-mode . run-ts) rtog/mode-repl-alist)
(push '(js2-mode . nodejs-repl) rtog/mode-repl-alist)

(setq rtog/goto-buffer-fun 'pop-to-buffer)

(nyan-mode)

(global-set-key (kbd "M-c") 'kill-ring-save)
                                        ;(global-set-key (kbd "M-x") 'clipboard-yank)
;; (global-set-key [(meta v)] 'yank)

(setq mac-command-key-is-meta nil)
(add-to-list 'auto-mode-alist '("\\.svelte\\'" . web-mode))
(setq mac-command-modifier 'meta mac-option-modifier 'alt)
;; (require 'redo+)
;; (require 'mac-key-mode)

(provide 'lsp-tailwindcss)
;;; lsp-tailwindcss.el ends here

(use-package dired-sidebar
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)




  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))

(defun sidebar-toggle ()
  "Toggle both `dired-sidebar' and `ibuffer-sidebar'."
  (interactive)
  (dired-sidebar-toggle-sidebar)
  (ibuffer-sidebar-toggle-sidebar))

(global-set-key [(C x) (C k)] 'sidebar-toggle)

;; (setq dired-sidebar-subtree-line-prefix nil)
;; (scroll-bar-mode 0)
;; (setq dired-sidebar-theme 'vscode)
;; (setq dired-sidebar-subtree-line-prefix "__")
(add-to-list 'default-frame-alist '(scroll-bar-mode . 0))

(customize-set-variable 'scroll-bar-mode nil)
(customize-set-variable 'horizontal-scroll-bar-mode nil)


