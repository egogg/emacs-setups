Setup C/C++ Development Environment
=======================================================

This note is about setting up C/C++ development environment setups for Eamcas. The goal is to build a comfortable C/C++ coding environment. Fast coding is the king. 

Basic Settings
---------------------

### Line Number

Display Line number on the left side bar. You can either use command `M-x linum-mode` (or `M-x global-linum-mode`) temporarily toggle line numbers or you can put

	(global-linum-mode t)

in `~/.emacs` file to permanently show line numbers.
You can formate line numbers using the following commands:
	
	(setq linum-format "%4d \u2502")

Put these two lines in the `~/.emacs` files to show line number and column number on the bottom bar:
	
	(setq line-number-mode t)
	(setq column-number-mode t)

Relative commands about locating and counting lines including:
* [`M-x goto-line` / `M-g g`] Go to a specific line.
* [`M-x what-line`] Current line number. 
* [`C-x l`] Count lines and display current line.

### Auto-pair hook

There are several auto-pair choices. You can find the full list in EmacsWiki [Auto Pairs](http://www.emacswiki.org/emacs/AutoPairs). The most convenience one is electric-pair-mode which is the build-in function of Emacs (`(electric-pair-mode 1)`).

However for C and C++ coding we need some hooks. When we edit `{` and `}` pairs, we usually need a new line and indent between them, which usually cost two more steps with the common auto-pair modes: `{|}` + `C-b` + `C-j`. The hooks will insert the newline and indent automatically. 

	(defun custom-c-mode-auto-pair ()
  	(interactive)
  	(make-local-variable 'skeleton-pair-alist)
  	(setq skeleton-pair-alist  '((?{ \n > _ \n ?} >)))
  	(setq skeleton-pair t)
  	(local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
  	)

### C-Style

Full documentation of [CCMode](http://www.gnu.org/software/emacs/manual/html_node/ccmode/) can be found at (http://www.gnu.org/software/emacs/manual/html_node/ccmode/). 
The design philosophy of the following C-Style is: Always put block of statements between curly parentheses.

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

Auto Complete
----------------

Auto-complete and Clang back-end are used to achieve C/C++ semantic level smart completion.

### Requirements and Links

* [Auto-Complete](http://cx4a.org/software/auto-complete/): (http://cx4a.org/software/auto-complete/)
Auto Complete Mode is the most intelligent auto-completion extension for Emacs.
* [Clang](http://clang.llvm.org/): (http://clang.llvm.org/)
Clang is a powerful front-end for LLVM, it must be compiled and installed in the system. Make sure that the clang executable file has been set in the PATH environment variable. 
* [Auto-Complete-Clang](https://github.com/brianjcj/auto-complete-clang): (https://github.com/brianjcj/auto-complete-clang)
Use Clang as the back-end of auto-complete.

Download the corresponding codes and install them following the corresponding manuals.


### Auto Complete Mode

Installation instruction can be found in Auto Complete Mode user manual. The most easy step is using the following commands:
	
	$ emacs -batch -l etc/install.el

Example message may seem like:
	
	Successfully installed!
	Add the following code to your .emacs:
	(add-to-list 'load-path "~/.emacs.d/auto-complete")    ; This may not be appeared if you have already added.
	(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/ac-dict")
	(require 'auto-complete-config)
	(ac-config-default)

Here, we install the package in to `~/.emacs.d/auto-complete` folder. 
Without further configuration auto complete mode may works very well. The following two commands will make auto-complete triggered with TAB key.
	
	(setq ac-auto-start nil)
	(ac-set-trigger-key "<tab>") 

We set some key bindings that we can choose on the menu list with `C-P` and `C-n` commands and make complete with `SPC` key.

	(define-key ac-completing-map (kbd "SPC") 'ac-complete)
	(setq ac-use-menu-map t) 
	(define-key ac-menu-map (kbd "C-n") 'ac-next)
	(define-key ac-menu-map (kbd "C-p") 'ac-previous)

### Auto-complete-clang

Follow the installation instruction on the homepage of auto-complete-clang: (https://github.com/brianjcj/auto-complete-clang). Install in to the folder `~/.emacs.d/auto-complete-clang`:

	(add-to-list 'load-path "~/.emacs.d/auto-complete-clang")
	(require 'auto-complete-clang)
	(defun ac-clang-setup ()
	  (setq ac-sources (append '(ac-source-clang) ac-sources))
	)
	(add-hook 'c-mode-hook 'ac-clang-setup)
	(add-hook 'c++-mode-hook 'ac-clang-setup)

Code snippet
----------------------

We will use yasnippet to mange code templates and make keywords expansion.

### Requirements and Links

* [Yasnippet](https://github.com/capitaomorte/yasnippet): (https://github.com/capitaomorte/yasnippet)

### Installation

Follow the installation instruction from the manual to install Yasnippet. To install it to the folder `~/.emacs.d/yasnippet`:

	(add-to-list 'load-path "~/.emacs.d/yasnippet")
	(require 'yasnippet)
	(setq yas-snippet-dirs '("~/.emacs.d/yasnippet/snippets"))
	(yas-global-mode 1

Here are some tips about changing Yasnippet expansion key (which is TAB in default):

	(define-key yas-minor-mode-map [(tab)] nil)
	(define-key yas-minor-mode-map (kbd "TAB") nil)
	(define-key yas-minor-mode-map (kbd "C-<tab>") 'yas-expand)

When Yasnippet has been installed. We need to edit code templates / code snippets under folder `~/.emacs.d/snippets/cc-mode`. Refer to the manual for snippets format.


