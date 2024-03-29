;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Jefferson Chen"
      user-mail-address "f1jefferson2@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
(setq doom-theme 'doom-nord-light)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/Org/")
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;; macos key setup
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)
;; for yabai
(setq frame-resize-pixelwise t)
;;
(add-hook 'before-save-hook #'whitespace-cleanup)
(setenv "PYTHONPATH" (shell-command-to-string "$SHELL --login -c 'echo -n $PYTHONPATH'"))

;; isspell
(setq ispell-program-name "/opt/homebrew/bin/aspell")

(setq org-roam-directory "~/Documents/Org/roam")

(use-package! org-roam
  :after org
  :commands
  (org-roam-buffer
   org-roam-setup
   org-roam-capture
   org-roam-node-find)
  :config
  :init
  (map!
   :leader
   :prefix ("r" . "org-roam")
   "c" #'org-roam-capture
   "f" #'org-roam-node-find
   "i" #'org-roam-node-insert
   "b" #'org-roam-buffer-toggle
   "t" #'org-roam-tag-add
   "T" #'org-roam-tag-remove)
  :config
  (setq org-roam-mode-section-functions
        (list #'org-roam-backlinks-section
              #'org-roam-reflinks-section
              #'org-roam-unlinked-references-section
              ))
  (org-roam-setup))

;; startup with fullscreen
;; (add-hook 'window-setup-hook 'toggle-frame-maximized t)

(setq doom-font (font-spec :family "JetBrains Mono" :size 26)
      doom-big-font (font-spec :family "JetBrains Mono" :size 36)
      doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 25)
      doom-unicode-font (font-spec :family "Fira Code")
      doom-serif-font (font-spec :family "Fira Code" :weight 'light))

;; org mode
(after! org
  (setq org-use-speed-commands
        (lambda ()
          (and (looking-at org-outline-regexp)
               (looking-back "^\**")))))

(setq org-hide-emphasis-markers t)

;; (setq org-ellipsis "↴")
(setq org-ellipsis " ▼")
;; (setq
;; org-superstar-headline-bullets-list '("⁖" "◉" "○" "✸" "✿")
;; )

(add-hook 'org-mode-hook (lambda ()
                           "Beautify Org Checkbox Symbol"
                           (push '("[ ]" .  "☐") prettify-symbols-alist)
                           (push '("[X]" . "☑" ) prettify-symbols-alist)
                           (push '("[x]" . "☑" ) prettify-symbols-alist)
                           (push '("[-]" . "❍" ) prettify-symbols-alist)
                           (prettify-symbols-mode))
          )

;; log timestamp when TODO items are done
(setq org-log-done 'time)

(setq org-roam-graph-executable "/opt/homebrew/bin/dot")
(setq org-display-remote-inline-images t)
(setq org-roam-completion-everywhere t)

(use-package org-mind-map
  :init
  (require 'ox-org)
  :config
  (setq org-mind-map-engine "dot")       ; Default. Directed Graph
  (setq org-mind-map-dot-command "/opt/homebrew/bin/dot")
  (setq org-mind-map-unflatten-command "/opt/homebrew/bin/unflatten")
  )

(org-babel-do-load-languages
 'org-babel-load-languages
 '((plantuml . t)
   (python . t)
   (latex . t)))

;; dashboard
;; dashboard icon
(setq fancy-splash-image "~/.emacs.d/images/emacs-gnu-logo.png")
;; default buffer name
(setq doom-fallback-buffer-name "► Doom"
      +doom-dashboard-name "► Doom")
;; statusbar
(setq doom-modeline-height 10)
(custom-set-faces
 '(mode-line ((t (:family "MesloLGS NF" :height 0.6))))
 '(mode-line-inactive ((t (:family "Noto Sans" :height 0.6)))))
(display-time-mode 1)

;; open window right and bottom
(setq evil-vsplit-window-right t
      evil-split-window-below t)
;; window naviagtion
(map! :map evil-window-map
      "SPC" #'rotate-layout
      ;; Navigation
      "<left>"     #'evil-window-left
      "<down>"     #'evil-window-down
      "<up>"       #'evil-window-up
      "<right>"    #'evil-window-right
      ;; Swapping windows
      "C-<left>"       #'+evil/window-move-left
      "C-<down>"       #'+evil/window-move-down
      "C-<up>"         #'+evil/window-move-up
      "C-<right>"      #'+evil/window-move-right)

;; vim-sneak
(evil-snipe-override-mode 1)
;;
(setq-default major-mode 'org-mode)

;; plantuml
(setq plantuml-jar-path "~/plantuml.jar")
(setq plantuml-default-exec-mode 'jar)

;; company
(set-company-backend!
  '(text-mode
    markdown-mode
    gfm-mode
    org-mode)
  '(:seperate
    company-capf
    company-keywords
    company-files
    company-ispell
    company-dabbrev
    company-yasnippet))


(setq markdown-command "markdown | smartypants")


  (use-package org-tree-slide
    :custom
    (org-tree-slide-slide-in-effect t)
    (org-tree-slide-activate-message "Presentation started!")
    (org-tree-slide-deactivate-message "Presentation finished!")
    (org-tree-slide-header t)
    (org-tree-slide-breadcrumbs " > ")
    (org-image-actual-width nil))


  (with-eval-after-load "org-tree-slide"
    (define-key org-tree-slide-mode-map (kbd "<f7>") 'org-tree-slide-move-previous-tree)
    (define-key org-tree-slide-mode-map (kbd "<f9>") 'org-tree-slide-move-next-tree)
    )

  ;;
  (add-hook! 'org-mode-hook #'doom-disable-line-numbers-h)

  ;; for org presentation using html
  (setq org-reveal-root "https://revealjs.com/")
  (setq org-reveal-title-slide nil)

  ;;
  ;; keyword
  (after! hl-todo
    (setq hl-todo-keyword-faces
	  `(
            ;; ("NOTICE" . "#FFFF00")
	    ;; ("notice" . "#FFFF00")
	    ("NOTICE" . "#cc9393")
	    ("notice" . "#cc9393")
            ("HOLD" . "#d0bf8f")
            ("TODO" . "#cc9393")
            ("todo" . "#cc9393")
            ("NEXT" . "#dca3a3")
            ("THEM" . "#dc8cc3")
            ("PROG" . "#7cb8bb")
            ("OKAY" . "#7cb8bb")
            ("DONT" . "#5f7f5f")
            ("FAIL" . "#8c5353")
            ("DONE" . "#afd8af")
            ("NOTE"   . "#d0bf8f")
            ("KLUDGE" . "#d0bf8f")
            ("HACK"   . "#d0bf8f")
            ("TEMP"   . "#d0bf8f")
            ("FIXME"  . "#cc9393")
            ("Fixme"  . "#cc9393")
            ("XXX+"   . "#cc9393")
	    )))
  ;; clippy
  (map! :leader
        (:prefix ("c h" . "Help info from Clippy")
         :desc "Clippy describes function under point" "f" #'clippy-describe-function
         :desc "Clippy describes variable under point" "v" #'clippy-describe-variable))

  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize))

  (setenv "PATH" (shell-command-to-string "echo -n $PATH"))
  (setenv "PATH" (concat ":/Library/TeX/texbin/" (getenv "PATH")))
  (add-to-list 'exec-path "/Library/TeX/texbin/")

  ;; rime
  (use-package rime
    :custom
    (default-input-method "rime")
    (rime-librime-root "~/.emacs.d/librime/dist")
    (rime-emacs-module-header-root "/opt/homebrew/Cellar/emacs-plus@27/27.2/include")
    )
  (setq rime-user-data-dir "~/Library/Rime")
  (setq rime-disable-predicates
        '(rime-predicate-evil-mode-p
          rime-predicate-after-alphabet-char-p))

;; horizontal scroll
(setq mouse-wheel-tilt-scroll t)
;;
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)
;;
(setenv "JAVA_HOME"  "/Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home/")
(setq lsp-java-java-path "/Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home/bin/java")
(setq lsp-java-server-install-dir "~/.emacs.d/eclipse.jdt.ls/")

;;
