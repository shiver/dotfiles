;;; package --- Summary
;;; Commentary:

(require 'package)
(setq package-enable-at-startup nil)

;; Setup package repositories
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Allows preview of packages
(use-package try
  :ensure t)

;; Shows possible options for "next" key combinations
(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package ace-window
  :ensure t
  :init
  (global-set-key [remap other-window] 'ace-window)
  (custom-set-faces
     '(aw-leading-char-face
       ((t (:inherit ace-jump-face-foreground :height 3.0)))))
  )

(use-package auto-complete
  :ensure t
  :config
  (ac-config-default)
  (global-auto-complete-mode t))

(use-package multiple-cursors
  :ensure t
  :init
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this))

(use-package neotree
  :ensure t)

(use-package magit
  :ensure t)

(use-package git-gutter+
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'git-gutter+-mode))

(use-package git-gutter-fringe+
  :ensure t)

(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :init
  (setq-default flycheck-idle-change-delay 0.5
                flycheck-check-syntax-automatically '(mode-enabled save))
  :config
  (add-hook 'prog-mode-hook #'flycheck-mode))

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode t))

(use-package smartparens
  :ensure t)

(use-package counsel
  :ensure t
  :defer t)

(use-package rainbow-delimiters
  :ensure t)

(use-package rainbow-mode
  :ensure t
  :diminish rainbow-mode)

(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (global-set-key "\C-s" 'swiper)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "<f6>") 'ivy-resume)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
  (define-key read-expression-map (kbd "C-r") 'counsel-expression-history))

(use-package projectile
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'projectile-mode))

(use-package counsel-projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (counsel-projectile-mode))

(use-package eyebrowse
  :ensure t
  :config
  (eyebrowse-mode t))

(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "C-@") 'er/expand-region))


;;; Programming languages

;; PHP (oh god T_T)
(use-package ac-php
  :ensure t)

(use-package php-mode
  :ensure t
  :init
  (setq flycheck-phpcs-standard "PSR2")
  :config
  (add-hook 'php-mode-hook 'php-mode-psr2-hook)
  (add-hook 'php-mode-hook (lambda () (c-set-offset 'case-label 4)))
  (add-hook 'php-mode-hook (lambda () (c-set-offset 'statement-case-intro 4)))
  (add-hook 'php-mode-hook (lambda () (c-set-offset 'statement-cont 4))))

(add-hook 'php-mode-hook
	  '(lambda ()
	     (setq ac-sources '(ac-source-php))
	     (ac-php-core-eldoc-setup)
	     (define-key php-mode-map (kbd "C-]") 'ac-php-find-symbol-at-point)
	     (define-key php-mode-map (kbd "C-t") 'ac-php-location-stack-back)
	     ))

;; GO
(use-package go-autocomplete
  :ensure t)

;; C/C++
(use-package irony
  :ensure t)

;; Rust
(use-package rust-mode
  :ensure t
  :interpreter
  ("rust" . rust-mode)
  :init
  (setq rust-format-on-save t))

(use-package flycheck-rust
  :ensure t
  :after rust-mode
  :config
  (add-hook 'flycheck-mode-hood #'flycheck-rust-setup))

(use-package cargo
  :ensure t
  :diminish cargo-minor-mode
  :hook (rust-mode . cargo-minor-mode))

(use-package company
  :ensure t
  :diminish company-mode)

(use-package racer
  :ensure t
  :diminish racer-mode
  :hook (rust-mode . racer-mode)
  :bind (:map rust-mode-map
              ("<Tab>" . company-indent-or-complete-common)
              ("C-c C-d" . racer-describe))
  :init
  (setq company-tooltip-align-annotations t)
  :config
  (add-hook 'racer-mode-hook #'eldoc-mode)
  (add-hook 'racer-mode-hook #'company-mode))


;; Common modes to be enabled when coding
(add-hook 'prog-mode-hook #'linum-mode)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook #'smartparens-mode)

(setq inhibit-startup-message t)
(defalias 'list-buffers 'ibuffer-other-window)

;; Disable audio alter sound
(setq visible-bell t)

;; Visual decluttering
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq select-enable-clipboard t)

(add-to-list 'auto-mode-alist '("\\.org.gpg\\'" . org-mode))

;; Setup global package agnostic key binds
(global-set-key (kbd "C-x k") #'kill-this-buffer)
(global-set-key (kbd "C-x k") #'kill-this-buffer)

;; Centralise backup files
(setq backup-directory-alist `((".*" . "~/.emacs.d/.tmp")))

;; Spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; "How can I replace highlighted text with what I type?" (Emacs FAQ)
(delete-selection-mode 1)

;; Auto reload changes to files
(global-auto-revert-mode 1)

;; Use y/n instead of yes/no
(defalias 'yes-or-no-p 'y-or-n-p)

;; Always trim trailing whitespace on save
(add-to-list 'write-file-functions #'delete-trailing-whitespace)

;; Look & Feel
(use-package atom-dark-theme
  :ensure t)

(load-theme 'atom-dark t)

;; Set the default font
(set-frame-font
 (cond ((eq system-type 'windows-nt) "Tamsyn6x12")
       ((eq system-type 'gnu/linux) "Hack 9")
       ((eq system-type 'darwin) "Hack 9")))


(provide 'init)
;;; init.el ends here


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (go-autocomplete go-mode smartparens ivy helm atom-dark-theme yasnippet flycheck auto-complete magit php-mode ace-window org-bullets which-key try use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:foreground "#c5c8c6" :background "#1d1f21" :weight normal :slant normal :underline nil :overline nil :strike-through nil :box nil :inverse-video nil :stipple nil :inherit nil))))
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0)))))
