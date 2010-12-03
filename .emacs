 ;;; emacs -rv -fn "*Lucida*" -l .emacs -*- mode:emacs-lisp; coding:utf-8 -*-
;; lucidasans-14; lucidasanstypewriter-14;
;; (i=0; while true; do i=`expr $i + 1`; echo -e "\n$i:"; sleep 1; rsync -av -e "ssh -l tester" ./ jubiler:/home/tester/tst/kraljo/projects/upower/hp+ilo+opforce/diagram3/; done )
;; from Red Hat Linux CZ 5.2
;; stu //osdir.com/ml/emacs-orgmode-gnu/2010-08/msg00168.html

;;(esc: +ěščě+)
;; c-x = ; what-cursor-position
;; c-u c-spc ; 'pops marks-ring
;; c-xm c ; universal-coding-system-argument ; and [M-x] revert-buffer ;doesnt work,do: C-xM c utf-8 C-MxvM ;see http://lists.gnu.org/archive/html/help-gnu-emacs/2005-02/msg00224.html
;; execute-kbd-macro ; (from S-M-:) can exec named kbd-macro more times
;; aok.el -- various useful ways to do `multi-occur'
;; redo ?; (vi) ^r
;;(c-mode)
;; c-ct ; toggles auto-newline and hungry-mode
;;delete-selection (mode & cua) - is what i was looking for by /emacs automatic delete region/ but found by /emacs delete transient/

;; (ide)
;; follow-mode ; 1 soubor do 2 sloupců
;; scroll-all-mode ; ~ neco k hledanemu rezimu skrolovani
;; ediff-toggle-multiframe

;; find-grep default: find . -type f -print0 | xargs -0 -e grep -nH -e ...

;; Podpora pro tisk multilinguálních dokumentů (včetně českých)
;; (load "emacs-cs-utils-init")
;; (load "intlfonts-init")

;; Nastavení českého slovníku pro kontrolu pravopisu
; (setq ispell-dictionary "czech")

;; Nastavení pro AuCTeX
(setq TeX-command-list
      '(("TeX" "csplain %t" TeX-run-interactive nil t)
	("LaTeX" "cslatex '\\nonstopmode\\input{%t}'" TeX-run-LaTeX nil t)
	("View" "%v " TeX-run-silent t nil)
	("Print" "%p " TeX-run-command t nil)
	("Queue" "%q" TeX-run-background nil nil)
	("File" "dvips %d -o %f " TeX-run-command t nil)
	("BibTeX" "bibtex %s" TeX-run-BibTeX nil nil)
	("Index" "csindex -z il2 %s" TeX-run-command nil t)
	("Check" "lacheck %s" TeX-run-compile nil t)
	("Spell" "<ignored>" TeX-run-ispell-on-document nil nil)
	("Other" "" TeX-run-command t t)
	("Makeinfo" "makeinfo %t" TeX-run-compile nil t)
	("AmSTeX" "amstex '\\nonstopmode\\input %t'" TeX-run-TeX nil t)
	("pdfCSTeX" "pdfcsplain '\\nonstopmode\\input %t'" TeX-run-TeX nil t)
	("pdfCSTeX Interactive" "pdfcsplain %t" TeX-run-interactive nil t)
	("pdfCSLaTeX" "pdfcslatex '\\nonstopmode\\input{%t}'" TeX-run-LaTeX nil t)
	("pdfCSLaTeX Interactive" "pdfcslatex %t" TeX-run-interactive nil t)
	("View PDF" "acroread %s.pdf" TeX-run-command nil t)
	("Generic TeX (non CS)" "tex %t" TeX-run-interactive nil t)
	("Generic LaTeX (non CS)" "latex '\\nonstopmode\\input{%t}'" TeX-run-LaTeX nil t)
	))

;; (load "auctex-init")

;;; Emacs info
;;(zone)

;;; dox
(setq after-change-function nil) ; http://sunsite.dk/pipermail/xae/2002-March/thread.html#157
;; docbook
;(require 'psgml)
;;(require 'table) ; http://cnx.rice.edu/content/m9004/latest/
;; (add-to-list 'sgml-catalog-files "/home/pep/html/docbook/dtd/CATALOG" )

;; (setq sgml-markup-faces '((start-tag . font-lock-function-name-face)
;; 			  (end-tag . font-lock-function-name-face)
;; 			  (comment . font-lock-comment-face)
;; 			  (pi . bold)
;; 			  (sgml . bold)
;; 			  (doctype . bold)
;; 			  (entity . font-lock-type-face)
;; 			  (shortref . font-lock-function-name-face)))
;; (setq sgml-set-face t)
;; (setq-default sgml-indent-data nil)
;; (setq sgml-mode-hook
;;           '(lambda ()
;;              (setq fill-column 70
;;                    indent-tabs-mode nil
;;                    next-line-add-newlines nil
;;                    standard-indent 4)
;;              (auto-fill-mode t))) ; http://www.freebsd.org/doc/en_US.ISO8859-1/books/fdp-primer/psgml-mode.html
;; ;; Some convenient key definitions:
;; (define-key sgml-mode-map "\C-c\C-x\C-e" 'sgml-describe-element-type)
;; (define-key sgml-mode-map "\C-c\C-x\C-i" 'sgml-general-dtd-info)
;; (define-key sgml-mode-map "\C-c\C-x\C-t" 'sgml-describe-entity)

;; load
(setq load-path ; For great justice, add ~/elisp to our load-path.
; (push "/sw/bin" exec-path) ;(append (list (expand-file-name "~/.emacs.d/docbookide/"))
      (append (list
	       (expand-file-name "~/.emacs.d/")
	       (expand-file-name "~/.emacs.d/site-lisp/")
	       ) load-path))

(add-to-list 'load-path "~/.emacs.d/site-lisp/muse/lisp")
; (require 'muse-mode)

;;; cz:
;;  czech-prog-1 ... +ěš-=[]
;;  czech-prog-2 ... ůěš-=[]
;;  czech-prog-3 ... 1ěš-=úů

;;; desktop
;(find-file "/home/pep/.scippie/txt/2do/2do.u8.txt")

;; Just tnx 4 1key-run
(defun my_call_occur ()
  "Find lines matching"
  (interactive)
  (occur (current-word)))
(global-set-key (read-kbd-macro "<f1>") 'my_call_occur)

;; atrey.karlin.mff.cuni.cz/~qiq/src/avfs-cvs/scripts/avfscoda.el
;; If a path begins with #, prevent ange-ftp in handling it.
;; Written by David Hanak <dhanak@inf.bme.hu>
(defun avfs-normal-find-file-handler (op &rest args)
  (let ((file-name-handler-alist
	 (apply
	  'append
	  (mapcar '(lambda (itm)
		     (unless (string-match "^ange-ftp-\\|^avfs-"
					   (symbol-name (cdr itm)))
		       (list itm)))
		  file-name-handler-alist))))
    (apply op args)))

(or (assoc "^/#" file-name-handler-alist)
    (setq file-name-handler-alist
	  (cons '("^/#" . avfs-normal-find-file-handler)
		file-name-handler-alist)))

;; truncating is sometimes good
;; even buff nfo is good: M-= count-lines-region
(setq truncate-partial-width-windows nil)
(global-set-key [M-f2] 'toggle-truncate-lines) 
(global-set-key [f2] 'toggle-truncate-lines) ; but it should run 2C-mode?
(global-set-key [f3] 'auto-fill-mode)
(global-set-key [kp-f3] 'auto-fill-mode)
(global-set-key [insertchar] 'overwrite-mode)
(defun my-open-file "on cursor point by tramp" (setq t "require tramp..."))
(global-set-key [f4] 'speedbar) ;(global-set-key [f4] 'speedbar)

(defun load-tramp ()
  "06-07-26 
  nok:( .. /ssh:kraljo@jedi:
  works .. /ssh:kralj@localhost:
  "
  (interactive)
  (setq load-path 
	(append (list (expand-file-name "~/.emacs.d/site-lisp/tramp-from-src")
		      ) load-path))
  (require 'tramp)
  (setq file-name-handler-alist 
	'(("\\.Z\\(~\\|\\.~[0-9]+~\\)?\\'\\|\\.bz2\\'\\|\\.tgz\\'\\|\\.g?z\\(~\\|\\.~[0-9]+~\\)?\\'" 
	   . jka-compr-handler) 
	  ("\\`/\\[.*\\]" 
	   . tramp-file-name-handler) ;avfs-normal-find-file-handler) 
	  ("^/[^/:]*\\'" 
	   . ange-ftp-completion-hook-function) 
	  ("^/[^/:]*[^/:.]:" 
	   . tramp-file-name-handler) ;ange-ftp-hook-function) 
	  ("\\`/:" 
	   . file-name-non-special)))
  (setq tramp-default-method "ssh")
  )

;;; auto-env
;; in term:
;; - every of those keys should restart term-curr_row..
;; (in char-mode):<SPC>..->line-mode # because in in line-mode it is already used for typing
;; (in line-mode):
;;  - C-l,C-m,C-r,C-xs..->char-mode,
;;  - C-s..<>C-r,but in this case (<CR>when-not-eof)->(char-mode)&run searched command without prompt!
;;    (first <CR> copy it (for editing) and the second <CR> enter it)
;;  - C-a..->
;;    (if somewhere more after last prompt,mark&) jump after prompt.
;;    (if at prompt, if could) jump back
;;    (file/process marker should be hilighted)
;;  - C-m,<CR>..-> sends whole multiline
;; (not-recomended tips:) for long commands in char-mode - use dump term. (but in future use line-mode with this ^^ features it will be enough:)
;;  - C-xs..->save -> automaticaly please (by 1sec?).
;;
;; 2do:
;; - shorten tramp-run-term timeout
;; - colorize
;; - fast keys <M-fX> to switching between task-shells (eg. pml<>prl<>root<>spmaster) - all by suspend/screen how will be defined?
;;   (for usual cases - suspend seems better, because if i wanna see events from another/suspended shell, it should be by file - its real TR sync
;;   (but by .exp sess. controller it it will be posible appending output from another shell/window)
;; - (&^) another (emacs) window should be able to scroll/anchor another (suspended) shell io
;;   (but in future it should be by firefox panel - see twin-panel)
;;   (of course .exp controller will be able to add it even to e/text console)
;;
;; F5 : Toggle Shell + cd 
;; a-= ; (term) sends raw-meta
;; - by default should run term 
;; - should ask for prependig-file
;; - (mainly) in dired - should open another windows by spliting down (if it is not present already:)
(defun my-shell ()
  "Start a shell in the directory of current buffer"
  (interactive)
  (if (eq buffer-file-name nil) (setq my-file-dir default-directory)
    (setq my-file-dir (file-name-directory buffer-file-name)))
  (setq my-file-dir (expand-file-name my-file-dir))
  (switch-to-buffer my-file-dir)
  (shell my-file-dir))
(global-set-key (read-kbd-macro "<f5>") 'my-shell)

(defun my-toggle-trailing-whitespace ()
  "hmm - inspired by gnus-sum.el '(defun gnus-summary-toggle-truncation*)"
  (interactive)
  (setq show-trailing-whitespace (not show-trailing-whitespace))
  (redraw-display))
(setq show-trailing-whitespace t) ; (my-toggle-trailing-whitespace)

(global-set-key [f6] 'my-toggle-trailing-whitespace)
(global-set-key [f7] 'toggle-read-only)
(global-set-key [f8] 'call-last-kbd-macro)
(global-set-key [f9] 'compile)

;; For programming
;; ;use ^SPC ^r... M-d ^x^SPC
;; (fset 'my-cpl ((compile)(other-window)))
;; (global-set-key [f9] 'my-cpl)

(fset 'scl-right "\C-[1\C-x<")
  (global-set-key (read-kbd-macro "ESC <right>") 'scl-right)
(fset 'scl-left "\C-[1\C-x>")
  (global-set-key (read-kbd-macro "ESC <left>") 'scl-left)

;; my-own - pep 2005-05-02
(require 'cl)
(setq esc "ěščřžýáíéóúůďťňäëöü÷ĚŠČŘŽÝÁÍÉÓÚŮĎŤŇÄËÖÜ")
(setq asc "escrzyaieouudtnaeou-ESCRZYAIEOUUDTNAEOU")
(defun cs1-to-asc ()
  "translate buffer according above table"
  (interactive)
  (save-excursion
    (overwrite-mode nil)
    (goto-char (point-min))
    (while (not (eq (point) (point-max)))
      ;; (kill-region (point)
      ;; (+ 1 (point)))
      ;; (setq s (string-to-char (car kill-ring)))
      (setq c (following-char))
      (setq us ; unibyte-string
	    (encode-coding-string (char-to-string c) 'utf-8))
      (setq c (string-to-char (decode-coding-string us 'utf-8)))
      (if (setq ix (position c esc))
	  (progn (setq c (string-to-char (substring asc ix (+ 1 ix))))
		 ;; (read-from-minibuffer (format "ch: %s (%d) at-buff: %d in-transl: %d" s s (point) ix)))
		 (read-from-minibuffer 
		  (format "ch: %s (%d) at-buff: %d in-transl: %d" us c (point) ix)))
	(read-from-minibuffer (format "ch: %s (%d) at-buff: %d is-not there" us c (point))))
      ;; (self-insert-command c)
      (delete-char 1)
      (insert-char c 1)
      (read-from-minibuffer (format "ch: %s just inserted.." us)) 
      ;;(goto-char (+ 1 (point)))
      )
    (overwrite-mode nil)))

(defun cs-to-asc ()
  "Translate buffer according above table. 
   Next should recognize selected region."
  (interactive)
  (save-excursion
    (overwrite-mode 1)
    (goto-char (point-min))
    (while (not (eq (point) (point-max)))
      (setq c (following-char))
      (setq us ; unibyte-string
	    (encode-coding-string (char-to-string c) 'utf-8))
      (setq c (string-to-char (decode-coding-string us 'utf-8)))
      (if (setq ix (position c esc))
	  (setq c (string-to-char (substring asc ix (+ 1 ix)))))
      (delete-char 1)
      (insert-char c 1))
    (overwrite-mode nil)))
(global-set-key (read-kbd-macro "\C-x\C-a") 'cs-to-asc)

;; Utils to browsing file lists
(fset 'hide-find-dir
   [?\C-j ?\C-k ?\C-y ?\C-a ?\C-n ?\C-\M-% ?\C-y ?. ?* ?\C-q ?\C-j ?\C-m ?. return ?! ?\C-j ?\C-j])
	; do $find, goto appropriate line and [f9]
;; (global-set-key [f9] 'hide-find-dir) ;; to toggle back use [C-/]
;; (global-set-key [f9] 'x-get-selection)

(fset 'yes-or-no-p 'y-or-n-p) ; nafai.dyndns.org/files/casey-emacs-tmp.html
(global-set-key "\C-x\C-o" 'other-window) 
(set-input-mode nil nil 1) ; enable 8-bit input/insertion //home.snafu.de/ohei/emacs/emacs206-os2-site-start.html
;; //www.tldp.org/HOWTO/LinuxDoc+Emacs+Ispell-HOWTO-4.html
;; The iso-sgml library will let you type accented characters under
;; Emacs, like always, but upon saving your file to the disk, it will
;; turn these 8-bit characters into their SGML equivalent.
(setq sgml-mode-hook
      '(lambda () "Defaults for SGML mode."
	 (load-library "iso-sgml")))

;;;http://hocwp.free.fr/utils/emacs ; maxim/~/.emacs.phil
(auto-compression-mode 1)
(global-set-key (read-kbd-macro "C-x c") 'server-edit) ; C-3 .eq. ESC

;; C-x C-b : buffer list in same window
(global-set-key (read-kbd-macro "C-c C-x C-b") 'electric-buffer-list) ;bs-show
(global-set-key (read-kbd-macro "C-x C-M-b") 'buffer-menu)
(global-set-key (read-kbd-macro "C-x C-k") 'kill-buffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(require 'ibuffer)
;(add-to-list 'ibuffer-never-show-regexps "^\\*")
;(setq ibuffer-saved-filter-groups (quote (("tasks - non-ooo-ed+non-*" ("tasks - non-ooo-ed+non-*" (name . "^[^*]") (not saved . "ooo-ed"))))))

;; (setq vars (buffer-local-variables))
;; (prin1 vars)
;;>! add to hook
(defun i1-ibuffer-append-saved-filter-groups (name)
  "Append saved groups with NAME to this buffer's filter groups.
The value from `ibuffer-saved-filter-groups' is used."
  (interactive
   (list
    (if (null ibuffer-saved-filter-groups)
	(error "No saved filters")
      (completing-read "Switch to saved filter group: "
		       ibuffer-saved-filter-groups nil t))))
  (setq ibuffer-filter-groups 
	(append (cdr (assoc name ibuffer-saved-filter-groups))
		ibuffer-filter-groups))
  (ibuffer-update nil t))

;; C-M-F5 : Xterm; in em21 from korbel to reflections X it sends M-f15
(defun my_xterm ()
  "Start an Xterm"
  (interactive)
  (shell-command "xterm -rv"))
(global-set-key (read-kbd-macro "M-<f15>") 'my_xterm)

(defun my-white-spaces ()
  "a kde je ten .emacs, co sem psal v lx? zdestruoval ho bsd?" 
  (interactive)
  (setq show-trailing-whitespace (not show-trailing-whitespace))
  (redraw-display))
(global-set-key (read-kbd-macro "<f6>") 'my-white-spaces)

(defun my-open-todo ()
  "Open the TODO file"
  (interactive)
  (if (file-exists-p "~pep/Documents/2do/2do.u8.txt")
      (find-file "~pep/Documents/2do/2do.u8.txt"))
  (if (file-exists-p "e:/.2do/2do.u8.txt")
      (find-file "e:/.2do/2do.u8.txt"))
  (if (file-exists-p "~/html/.2do/2do.u8.txt")
      (find-file "~/html/.2do/2do.u8.txt"))
  (if (file-exists-p "c:/Documents and Settings/kral/My Documents/My Pictures/sx1/2do.u8.txt")
      (find-file "c:/Documents and Settings/kral/My Documents/My Pictures/sx1/2do.u8.txt")))
(global-set-key (read-kbd-macro "C-<f12>") 'my-open-todo)

;(desktop-read) ; je to nutny<?>
; //www.gnu.org/software/emacs/manual/html_node/emacs/Shell-Mode.html
(defun i2-interactive-off () (interactive)
  (remove-hook 'comint-output-filter-functions
	       'comint-watch-for-password-prompt)
  (message "watch-for-password-prompt filter remove/d..") )

;;; utf+mime
(setq vm-imap-auto-expunge-alist
     '(;; nil == leave message on the server
	("imap:localhost:143:inbox:login:pep:*" . nil) ) )

;;; http://www.linux.or.jp/JF/JFdocs/mouse-wheel-scroll-12.html
(defun up-slightly () (interactive) (scroll-up 5))
(defun down-slightly () (interactive) (scroll-down 5))
(global-set-key [mouse-4] 'down-slightly)
(global-set-key [mouse-5] 'up-slightly)

(defun up-one () (interactive) (scroll-up 1))
(defun down-one () (interactive) (scroll-down 1))
(global-set-key [S-mouse-4] 'down-one)
(global-set-key [S-mouse-5] 'up-one)

(defun up-a-lot () (interactive) (scroll-up))
(defun down-a-lot () (interactive) (scroll-down))
(global-set-key [C-mouse-4] 'down-a-lot)
(global-set-key [C-mouse-5] 'up-a-lot)

;; old good style city-lights
(defun g1-my-green () ""
  (interactive)
  (set-background-color "black")
  (set-foreground-color "green")
  (set-cursor-color "yellow")
  (set-mouse-color "blue")
  (global-font-lock-mode t)
  (setq term-current-row -1)
  )					; google.com/search?q=emacs+reset-terminal
(g1-my-green)

;;; (menu-bar-mode nil) ;; needed only in bsd emacs-20.7.. bad deps
;;; .emacs ends here
;;;
;;; .old..
;;  '(mode-line-format (quote (#("-" 0 1 (help-echo "mouse-1: select window, mouse-2: delete others, mouse-3: delete ...")) mode-line-mule-info mode-line-modified mode-line-frame-identification mode-line-buffer-identification #("   " 0 3 (help-echo "mouse-1: select window, mouse-2: delete others, mouse-3: delete ...")) global-mode-string #("   --%[(" 0 6 (help-echo "mouse-1: select window, mouse-2: delete others, mouse-3: delete ...")) (:eval (mode-line-mode-name)) mode-line-process minor-mode-alist #("%n" 0 2 (local-map (keymap (mode-line keymap (mouse-2 . mode-line-widen))) help-echo "mouse-2: widen")) #(")%]--" 0 5 (help-echo "mouse-1: select window, mouse-2: delete others, mouse-3: delete ...")) (which-func-mode ("" which-func-format #("--" 0 2 (help-echo "mouse-1: select window, mouse-2: delete others, mouse-3: delete ...")))) (line-number-mode (#("L%l" 0 3 (help-echo "mouse-1: select window, mouse-2: delete others, mouse-3: delete ...")) #("--" 0 2 (help-echo "mouse-1: select window, mouse-2: delete others, mouse-3: delete ...")))) (column-number-mode (#("C%c" 0 3 (help-echo "mouse-1: select window, mouse-2: delete others, mouse-3: delete ...")) #("--" 0 2 (help-echo "mouse-1: select window, mouse-2: delete others, mouse-3: delete ...")))) (-3 . #("%p" 0 2 (help-echo "mouse-1: select window, mouse-2: delete others, mouse-3: delete ..."))) "-% of-" (:eval (number-to-string (- (point-max) (point-min))) 0 2 (help-echo "eval
;;   (number-to-string
;;    (-
;;     (point-max)
;;     (point-min)))")) mode-line-process minor-mode-alist #("%--" 0 2 (help-echo "mouse-1: select window, mouse-2: delete others, mouse-3: delete ...")))))
;;
;; //www.gnu.org/s/emacs/manual/html_node/elisp/List-Elements.html
;; (let ((list mode-line-format))
;;        (while list
;;          (print (car list))
;;          (setq list (cdr list))))
;;
;; stu: (add-to-list 'mode-line-format " ~~~ ") (pop mode-line-format) ... (last mode-line-format) 
;; (add-to-list 'mode-line-format " ~~~ " t) ; NY func
;;
(setq old-line-format mode-line-format)
(setq default-mode-line-format
      (append
       (butlast mode-line-format) 
       '(" [len:" 
	 (:eval (number-to-string (- (point-max) (point-min)))) "B, enc:" 
	 (:eval (prin1-to-string (cdr (process-coding-system (get-buffer-process (current-buffer))))))
	 "] ") 
       (last mode-line-format)))
(fset 'd1-toggle-coding
   [?\C-x ?\C-m ?p ?u ?t ?f ?  ?8 ?  ?u ?  return ?\M-p return ?\C-q ?\C-\] return ?z return])
(fset 'd2-toggle-to-dos
   [?\C-x ?\C-m ?p ?u ?t ?  ?8 ?  ?u ?  return ?u ?t  ?  ?8 ?  ?d ?  return return])

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ange-ftp-dumb-unix-host-regexp "10.224.176.61")
 '(browse-url-browser-function (quote w3m-browse-url))
 '(bsh-jar "/usr/share/java/bsh.jar")
 '(column-number-mode t)
 '(default-input-method "czech-qwerty")
 '(delete-by-moving-to-trash t)
 '(delete-selection-mode nil)
 '(desktop-save-mode t nil (desktop))
 '(dired-listing-switches "-I *~ -l")
 '(ediff-custom-diff-options "-c -a")
 '(ediff-diff-options "-a")
 '(ediff-merge-split-window-function (quote split-window-vertically))
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(font-lock-global-modes t)
 '(global-font-lock-mode t nil (font-lock))
 '(htmlize-output-type (quote font))
 '(ibuffer-saved-filter-groups (quote (("weblog" ("weblog|dev" (or (filename . "weblog\\|dev"))) ("tmp" (or (filename . "tmp"))) ("^*" (name . "^*"))) ("tickets-2" ("56449|is41" (or (filename . "56449\\|is41") (name . "56449\\|is41"))) ("ttt" (or (filename . "ttt") (name . "ttt"))) ("^*" (name . "^*"))) ("dev-1" ("log|myjugg" (or (filename . "log\\|myjugg") (name . "log\\|myjugg"))) ("swf|build|git" (or (filename . "swf\\|git") (name . "swf\\|git"))) ("^*" (name . "^*"))) ("tickets-3" ("cr20662|small" (or (filename . "cr20662\\|small"))) ("ttt|for_review" (or (filename . "ttt\\|for_review"))) ("^*" (name . "^*"))) ("g1-stars" ("^*" (name . "^*"))) ("tickets-1" ("47405|ssd-mem" (or (filename . "47405\\|ssd-mem"))) ("55934\\|ghlr" (or (filename . "55934\\|ghlr"))) ("ttt|for_review" (or (filename . "ttt\\|for_review"))) ("^*" (name . "^*"))) ("tasks - non-ooo-ed+non-*" ("tasks - non-ooo-ed+non-*" (name . "^[^*]") (not saved . "ooo-ed"))))))
 '(ibuffer-saved-filters (quote (("ooo-ed" ((filename . "at/ooo-ed"))) ("gnus" ((or (mode . message-mode) (mode . mail-mode) (mode . gnus-group-mode) (mode . gnus-summary-mode) (mode . gnus-article-mode)))) ("programming" ((or (mode . emacs-lisp-mode) (mode . cperl-mode) (mode . c-mode) (mode . java-mode) (mode . idl-mode) (mode . lisp-mode)))))))
 '(icicle-download-dir "~/.emacs.d/site-lisp/icicles")
 '(icicle-region-alist (quote (("##
#  SMSC clusters
#
# ver 1.189
#
#
#
# CLUSTER description
# Name: name_of_th" "TEST.ALL" "/scp:kraljo@jubiler:/home2/kraljo/small-projects/cr16844-smh-stability-improvement-expiration-postpone/ttt,09-10-30/TEST.ALL" 1 13421))))
 '(ispell-program-name "aspell")
 '(ls-lisp-dirs-first nil)
 '(max-specpdl-size 3000)
 '(menu-bar-mode nil)
 '(mode-line-inverse-video nil)
 '(pc-select-meta-moves-sexps t)
 '(pc-select-selection-keys-only t)
 '(pc-selection-mode t nil (pc-select))
 '(require-final-newline nil)
 '(scroll-bar-mode nil)
 '(show-paren-mode t nil (paren))
 '(show-trailing-whitespace t)
 '(smtpmail-default-smtp-server "smtp.intinfra.com")
 '(sql-sqlite-program "sqlite3")
 '(standard-indent 4)
 '(tcl-continued-indent-level 2)
 '(tcl-indent-level 2)
 '(tool-bar-mode nil nil (tool-bar))
 '(x-select-enable-clipboard t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :foreground "green" :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 110 :width normal :foundry "unknown" :family "sans"))))
 '(custom-documentation ((t (:box unspecified))))
 '(custom-documentation-face ((t (:box unspecified))) t)
 '(escape-glyph ((((background dark)) (:foreground "gray20"))))
 '(font-lock-doc-face ((t (:inherit font-lock-string-face :box (:line-width 1 :color "grey75" :style released-button) :slant italic))))
 '(fringe ((((class color) (background dark)) (:background "grey10" :foreground "darkBlue"))))
 '(hi-blue-b ((((min-colors 88)) (:foreground "lightblue" :weight bold))))
 '(hl-line ((t (:underline "lightBlue"))))
 '(org-level-1 ((((class color) (min-colors 88) (background dark)) (:foreground "LightSkyBlue" :box (:line-width 2 :color "grey75" :style released-button)))))
 '(rst-level-1-face ((t (:foreground "blue" :box (:line-width 1 :color "grey75" :style released-button) :height 160 :family "sans"))))
 '(rst-level-2-face ((t (:foreground "blue" :underline t :height 150 :family "sans"))))
 '(rst-level-3-face ((t (:foreground "blue" :height 130 :family "sans"))))
 '(term-default ((t (:stipple nil :background "black" :foreground "green" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight 500 :height 124 :width normal)))))

;; www.coloradocollege.edu/dept/ma/Resources/Labs/InstallEmacs-JDE.html
(setq binary-process-input t) 
(setq w32-quote-process-args ?\") 
;; (setq shell-file-name "c:/Python23/cygwin/bin/bash.exe") 
;; (setq explicit-shell-file-name shell-file-name) 
;; (setq explicit-sh-args '("--login" "-i"))
(setenv "SHELL" shell-file-name) 

(if nil ; (fboundp 'w32-version)
    (progn (setq shell-file-name "c:/Python23/cygwin/bin/bash.exe") 
	   (setq explicit-shell-file-name shell-file-name) 
	   (setq explicit-sh-args '("--login" "-i"))
	   ))

(defun bash () ""
  (interactive)
  (setq shell-file-name "c:/Python23/cygwin/bin/bash.exe") 
  (setq explicit-shell-file-name shell-file-name) 
  (setq explicit-sh-args '("--login" "-i"))
  (shell))

(fset 'l1-enter-1-line
    [?\C-k ?\C-k ?\C-x ?\C-o ?\C-y backspace ?\C-c ?\C-k ?\C-m ?\C-c ?\C-j ?\C-x ?\C-o])
;;  see elisp ``^hi vector'' for more nfo
;;  [?\C-k ?\C-k ?\C-x ?\C-o ?\C-y backspace ?\C-c ?\C-k ?\C-m f2 f2 ?\C-c ?\C-j ?\C-x ?\C-o])

;;; this was authomaticaly inserted - i dont know why just as string..
;;  may be because i edited it before by edit-kbd-macro?
;;  [?e ?x return ?p ?m ?l return ?\C-c ?\C-j ?\C-y ?\C-c ?\C-k ?\C-m])
(fset 'tr1-liw
   "ex\C-mpml\C-m\C-c\C-jdo[user.kraljo.pml]tr_liw\C-c\C-k\C-m")
;; Original keys: C-c LFD C-a C-SPC 3*C-f M-w C-e ex RET dir/dat/siz SPC [ ...]liw_mod*.log C-x C-s C-c C-k RET C-c LFD C-y C-c C-k RET
(fset 'dir1
   [?\C-c ?\C-j ?\C-a ?\C-  ?\C-f ?\C-f ?\C-f ?\M-w ?\C-e ?e ?x return ?d ?i ?r ?/ ?d ?a ?t ?/ ?s ?i ?z ?  ?[ ?. ?. ?. ?] ?l ?i ?w ?_ ?m ?o ?d ?* ?. ?l ?o ?g ?\C-x ?\C-s ?\C-c ?\C-k ?\C-m ?\C-c ?\C-j ?\C-y ?\C-c ?\C-k ?\C-m])

(defun h1-hilight-prompts ()
  "TIP: it is possible to add colors by -mode AFTER hi-lighting!"
  (interactive)
  ; (require 'highlight)
  ; (hi-lock-face-phrase-buffer "\[.*\]" 'info-node)
  (hi-lock-face-phrase-buffer "\[[$.A-Z_a-z]+[@:].+\].*" 'hi-blue-b)
  (hi-lock-face-phrase-buffer "^[^ ]+[]>] .*\\|error" 'hi-red-b)
  (hi-lock-face-phrase-buffer "[a-zA-Z]+# .*" 'hi-red-b)
  (hi-lock-face-phrase-buffer "^% .*" 'hi-red-b)
  (hi-lock-face-phrase-buffer ".*>\$ .*" 'font-lock-warning-face)
  (hi-lock-face-phrase-buffer "!.*\\|#.*" 'font-lock-comment-face)
  (hi-lock-face-phrase-buffer "pep> .*" 'font-lock-doc-face) ; good for sts tail-f
  ;; (hi-lock-face-phrase-buffer "^\./.*.log" 'hi-yellow)
  )

(defun h2-hilight-results () ""
  (interactive)
  ;; >! add moccur "test result\|_pep_\|pep>\|\[ [a-z] \]"!
  (hi-lock-face-phrase-buffer ".* \\[ ERROR \\]" 'sh-quoted-exec) ; widget-button-pressed-face (| cscope-line-number-face ?)
  (hi-lock-face-phrase-buffer "\\[ ERROR \\]" 'hi-red-b)
  (hi-lock-face-phrase-buffer ".* \\[ ERROR - known bug \\]" 'file-name-shadow)
  (hi-lock-face-phrase-buffer "\\[ ERROR - known bug \\]" 'escape-glyph) ; file-name-shadow
  (hi-lock-face-phrase-buffer ".* \\[ SKIPPED \\]" 'font-lock-variable-name-face)
  (hi-lock-face-phrase-buffer "Description: .*\\|Desc: .*" 'font-lock-comment-face)
  (hi-lock-face-phrase-buffer "\\[ SKIPPED \\]" 'sh-heredoc)
  (hi-lock-face-phrase-buffer "Test result of" 'font-lock-doc-face) ;>! custom-group-tag
  (hi-lock-face-phrase-buffer "Name: .*" 'search-buffers-header-face)
  ;; in some situations can help: (hi-lock-set-pattern "proc AS[_0-9A-Za-z]+" 'hi-red-b)
  ;; (toggle-read-only 0)
  ;; (flush-lines "\\[ BEGIN \\]")
  )

(defun t1-terms-up () ""
  (interactive)
  (if (get-buffer "1") (kill-buffer "1") )
  (if (get-buffer "2") (kill-buffer "2") )
  (if (get-buffer "3") (kill-buffer "3") )

  (make-frame-command)
  (g1-my-green) ; here? - to make new frame also shampoo?
  (term "bash")
  (write-file "~/sprs/3" nil)
  (term "bash")
  (write-file "~/sprs/2" nil)

  (term "bash")
  (write-file "~/sprs/1" nil)
  (kill-new "(setq term-current-row -1)") ; see more command-history
  ;; not needed when emacs runs from -agented env
  ;; (execute-kbd-macro "echo starting..\n\n")
  ;; (execute-kbd-macro ". ~/.ssh/roby.agent.sh\n")
  ;; (execute-kbd-macro "ssh-add\n")

  (load-tramp)
  (find-file "/root@10.224.178.245:/")
  (switch-to-buffer "1")
  )

(defun t2-old-term () ""
  (interactive)
  (if (version< emacs-version "23")
      (load-file "/mnt/win/pepa/opt/emacs-21.4/lisp/term.elc")
    (load-file "~/.emacs.d/site-lisp/old-23-term.el"))
					; (cond ((eq temp 0)
					; (term-move-columns -1)
					; (setq term-terminal-state 1)))
  (term "bash")
  (setq term-buffer-maximum-size 2097152) ; buffer-local
  (defun term-check-size (process) (setq term-current-row -1))
  (defun term-erase-in-display (term-terminal-parameter) (message "my> erase display.."))
  (defun term-reset-terminal () (message "my> reset term.."))
  (defun term-reset-size (height width) (message "my> reset size.."))
  (kill-new "(setq term-current-row -1)") ; see more command-history
  )

;;; "use with sorted ibuffer list - to 'bulk' cmd to all shells"
;; telnet -l smblc1-ilo 10.224.179.220 <- replaced by (kmacro-insert-counter)
;; user
;; heslo
(fset 'c2-login-incr-next
   [?\M-r ?t ?a backspace ?e ?l ?n ?e ?t return ?\C-r ?. ?2 ?2 ?\C-e backspace ?\M-x ?\M-p return ?\M-> return ?\C-x ?\C-b ?n ?n return])
(fset 'c3-commint-selection-and-next-shell
   [?\C-y return ?\C-x ?\C-b ?\C-m])

(defun c1-connect (&optional new-tasks-p) ""
  (interactive)
  (setq sess-name (read t))
  ;; (append 1,2,3 to existent/new tasks)
  ;; incl. vvv
  (find-file "/pixu2:/home/kraljo/")
  )

(defun m1-mount-sfs-sys () ""
  (interactive)
  (find-file "/ssh:kraljo@jedi.ATT.CMG.NL:/mnt/ares/samba/sys/project/smsc/intern/Maintenance/Test/spr_test_reports/")
  )

(defun a1-actual-session (&optional new-tasks-p)
  "^u 0 - connect to last one PR/task ; default
   ^u 1 - specify new task
   ^u 2 - specify both new"
  (interactive)
  (t1-terms-up)
  (load-tramp)
  (switch-to-buffer "1")
  (g1-my-green)
  (c1-connect) ; new-tasks-p
  )

(fset 'r1-reset-connection
   [?\C-x ?\C-w ?\M-n ?\C-a ?\C-k return ?\M-x ?t ?e ?r ?m return return ?\C-c ?\C-j ?\C-a ?\C-o ?\C-o ?\C-x ?i ?\C-a ?\C-y ?\C-k return ?\M-> ?\C-x ?\C-b ?\C-n ?\C-d return ?\C-x ?\C-w ?\C-a ?\C-y ?\M-y ?\C-k return ?y])

;; stay on first
(fset 's1-sh-before-set
   "\C-k\C-k\C-y\C-y\C-p\C-p\344sh\C-s=\C-b\C-k\C-a\C-n\C-n")

;; stay after last
(fset 'p1-pack-dir-list
   [?\C-\M-s ?\C-r ?^ ?t ?o ?t ?a ?l ?  ?\C-a ?\C-p ?\C-k ?\C-r ?d ?i ?r ?e ?c ?t ?o ?r ?y ?  ?\C-a ?\C-\M-% ?\; ?\\ ?( ?[ ?0 ?- ?9 ?] ?+ ?\\ ?) ?\C-q ?\C-j ?\C-m ?\; ?\\ ?1 ?\C-m ?! ?\C-r ?\C-r ?\C-a ?\C-n ?\C-k ?\C-p ?\C-p])
;; ; or (execute-kbd-macro `p1-pack-dir-list)
;; (defun my-execute-extended-command ; my-eval-last-exp
;;   "call somethig fastly-by M-x ... and then fastly-by f8" ; "call macro or something by 1 key"
;;   (interactive)
;;   )
;; (global-set-key [f9] 'call-last-kbd-macro)
(fset 'p3-pack1-line
   "\C-a\C-p\223\C-r\C-q\C-j[ \C-i]*\C-q\C-j\C-m\C-k\C-a\C-n")
(global-set-key [f9] 'p3-pack1-line)

;; (set-default-font ; Set our font http://www.dotemacs.de/dotfiles/AndreyAKulaga.emacs.html
;;  "-*-Lucida Console-normal-r-*-*-16-120-96-96-c-*-iso8859-2")
;; "*Arial*normal*r*normal*"

;; www.daimi.au.dk/~terryp/HintsForEmacs.html
(windmove-default-keybindings)
(if (fboundp 'iswitchbb-mode) (iswitchbb-mode 1))

;; stejně to nevystřihuje 1250 ;; gnu.org/software/emacs/windows/faq4.html
; (codepage-setup 1250)
;; (set-selection-coding-system 'cp1250)
;; (autoload 'w3m "w3m" "Interface for w3m on Emacs." t)
;; (require 'octet)  
;; (octet-mime-setup)

(defun f1-foo () "Demo to show call-process from http://groups.google.de/group/gnu.emacs.help/tree/browse_frm/month/1992-11/84a58cc02a2f90dd?rnum=21&hl=en&_done=%2Fgroup%2Fgnu.emacs.help%2Fbrowse_frm%2Fmonth%2F1992-11%3Fhl%3Den%26" 
  (let ((curbuf (current-buffer))               ;; current buffer
        (buf (get-buffer "*foo*"))            ;; temp buffer
        str)                                    ;; return value
    (if buf                                     ;; kill *foo*
        (kill-buffer buf))
    (setq buf (get-buffer-create "*foo*"))    ;; create *foo*
    (call-process "pwd" nil buf)              ;; pwd output to *foo*
    (set-buffer buf)                            ;; get dir, strip \n
    (setq str (buffer-substring (point-min) (- (point-max) 1)))
    (set-buffer curbuf)                         ;; restore current buffer
    (kill-buffer buf)                           ;; kill *foo*
    str))                                       ;; return directory 


(if (not (file-accessible-directory-p
	  "/usr/libexec/emacs/21.3/i386-redhat-linux-gnu/"))
    (setq
     server-program
     "/usr/libexec/emacs/21.3/i686-redhat-linux-gnu/emacsserver")
  )

;;; //ubuntuforums.org/showthread.php?t=572999
(setq cscope-do-not-update-database t)
; (load-file "/usr/share/emacs/site-lisp/xcscope.el")
; (require 'xcscope)

(require 'moccur-edit)
(require 'ruby-mode)
;; (global-font-lock-mode t) ; still not..

;; not func under m$wNT: "Spawning child process: invalid argument"
(server-start) 

(put 'scroll-left 'disabled nil)

(defun s1-scratch-patterns ()
  "run from scratch -- (kill-new (prin1-to-string hi-lock-interactive-patterns)) NY"
  (interactive)
  (other-window 1) (setq my-p hi-lock-interactive-patterns) (other-window 1) (prin1 my-p))

(defun enlink (url-like &optional line-number)  ""
  (interactive)
  (find-file url-like) (goto-line line-number))

;; //www.ruby-forum.com/topic/125226
(add-hook 'ruby-mode-hook
              '(lambda ()
                 (outline-minor-mode)
                 (setq outline-regexp " *\\(def \\|class\\|module\\)")))

;; //emacs.wordpress.com/2007/01/16/quick-and-dirty-code-folding/
;; || [M-1 C-x S-$] set-selective-display 
(defun jao-toggle-selective-display (column)
  (interactive "P")
  (set-selective-display
   (if selective-display nil (or column 1))))

(add-hook 'tcl-mode-hook
              '(lambda ()
                 (outline-minor-mode)
                 (setq outline-regexp " *\\(try \\|proc \\|class\\|module\\)"))) ; >!

;; //www.koders.com/lisp/fid4F18656D1490CD02D3AD738479E1D31C93C6513E.aspx?s=TV+Raman
(defun tcl-outline-level ()
  (save-excursion
    (skip-chars-forward " \t")
    (current-column)))
; (set (make-local-variable 'outline-level) 'tcl-outline-level)

;; //www.emacswiki.org/cgi-bin/wiki/EasyCodeOutline
;;     (defun cjm-outline-bindings ()
;;       "sets shortcut bindings for outline minor mode"
;;       (interactive)
;;       (local-set-key [?\C-,] 'hide-sublevels)
;;       (local-set-key [?\C-.] 'show-all)
;;       (local-set-key [C-up] 'outline-previous-visible-heading)
;;       (local-set-key [C-down] 'outline-next-visible-heading)
;;       (local-set-key [C-left] 'hide-subtree)
;;       (local-set-key [C-right] 'show-onelevel)
;;       (local-set-key [M-up] 'outline-backward-same-level)
;;       (local-set-key [M-down] 'outline-forward-same-level)
;;       (local-set-key [M-left] 'hide-subtree)
;;       (local-set-key [M-right] 'show-subtree))
;;     (add-hook 'outline-minor-mode-hook
;;               'cjm-outline-bindings) 

;; (load "~/.emacs.d/site-lisp/icicles-install")
;; '(search-invisible nil)

(setq ange-ftp-vms-host-regexp "^10.224.179.105$")

(put 'set-goal-column 'disabled nil)
(defun my-comint-init ()
  (setq comint-process-echoes t))
(add-hook 'comint-mode-hook 'my-comint-init)

(add-hook 'shell-mode-hook
	  '(lambda ()
	     (define-key shell-mode-map (kbd "C-<f9>") 'd1-toggle-coding)
	     (define-key shell-mode-map (kbd "C-<f8>") 'd2-toggle-to-dos)
	     )) ; >!

(setq ruby-program-name "irb1.8 --inf-ruby-mode")
(global-set-key (kbd "<f1>") 'ruby-send-region)

(put 'narrow-to-region 'disabled nil)
(fset 'sh-la-addr
   [?\C-q ?\C-z return ?f ?g ?  ?2 return C-f8 ?p ?m ?l return ?\M-r ?s ?h ?  ?c ?l return return ?e ?x return C-f9 ?f ?g ?  ?- return])

;; > //martinowen.net/blog/2010/02/tips-for-emacs-ibuffer.html#disqus_thread
(eval-after-load "ibuf-ext"
  '(define-ibuffer-filter filename
       "Toggle current view to buffers with file or directory name matching QUALIFIER."
     (:description "filename"
		   :reader (read-from-minibuffer "Filter by file/directory name (regexp): "))
     (ibuffer-awhen (or (buffer-local-value 'buffer-file-name buf)
			(buffer-local-value 'dired-directory buf))
       (string-match qualifier it))))

;; //www.elliotglaysher.org/emacs/
(autoload 'browse-kill-ring "browse-kill-ring" "Browse the kill ring." t)
(global-set-key (kbd "C-c k") 'browse-kill-ring)
(eval-after-load "browse-kill-ring"
  '(progn
     (setq browse-kill-ring-quit-action 'save-and-restore)))

;; //curiousprogrammer.wordpress.com/2009/04/02/ibuffer/
(defun ibuffer-ediff-marked-buffers ()
  (interactive)
  (let* ((marked-buffers (ibuffer-get-marked-buffers))
         (len (length marked-buffers)))
    (unless (= 2 len)
      (error (format "%s buffer%s been marked (needs to be 2)"
                     len (if (= len 1) " has" "s have"))))
    (ediff-buffers (car marked-buffers) (cadr marked-buffers))))
(define-key ibuffer-mode-map "e" 'ibuffer-ediff-marked-buffers)

;; //paste.lisp.org/display/73195
;; from //paste.lisp.org/display/14341.
(defun transpose-windows ()
  "transpose the 2 windows in the current frame"
  (interactive)
  (let* ((W1 (selected-window))
	 (W2 (other-window 1))
	 (B1 (window-buffer  W1))
	 (B2 (window-buffer  W2)))
    (set-window-buffer W1 B2)
    (set-window-buffer W2 B1))
  (other-window 1))
(global-set-key (kbd "C-x 4 t") 'transpose-windows) ; Corrected the binding

;; //www.elliotglaysher.org/emacs/
(setq location-prj "dev-1")
(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups location-prj)))

(defun refresh-tasks () (interactive)
  (shell-command "ruby ~/bin/refresh-tasks.rb -i ~/Desktop/tasks.org")
  (revert-buffer))

(defun open-prj (dpath) (interactive)
  (desktop-read dpath) ; there shell be setq of location-prj & its ibuffer-filter-groups
  ; (spread-buffers)
  ; (log-in-shells)
  )

;;; //jdee.sourceforge.net/install.html
;;; more on /usr/share/doc/jde/html/jde-ug/jde-ug.html
(add-to-list 'load-path (expand-file-name "/usr/share/emacs23/site-lisp/jde"))
(add-to-list 'load-path "/usr/share/emacs23/site-lisp/cedet-contrib")
(add-to-list 'load-path (expand-file-name "/usr/share/emacs23/site-lisp/cedet-common"))
(load-file (expand-file-name "/usr/share/emacs23/site-lisp/cedet-common/cedet.el"))
(add-to-list 'load-path (expand-file-name "/usr/share/emacs23/site-lisp/elib"))
(setq defer-loading-jde nil)
(if defer-loading-jde
    (progn
      (autoload 'jde-mode "jde" "JDE mode." t)
      (setq auto-mode-alist
	    (append
	     '(("\\.java\\'" . jde-mode))
	     auto-mode-alist)))
  (require 'jde))

(setq jde-jdk (quote ("1.6.0"))) ;;>?
