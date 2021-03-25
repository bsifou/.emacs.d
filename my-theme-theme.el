(deftheme my-theme
  "Created 2021-01-18.")

(custom-theme-set-variables
 'my-theme
 '(line-spacing 0.2)
 '(safe-local-variable-values '((cider-shadow-default-options . "main") (cider-default-cljs-repl . shadow)))
 '(show-trailing-whitespace nil)
 '(global-whitespace-cleanup-mode t)
 '(show-paren-mode t)
 '(session-use-package t)
 '(package-selected-packages '(envrc uptimes shfmt dotenv-mode daemons osx-location htmlize lua-mode gnuplot sudo-edit flycheck-ledger ledger-mode dash-at-point origami regex-tool info-colors flycheck-clojure cider elein cljsbuild-mode clojure-mode slime-company slime cask-mode flycheck-relint cl-libify flycheck-package highlight-quoted macrostep cl-lib-highlight aggressive-indent immortal-scratch auto-compile ipretty elisp-slime-nav paredit nginx-mode company-nixos-options nixos-options nix-buffer nix-sandbox nixpkgs-fmt nix-mode company-terraform terraform-mode docker-compose-mode dockerfile-mode docker yaml-mode flycheck-rust racer rust-mode flycheck-nim nim-mode j-mode merlin-eldoc merlin tuareg sqlformat projectile-rails yard-mode bundler yari robe ruby-compilation inf-ruby rspec-mode ruby-hash-syntax psci psc-ide purescript-mode flycheck-elm elm-test-runner elm-mode dhall-mode dante haskell-mode reformatter toml-mode company-anaconda anaconda-mode pip-requirements restclient httprepl haml-mode css-eldoc skewer-less sass-mode rainbow-mode tagedit org-pomodoro writeroom-mode org-cliplink grab-mac-link company-php smarty-mode php-mode add-node-modules-path skewer-mode js-comint coffee-mode xref-js2 prettier-js typescript-mode js2-mode json-mode erlang csv-mode markdown-mode textile-mode crontab-mode alert ibuffer-projectile github-review forge github-clone bug-reference-github yagist git-commit magit-todos magit git-timemachine gitconfig-mode gitignore-mode git-blamed vc-darcs browse-at-remote whitespace-cleanup-mode which-key highlight-escape-sequences whole-line-or-region move-dup page-break-lines multiple-cursors avy browse-kill-ring symbol-overlay goto-line-preview beacon mode-line-bell vlf list-unicode-display unfill mmm-mode session windswap switch-window company-quickhelp company marginalia consult-flycheck embark-consult projectile consult embark selectrum-prescient selectrum flycheck-color-mode-line flycheck ibuffer-vc rg wgrep-ag ag wgrep anzu diff-hl diredfl disable-mouse default-text-scale ns-auto-titlebar dimmer color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized command-log-mode scratch diminish exec-path-from-shell gnu-elpa-keyring-update fullframe seq paren-face clojure-mode-extra-font-locking rainbow-delimiters swift-mode)))

(custom-theme-set-faces
 'my-theme
 '(default ((t (:family "SF Mono" :foundry "nil" :slant normal :weight normal :height 120 :width normal))))
 '(font-lock-string-face ((t (:foreground "#fd8273")))))

(provide-theme 'my-theme)
