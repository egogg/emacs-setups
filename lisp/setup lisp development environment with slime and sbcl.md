Setup Lisp Development Environment with SLIME and SBCL
=======================================================

This is a note about setting up Lisp development environment on emacs with SLIME and SBCL. SLIME is a Emacs mode for Common Lisp development. Steel Bank Common Lisp (SBCL) is a high quality implement of Common Lisp.

Requirements and Links
-----------------------

We assume that Emacs has been successfully installed on your system.

Following are the homepage of SLIME and SBCL:

* [SLIME](http://common-lisp.net/project/slime/): (http://common-lisp.net/project/slime/)
* [SBCL](http://www.sbcl.org/): (http://www.sbcl.org/)

Download the corresponding codes and install them following the corresponding manuals.

Installation
-----------------------

### SLIME: 

Follow the instructions in the manual.

`Ctrl-x Ctrl-f ~/.emacs` to open emacs configuration file, the installation codes for SLIME may look like this:

	(setq inferior-lisp-program "d:/lisp/sbcl/sbcl.exe") ; Lisp system
	(add-to-list 'load-path "d:/lisp/slime/")  ; SLIME directory
	(require 'slime)
	(slime-setup '(slime-fancy))

Please make sure that the directory are set correctly. Note that we use `(slime-setup '(slime-fancy))` command to load REPL and all other contribs.

### SBCL: 

Installation of SBCL under Windows is quite easy and just follow the instructions of the installation wizard.

Usage Examples
-----------------------

### 1. Slime mode

`M-x slime` to enable the slime mode. Startup information will be shown up in a new buffer named *inferior-lisp*. When the command prompt appears, you can input lisp command.

	* (+ 3 5)

	8

### 2. Create a new lisp file

Use `Ctrl-x Ctrl-f` to create a new lisp file. For example:

	(defun hello-world ()
  		(format t "Hello, World!")
	)

`Ctrl-x Ctrl-s` to save the file. `Ctrl-c Ctrl-c` command will compile the lisp file. When successfully compiled, following message may appears in the *inferior-lisp* buffer.

	; compiling (DEFUN HELLO-WORLD ...)

Then you can execute the following command:
	
	(hello-world)
	Hello, World!
	NIL

Now we have successfully compiled and executed a lisp file. For more information about using SLIME, please refer to the SLIME manual.