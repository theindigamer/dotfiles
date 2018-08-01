;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     auto-completion
     graphviz
     yaml
     html
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     ;; better-defaults
     emacs-lisp
     csv
     git
     markdown
     org
     (latex :variables latex-enable-folding t)
     rust
     (haskell :variables
             haskell-process-type 'stack-ghci
             haskell-completion-backend 'intero
             haskell-process-log t
             haskell-enable-hindent-style "johan-tibell")
     ocaml
     python
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     spell-checking
     ;; syntax-checking
     ;; version-control
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages
   '(
     nlinum
     (evil-mc :location (recipe
                         :fetcher github
                         :repo "gabesoft/evil-mc"
                         :min-version "1"))
     )
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '(adaptive-wrap smartparens auto-complete line-number font-lock)
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'. (default t)
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. (default t)
   dotspacemacs-check-for-update t
   ;; One of `vim', `emacs' or `hybrid'. Evil is always enabled but if the
   ;; variable is `emacs' then the `holy-mode' is enabled at startup. `hybrid'
   ;; uses emacs key bindings for vim's insert mode, but otherwise leaves evil
   ;; unchanged. (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'.
   ;; (default '(recents projects))
   dotspacemacs-startup-lists '(recents projects)
   ;; Number of recent files to show in the startup buffer. Ignored if
   ;; `dotspacemacs-startup-lists' doesn't include `recents'. (default 5)
   dotspacemacs-startup-recent-list-size 5
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light
                         solarized-light
                         solarized-dark
                         leuven
                         monokai
                         zenburn)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font '("Iosevka SS09"
                               :size 14
                               :weight normal
                               :width normal
                               :powerline-scale 1.2)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m)
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; (Not implemented) dotspacemacs-distinguish-gui-ret nil
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"
   ;; If non nil `Y' is remapped to `y$'. (default t)
   dotspacemacs-remap-Y-to-y$ t
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil then `ido' replaces `helm' for some commands. For now only
   ;; `find-files' (SPC f f), `find-spacemacs-file' (SPC f e s), and
   ;; `find-contrib-file' (SPC f e c) are replaced. (default nil)
   dotspacemacs-use-ido nil
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-micro-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non nil line numbers are turned on in all `prog-mode' and `text-mode'
   ;; derivatives. If set to `relative', also turns on relative line numbers.
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil advises quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup 'trailing
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place you code here."
  ;;(global-linum-mode)
  (global-visual-line-mode)
  (menu-bar-mode)
  (highlight-indentation-mode)
  (global-nlinum-mode)
  (spacemacs/toggle-visual-line-navigation-on)
  (remove-hook 'rust-mode-hook 'adaptive-wrap-prefix-mode)
  (setq-default show-trailing-whitespace t)
  (require 'intero)
  (require 'flycheck)
  (flycheck-add-next-checker 'intero '(warning . haskell-hlint))

  (require 'haskell-mode)
  (add-to-list 'auto-mode-alist '("\\.miu\\'" . haskell-mode))

  (require 'rust-mode)
  (add-to-list 'auto-mode-alist '("\\.lalrpop\\'" . rust-mode))
  (add-to-list 'auto-mode-alist '("\\.ylx\\'" . rust-mode))


  ;; C++
  ;; setup irony mode
  ;; (require 'irony)
  ;; (add-hook 'c++-mode-hook 'irony-mode)
  ;; (add-hook 'c-mode-hook 'irony-mode)
  ;; (add-hook 'objc-mode-hook 'irony-mode)
  ;; (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

  ;; additional c++ key bindings.
  ;; (defun clang-format-bindings ()
  ;;  (evil-local-set-key 'normal (kbd "SPC m F") 'clang-format-buffer)
  ;;  (evil-local-set-key 'normal (kbd ", F") 'clang-format-buffer))
  ;; (add-hook 'c++-mode-hook 'clang-format-bindings)

  ;; setup flycheck-irony
  ;; (add-hook 'c++-mode-hook 'flycheck-mode)
  ;; (add-hook 'c-mode-hook 'flycheck-mode)
  ;; (require 'flycheck-irony)
  ;; (eval-after-load 'flycheck
  ;;   '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

  ;; (add-to-list 'load-path "~/Code/ats2-mode/")
  ;; (toggle-debug-on-error)
  ;; (require 'ats2-mode)

  ;; Keybindings for multi-cursors because the default ones are not so nice.
  (defvar evil-mc-key-map
  (let ((map (make-sparse-keymap))
        (keys '(("mm" . evil-mc-make-all-cursors)
                ("mu" . evil-mc-undo-all-cursors)
                ("mp" . evil-mc-pause-cursors)
                ("mr" . evil-mc-resume-cursors)
                ("mf" . evil-mc-make-and-goto-first-cursor)
                ("ml" . evil-mc-make-and-goto-last-cursor)
                ("mh" . evil-mc-make-cursor-here)
                ("mj" . evil-mc-make-cursor-move-next-line)
                ("mk" . evil-mc-make-cursor-move-prev-line)
                ("mc" . evil-mc-make-and-goto-next-cursor)
                ("msc" . evil-mc-skip-and-goto-next-cursor)
                ("mC" . evil-mc-make-and-goto-prev-cursor)
                ("msC" . evil-mc-skip-and-goto-prev-cursor)
                ("mn" . evil-mc-make-and-goto-next-match)
                ("msn" . evil-mc-skip-and-goto-next-match)
                ("msN" . evil-mc-skip-and-goto-next-match)
                ("mN" . evil-mc-make-and-goto-prev-match)
                ("msN" . evil-mc-skip-and-goto-prev-match))))
    (dolist (key-data keys)
      (evil-define-key 'normal map (kbd (car key-data)) (cdr key-data))
      (evil-define-key 'visual map (kbd (car key-data)) (cdr key-data)))
    map))
  ;; TODO: change the mode-line behaviour to be seamless with Spacemacs
  (defvar evil-mc-one-cursor-show-mode-line-text nil)
  (defvar evil-mc-mode-line-text-cursor-color nil)
  (require 'evil-mc)
  (global-evil-mc-mode 1)
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(haskell-mode-stylish-haskell-path "brittany")
 '(package-selected-packages
   (quote
    (sesman flycheck-irony irony flycheck-clangcheck stickyfunc-enhance srefactor helm-cscope xcscope evil-mc-mode disaster company-c-headers cmake-mode clang-format haskell-snippets haskell-mode org-mime graphviz-dot-mode ghub let-alist pos-tip log4e gntp simple-httpd json-snatcher json-reformat parent-mode request gitignore-mode flyspell-correct flx anzu diminish web-completion-data dash-functional edn paredit peg eval-sexp-fu seq spinner pkg-info epl bind-map bind-key pythonic f markup-faces auto-complete popup caml powerline org-category-capture org-plus-contrib markdown-mode flycheck ghc inflections cider queue clojure-mode packed avy anaconda-mode auctex tern iedit smartparens highlight evil goto-chg undo-tree company projectile helm helm-core yasnippet multiple-cursors skewer-mode js2-mode magit magit-popup git-commit with-editor async alert hydra rust-mode haml-mode dash s rvm ruby-tools ruby-test-mode rubocop rspec-mode robe rbenv rake minitest chruby bundler inf-ruby yapfify yaml-mode ws-butler winum which-key web-mode web-beautify volatile-highlights vi-tilde-fringe uuidgen utop use-package tuareg toml-mode toc-org tagedit spaceline smeargle slim-mode scss-mode sass-mode restart-emacs rainbow-delimiters racer pyvenv pytest pyenv-mode py-isort pug-mode popwin pip-requirements persp-mode pcre2el paradox orgit org-projectile org-present org-pomodoro org-download org-bullets open-junk-file ocp-indent nlinum neotree move-text mmm-mode merlin markdown-toc magit-gitflow macrostep lua-mode lorem-ipsum livid-mode live-py-mode linum-relative link-hint less-css-mode julia-mode json-mode js2-refactor js-doc intero info+ indent-guide hy-mode hungry-delete htmlize hlint-refactor hl-todo hindent highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-make helm-hoogle helm-gitignore helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag google-translate golden-ratio gnuplot gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gh-md fuzzy flyspell-correct-helm flx-ido fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu emmet-mode elm-mode elisp-slime-nav dumb-jump define-word cython-mode csv-mode company-web company-tern company-statistics company-ghci company-ghc company-cabal company-auctex company-anaconda column-enforce-mode coffee-mode cmm-mode clojure-snippets clj-refactor clean-aindent-mode cider-eval-sexp-fu cargo auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile auctex-latexmk aggressive-indent adoc-mode adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell)))
 '(racer-rust-src-path
   "/home/varun/.multirust/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src")
 '(read-quoted-char-radix 16))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))
