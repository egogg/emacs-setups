Emacs Basic settings
=======================================================

Here are some basic settings to make emacs more usable.

Theme
---------------------

You can preview and choose themes from menu `Options->Customize Emacs->Custom Themes`. Here I use `tango-dark`.

	(load-theme 'tango-dark)

Backup files
---------------------

Backup files are quite annoying, to close it:

	(setq make-backup-files nil)

Start up screens and toolbar
------------------------------

### Start up screen

Disable the default start up screen:

	(setq inhibit-startup-screen t)
	(setq initial-scratch-message nil)

### Toolbar and scroll-bar

Disable toolbar and scroll bar:

	(tool-bar-mode -1)
	(toggle-scroll-bar -1)

Speedbar
-------------------------------

We use sr-speedbar (http://www.emacswiki.org/SrSpeedbar) to browse files and folders. Here we install it into the folder `~/.emacs.d/sr-speedbar`. The basic settings are as following:

	(setq speedbar-use-images nil)
	(add-to-list 'load-path "~/.emacs.d/sr-speedbar")
	(require 'sr-speedbar)
	(setq sr-speedbar-right-side nil)
	(global-set-key (kbd "<f12>") 'sr-speedbar-toggle)
	(add-hook 'speedbar-mode-hook '(lambda () (linum-mode -1)))

The last line is to disable line number visibility in speedbar buffer. The key `[F12]` is binding to toggle the speedbar window.

Windows size and initialize position
-------------------------------------

The unit of the size is character width. The initialize position of the emacs window is set approximately to the center of the screen. In the following example, the height of the Windows system taskbar is set about 30 pixel height which may be not very accurate on other systems.

	(add-to-list 'default-frame-alist '(height . 42))
	(add-to-list 'default-frame-alist '(width . 111))
	(add-to-list 'default-frame-alist
		     (cons 'top (/ (- (x-display-pixel-height)
				      (* 42 (frame-char-height)) 60) 2)))
	(add-to-list 'default-frame-alist
		     (cons 'left (/ (- (x-display-pixel-width)
				       (* 111 (frame-char-width))) 2))) 

Line numbers
---------------------------------------

Show line numbers at the left side:

	(global-linum-mode t)
	(setq linum-format " %4d\u2502")
	(setq line-number-mode t)
	(setq column-number-mode t)

Auto pair
--------------------------------------

We use autopair.el to full fill this function. Useful links include: EmacsWiki(http://www.emacswiki.org/emacs/AutoPairs), Github(https://github.com/capitaomorte/autopair). Please download the latest version of autopair.el and follow the install instructions in the manual. Basic setting may looks like:

	(add-to-list 'load-path "~/.emacs.d/auto-pair")
	(require 'autopair)
	(autopair-global-mode)

Here autopair.el is placed in the `~/.emacs.d/auto-pair` folder.


