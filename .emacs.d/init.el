;; dont pollute this file with cutomize
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(require 'package)


(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(add-hook 'c-mode-common-hook (lambda ()
                                (setq c-basic-offset 4)
                                (setq c-default-style "linux") ; or "bsd", "k&r", etc.
                                ))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  ;; Prefix for lsp-command-map (C-c l ...)
  (setq lsp-keymap-prefix "C-c l")

  ;; Performance / UX settings
  (setq lsp-enable-symbol-highlighting t
        lsp-enable-snippet t
        lsp-prefer-flymake nil) ;; prefer flycheck if present

  :hook ((c-mode          . lsp-deferred)
         (c++-mode        . lsp-deferred)
         (python-mode     . lsp-deferred)
         (rust-mode       . lsp-deferred)
         (go-mode         . lsp-deferred)
         (js-mode         . lsp-deferred)
         (js-ts-mode      . lsp-deferred)
         (typescript-mode . lsp-deferred)
         (tsx-ts-mode     . lsp-deferred)
         (lua-mode        . lsp-deferred)
         (sh-mode         . lsp-deferred)))

;; UI extras (hover docs, sideline info)
(use-package lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode)

;; Company for completions (via capf)
(use-package company
  :config
  (global-company-mode 1))

(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-capf))

(with-eval-after-load 'company
  ;; Don't let company grab C-h while the popup is active
  (define-key company-active-map (kbd "C-h") nil)
  ;; Optional: also free up F1 as help
  (define-key company-active-map (kbd "<f1>") nil))

(with-eval-after-load 'company
  ;; Enter = newline
  (define-key company-active-map (kbd "<return>") nil)
  (define-key company-active-map (kbd "RET") nil)
  (define-key company-active-map (kbd "C-m") nil)

  ;; Explicit completion keys
  (define-key company-active-map (kbd "C-<return>") #'company-complete-selection))

(use-package org
  :mode (("\\.org\\'" . org-mode))
  :ensure nil
  :config
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  ;; Babel behavior
  (setq org-confirm-babel-evaluate nil)
  (setq org-export-babel-evaluate nil)

  ;; Org directory
  (setq org-directory (expand-file-name "~/Documents/org/")))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (python . t)))

(require 'org-tempo)

(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))

(defun my-md-mode-hook ()
  (define-key markdown-mode-map (kbd "C-v") #'markdown-next-visible-listing)
  (define-key markdown-mode-map (kbd "M-v") #'markdown-previous-visible-listing))
(add-hook 'markdown-mode-hook #'my-md-mode-hook)

(defun my-org-mode-hook ()
  (define-key org-mode-map (kbd "C-v") #'org-next-visible-heading)
  (define-key org-mode-map (kbd "M-v") #'org-previous-visible-heading))
(add-hook 'org-mode-hook #'my-org-mode-hook)

(when (daemonp)
  (with-current-buffer (find-file-noselect "~/.emacs.d/Emacs.org")
    (org-babel-tangle)))

;; Global todos file
(setq org-default-notes-file (expand-file-name "todos.org" org-directory))

;; Ensure org directory + todos file exist
(unless (file-directory-p org-directory)
  (make-directory org-directory t))

(unless (file-exists-p org-default-notes-file)
  (with-temp-file org-default-notes-file
    (insert "#+title: Todos\n\n* Inbox\n* Tasks\n* Done\n")))

;; Agenda should only use this file
(setq org-agenda-files (list org-default-notes-file))

(setq org-todo-keywords
      '((sequence "TODO(t)" "WIP(w)" "BLOCKED(b)" "|" "DONE(d)" "CANCELLED(c)")))

(setq org-capture-templates
      `(("t" "Todo" entry
         (file+headline ,org-default-notes-file "Inbox")
         "* TODO %?\n  %U\n  %a\n"
         :empty-lines 1)
        ("n" "Note" entry
         (file+headline ,org-default-notes-file "Inbox")
         "* %?\n  %U\n  %a\n"
         :empty-lines 1)))

;; Keybindings
(global-set-key (kbd "C-c c") #'org-capture)
(global-set-key (kbd "C-c a") #'org-agenda)

(use-package avy
  :bind
  (("M-j" . avy-goto-char)
   ("M-J" . avy-goto-char-2)))

(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)
(setq visible-bell nil)

(set-face-attribute 'default nil :font "Cousine Nerd Font Mono" :height 280)

(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'none)

(column-number-mode)
(global-display-line-numbers-mode t)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)


(dolist (mode '(org-mode-hook
		term-mode-hook
		eshell-mode-hook
		helpful-mode-hook))
  
(add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil))

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("Tab" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previoud-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package nerd-icons
  ;; :custom
  ;; The Nerd Font you want to use in GUI
  ;; "Symbols Nerd Font Mono" is the default and is recommended
  ;; but you can use any other Nerd Font if you want
  ;; (nerd-icons-font-family "Symbols Nerd Font Mono")
  )


(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package doom-themes
  :config
  (load-theme 'doom-gruvbox t)
  (doom-themes-org-config))

(setq scroll-conservatively 10
      scroll-margin 15)

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))


(use-package helpful
  :ensure t
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Documents/projects/code")
    (setq projectile-project-search-path '("~/Documents/projects/code")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package magit
  :commands (magit-status magit-blame)
  :bind (("C-x g" . magit-status))
  :config
  ;; Save buffers automatically when invoking Magit commands
  (setq magit-save-repository-buffers 'dontask)

  ;; Use the full frame for commit messages (optional)
  (setq git-commit-fill-column 72
        git-commit-summary-max-length 50)

  ;; Show word-level diffs by default
  (setq magit-diff-refine-hunk 'all))

(use-package dap-mode
  :after lsp-mode
  :commands (dap-debug dap-debug-edit-template)
  :init
  ;; Let dap auto-wire UI pieces for common workflows.
  (setq dap-auto-configure-features
        '(locals controls tooltip))
  :config
  ;; Turn on the global modes that make it feel "GUI-ish".
  (dap-auto-configure-mode 1)
  (dap-ui-mode 1)
  (dap-tooltip-mode 1)
  (tooltip-mode 1)
  (dap-ui-controls-mode 1))

;; C/C++/Rust via VS Code C++ tools (cpptools).
(use-package dap-cpptools
  :ensure nil
  :after dap-mode
  :config
  ;; One-time helper to download the VS Code C++ extension and set up the
  ;; debug adapter. You can comment this out after the first run if you want.
  (dap-cpptools-setup))

;; Go debugging via Delve (dlv dap).
(use-package dap-dlv-go
  :ensure nil
  :after dap-mode)

;; Python debugging via debugpy.
(use-package dap-python
  :ensure nil
  :after dap-mode
  :config
  ;; Optionally tell dap-python how to find your interpreter.
  ;; (setq dap-python-executable "python3")
  )

;; Node.js debugging (JS/TS via node adapter).
(require 'dap-node)

;; You may need to customize this to point at the JS debug adapter you install.
;; Example (adjust paths to your system):
;;
;; (dap-register-debug-provider "node"
;;   (lambda (conf)
;;     (plist-put conf :debugServer 4711)
;;     conf))
;;
;; (dap-register-debug-template
;;  "Node::current file"
;;  (list :type "node"
;;        :request "launch"
;;        :name "Node::current file"
;;        :program "${file}"
;;        :cwd "${workspaceFolder}"
;;        :runtimeExecutable "node"))
