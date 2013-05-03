;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Basic Settings                                                  ;;
;;                                                                 ;;
;; [*] Theme                                                       ;;
;; [*] Backup files                                                ;;
;; [*] Start-up screen & toolbar                                   ;;
;; [*] Speedbar                                                    ;;
;; [*] Window size & position                                      ;;
;; [*] Line numbers                                                ;;
;; [*] Auto pair                                                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; [*] Theme

(load-theme 'tango-dark)

;; [*] Backup files

(setq make-backup-files nil) ; no backup files

;; [*] Start-up screen and toolbar

(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)
(tool-bar-mode -1)
(toggle-scroll-bar -1)

;; [*] Speedbar

(setq speedbar-use-images nil)

(add-to-list 'load-path "~/.emacs.d/sr-speedbar")
(require 'sr-speedbar)
(setq sr-speedbar-skip-other-window-p t)
(setq sr-speedbar-right-side nil)
(global-set-key (kbd "<f12>") 'sr-speedbar-toggle)
(add-hook 'speedbar-mode-hook '(lambda () (linum-mode -1)))

;; [*] Window size & position

(add-to-list 'default-frame-alist '(height . 42))
(add-to-list 'default-frame-alist '(width . 111))
(add-to-list 'default-frame-alist
	     (cons 'top (/ (- (x-display-pixel-height)
			      (* 42 (frame-char-height)) 60) 2)))
(add-to-list 'default-frame-alist
	     (cons 'left (/ (- (x-display-pixel-width)
			       (* 111 (frame-char-width))) 2)))

;; [*] Line numbers

(global-linum-mode t)
(setq linum-format " %4d\u2502")
(setq line-number-mode t)
(setq column-number-mode t)

;; [*] Auto pair

(electric-pair-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Lisp development environment SLIME & SBCL                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq inferior-lisp-program "d:/lisp/sbcl/sbcl.exe") ; Lisp system
(add-to-list 'load-path "d:/lisp/slime/") ; SLIME directory
(require 'slime)
(slime-setup)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C/C++ development environment                                   ;;
;;                                                                 ;;
;; [*] Auto-pair                                                   ;;
;; [*] Auto-complete                                               ;;
;; [*] Clang                                                       ;;
;; [*] Yasnippet                                                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; [*] Auto pair

(defun custom-c-mode-auto-pair ()
  (interactive)
  (make-local-variable 'skeleton-pair-alist)
  (setq skeleton-pair-alist '((?{ \n > _ \n ?} >)))
  (setq skeleton-pair t)
  (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
  )

; C-Style

(defconst custom-c-style
  '((c-backslash-column . 80) 
    (c-backslash-max-column . 80)
    (c-offsets-alist .
		     ((inextern-lang . 0)
		      (substatement . 0)
		      (statement-case-intro . 0)
		      (substatement-open . 0)
		      (case-label . +)
		      (block-open . 0))))
  "Custom C programming style"
  )
(c-add-style "Custom" custom-c-style)
(defun custom-c-mode-common-hook ()
  (c-set-style "Custom") ; Custom C-Style
  (setq c-basic-offet 4) ; Tab size
  (c-toggle-hungry-state 1) ; Hungry delete
  (custom-c-mode-auto-pair) ; Auto-pair hook
  )
(add-hook 'c-mode-common-hook 'custom-c-mode-common-hook)

;; [*] Auto-complete

(add-to-list 'load-path "~/.emacs.d/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories
	     "~/.emacs.d/auto-complete/ac-dict")
(ac-config-default)

; Trigger auto-complete with TAB Key

(setq ac-auto-start nil)
(ac-set-trigger-key "<tab>")

; Use C-n and C-p to select candiates, use SPACE to complete

(define-key ac-completing-map (kbd "SPC") 'ac-complete)
(setq ac-use-menu-map t)
(define-key ac-menu-map (kbd "C-n") 'ac-next)
(define-key ac-menu-map (kbd "C-p") 'ac-previous)

;; [*] Clang

(add-to-list 'load-path "~/.emacs.d/auto-complete-clang")
(require 'auto-complete-clang)
(defun ac-clang-setup ()
  (setq ac-sources (append '(ac-source-clang) ac-sources))
)
(add-hook 'c-mode-hook 'ac-clang-setup)
(add-hook 'c++-mode-hook 'ac-clang-setup)

;; [*] Yasnippet

(add-to-list 'load-path "~/.emacs.d/yasnippet")
(require 'yasnippet)
(setq yas-snippet-dirs '("~/.emacs.d/yasnippet/snippets"))
(yas-global-mode 1)
