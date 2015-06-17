((apel status "installed" recipe
       (:name apel :website "http://www.kanji.zinbun.kyoto-u.ac.jp/~tomo/elisp/APEL/" :description "APEL (A Portable Emacs Library) is a library to support to write portable Emacs Lisp programs." :type github :pkgname "wanderlust/apel" :build
              (mapcar
               (lambda
                 (target)
                 (list el-get-emacs
                       (split-string "-batch -q -no-site-file -l APEL-MK -f")
                       target "prefix" "site-lisp" "site-lisp"))
               '("compile-apel" "install-apel"))
              :load-path
              ("site-lisp/apel" "site-lisp/emu")))
 (auctex status "installed" recipe
         (:name auctex :website "http://www.gnu.org/software/auctex/" :description "AUCTeX is an extensible package for writing and formatting TeX files in GNU Emacs and XEmacs. It supports many different TeX macro packages, including AMS-TeX, LaTeX, Texinfo, ConTeXt, and docTeX (dtx files)." :type git :module "auctex" :url "git://git.savannah.gnu.org/auctex.git" :build
                `(("./autogen.sh")
                  ("./configure" "--without-texmf-dir" "--with-packagelispdir=$(pwd)" "--with-packagedatadir=$(pwd)" ,(cond
                                                                                                                       ((eq system-type 'darwin)
                                                                                                                        "--with-lispdir=`pwd`")
                                                                                                                       (t ""))
                   ,(concat "--with-emacs=" el-get-emacs))
                  "make")
                :load-path
                (".")
                :load
                ("tex-site.el" "preview-latex.el")
                :info "doc"))
 (auto-complete status "installed" recipe
                (:name auto-complete :website "https://github.com/auto-complete/auto-complete" :description "The most intelligent auto-completion extension." :type github :pkgname "auto-complete/auto-complete" :depends
                       (popup fuzzy)
                       :features auto-complete-config :post-init
                       (progn
                         (add-to-list 'ac-dictionary-directories
                                      (expand-file-name "dict" default-directory))
                         (ac-config-default))))
 (cl-lib status "installed" recipe
         (:name cl-lib :builtin "24.3" :type elpa :description "Properly prefixed CL functions and macros" :url "http://elpa.gnu.org/packages/cl-lib.html"))
 (ctable status "installed" recipe
         (:name ctable :description "Table Component for elisp" :type github :pkgname "kiwanami/emacs-ctable"))
 (dash status "installed" recipe
       (:name dash :description "A modern list api for Emacs. No 'cl required." :type github :pkgname "magnars/dash.el"))
 (deferred status "installed" recipe
   (:name deferred :description "Simple asynchronous functions for emacs lisp." :type github :pkgname "kiwanami/emacs-deferred"))
 (el-get status "installed" recipe
         (:name el-get :website "https://github.com/dimitri/el-get#readme" :description "Manage the external elisp bits and pieces you depend upon." :type github :branch "master" :pkgname "dimitri/el-get" :info "." :compile
                ("el-get.*\\.el$" "methods/")
                :features el-get :post-init
                (when
                    (memq 'el-get
                          (bound-and-true-p package-activated-list))
                  (message "Deleting melpa bootstrap el-get")
                  (unless package--initialized
                    (package-initialize t))
                  (when
                      (package-installed-p 'el-get)
                    (let
                        ((feats
                          (delete-dups
                           (el-get-package-features
                            (el-get-elpa-package-directory 'el-get)))))
                      (el-get-elpa-delete-package 'el-get)
                      (dolist
                          (feat feats)
                        (unload-feature feat t))))
                  (require 'el-get))))
 (epc status "installed" recipe
      (:name epc :description "An RPC stack for Emacs Lisp" :type github :pkgname "kiwanami/emacs-epc" :depends
             (deferred ctable)))
 (epl status "installed" recipe
      (:name epl :description "EPL provides a convenient high-level API for various package.el versions, and aims to overcome its most striking idiocies." :type github :pkgname "cask/epl"))
 (evil status "installed" recipe
       (:name evil :website "https://bitbucket.org/lyro/evil" :description "Evil is an extensible vi layer for Emacs. It\n       emulates the main features of Vim, and provides facilities\n       for writing custom extensions." :type hg :url "https://bitbucket.org/lyro/evil" :features evil :depends
              (undo-tree goto-chg)
              :build
              (("make" "info" "all"))
              :build/berkeley-unix
              (("gmake" "info" "all"))
              :build/darwin
              `(("make" ,(format "EMACS=%s" el-get-emacs)
                 "info" "all"))
              :info "doc"))
 (exec-path-from-shell status "installed" recipe
                       (:name exec-path-from-shell :website "https://github.com/purcell/exec-path-from-shell" :description "Emacs plugin for dynamic PATH loading" :type github :pkgname "purcell/exec-path-from-shell"))
 (f status "installed" recipe
    (:name f :website "https://github.com/rejeep/f.el" :description "Modern API for working with files and directories in Emacs" :depends
           (s dash)
           :type github :pkgname "rejeep/f.el"))
 (fill-column-indicator status "installed" recipe
                        (:name fill-column-indicator :type github :website "https://github.com/alpaker/Fill-Column-Indicator#readme" :description "An Emacs minor mode that graphically indicates the fill column." :pkgname "alpaker/Fill-Column-Indicator"))
 (flim status "installed" recipe
       (:name flim :description "A library to provide basic features about message representation or encoding" :depends apel :type github :branch "flim-1_14-wl" :pkgname "wanderlust/flim" :build
              (mapcar
               (lambda
                 (target)
                 (list el-get-emacs
                       (mapcar
                        (lambda
                          (pkg)
                          (mapcar
                           (lambda
                             (d)
                             `("-L" ,d))
                           (el-get-load-path pkg)))
                        '("apel"))
                       (split-string "-batch -q -no-site-file -l FLIM-MK -f")
                       target "prefix" "site-lisp" "site-lisp"))
               '("compile-flim" "install-flim"))
              :load-path
              ("site-lisp/flim")))
 (flymake-cursor status "installed" recipe
                 (:name flymake-cursor :type github :pkgname "illusori/emacs-flymake-cursor" :description "displays flymake error msg in minibuffer after delay (illusori/github)" :website "http://github.com/illusori/emacs-flymake-cursor"))
 (fuzzy status "installed" recipe
        (:name fuzzy :website "https://github.com/auto-complete/fuzzy-el" :description "Fuzzy matching utilities for GNU Emacs" :type github :pkgname "auto-complete/fuzzy-el"))
 (git-modes status "installed" recipe
            (:name git-modes :description "GNU Emacs modes for various Git-related files" :type github :pkgname "magit/git-modes"))
 (goto-chg status "installed" recipe
           (:name goto-chg :description "Goto the point of the most recent edit in the buffer." :type emacswiki :features goto-chg))
 (ipython-extension status "installed" recipe
                    (:name ipython-extension :auto-generated t :type emacswiki :description "Some extension for ipython" :website "https://raw.github.com/emacsmirror/emacswiki.org/master/ipython-extension.el"))
 (jedi status "installed" recipe
       (:name jedi :description "An awesome Python auto-completion for Emacs" :type github :pkgname "tkf/emacs-jedi" :submodule nil :depends
              (epc auto-complete python-environment)))
 (langtool status "installed" recipe
           (:name langtool :description "Emacs frontend for LanguageTool (http://www.languagetool.org/)." :type github :pkgname "mhayashi1120/Emacs-langtool"))
 (latex-math-preview status "installed" recipe
                     (:name latex-math-preview :auto-generated t :type emacswiki :description "preview LaTeX mathematical expressions." :website "https://raw.github.com/emacsmirror/emacswiki.org/master/latex-math-preview.el"))
 (let-alist status "installed" recipe
            (:name let-alist :description "Easily let-bind values of an assoc-list by their names." :builtin "25.1" :type http :url "http://git.savannah.gnu.org/cgit/emacs.git/plain/lisp/let-alist.el"))
 (magit status "installed" recipe
        (:name magit :website "https://github.com/magit/magit#readme" :description "It's Magit! An Emacs mode for Git." :type github :pkgname "magit/magit" :depends
               (cl-lib git-modes)
               :info "." :compile "magit.*.el\\'" :build
               `(("make" "docs"))
               :build/berkeley-unix
               (("gmake" "docs"))
               :build/windows-nt
               (progn nil)))
 (matlab-mode status "installed" recipe
              (:name matlab-mode :description "Major mode for MATLAB(R) dot-m files" :website "http://matlab-emacs.sourceforge.net/" :type cvs :module "matlab-emacs" :url ":pserver:anonymous@matlab-emacs.cvs.sourceforge.net:/cvsroot/matlab-emacs" :build
                     (("touch" "Makefile")
                      ("make"))
                     :load-path
                     (".")
                     :features matlab-load))
 (monokai-theme status "installed" recipe
                (:name monokai-theme :website "https://github.com/oneKelvinSmith/monokai-emacs" :description "A fruity color theme for Emacs." :type github :pkgname "oneKelvinSmith/monokai-emacs" :prepare
                       (add-to-list 'custom-theme-load-path default-directory)))
 (multi-term status "installed" recipe
             (:name multi-term :description "A mode based on term.el, for managing multiple terminal buffers in Emacs." :type emacswiki :features multi-term))
 (multiple-cursors status "installed" recipe
                   (:name multiple-cursors :description "An experiment in adding multiple cursors to emacs" :type github :pkgname "magnars/multiple-cursors.el"))
 (package status "installed" recipe
          (:name package :description "ELPA implementation (\"package.el\") from Emacs 24" :builtin "24" :type http :url "http://repo.or.cz/w/emacs.git/blob_plain/ba08b24186711eaeb3748f3d1f23e2c2d9ed0d09:/lisp/emacs-lisp/package.el" :shallow nil :features package :post-init
                 (progn
                   (let
                       ((old-package-user-dir
                         (expand-file-name
                          (convert-standard-filename
                           (concat
                            (file-name-as-directory default-directory)
                            "elpa")))))
                     (when
                         (file-directory-p old-package-user-dir)
                       (add-to-list 'package-directory-list old-package-user-dir)))
                   (setq package-archives
                         (bound-and-true-p package-archives))
                   (mapc
                    (lambda
                      (pa)
                      (add-to-list 'package-archives pa 'append))
                    '(("ELPA" . "http://tromey.com/elpa/")
                      ("melpa" . "http://melpa.org/packages/")
                      ("gnu" . "http://elpa.gnu.org/packages/")
                      ("marmalade" . "http://marmalade-repo.org/packages/")
                      ("SC" . "http://joseito.republika.pl/sunrise-commander/"))))))
 (pianobar status "installed" recipe
           (:name pianobar :description "Run Pandora as an inferior process in emacs by using pianobar" :type emacswiki))
 (pkg-info status "installed" recipe
           (:name pkg-info :description "Provide information about Emacs packages." :type github :pkgname "lunaryorn/pkg-info.el" :depends
                  (dash epl)))
 (popup status "installed" recipe
        (:name popup :website "https://github.com/auto-complete/popup-el" :description "Visual Popup Interface Library for Emacs" :type github :submodule nil :pkgname "auto-complete/popup-el"))
 (projectile status "installed" recipe
             (:name projectile :description "Project navigation and management library for Emacs." :type github :pkgname "bbatsov/projectile" :depends
                    (dash s pkg-info)))
 (py-autopep8 status "installed" recipe
              (:name py-autopep8 :description "Use autopep8 to beautify a Python buffer." :type github :pkgname "paetzke/py-autopep8.el"))
 (pydoc-info status "installed" recipe
             (:name pydoc-info :description "Emacs package for searching Python documentation in Info" :website "https://bitbucket.org/jonwaltman/pydoc-info" :type hg :url "https://bitbucket.org/jonwaltman/pydoc-info"))
 (pymacs status "installed" recipe
         (:name pymacs :description "Interface between Emacs Lisp and Python" :type github :pkgname "pinard/Pymacs" :prepare
                (progn
                  (el-get-envpath-prepend "PYTHONPATH" default-directory)
                  (autoload 'pymacs-load "pymacs" nil t)
                  (autoload 'pymacs-eval "pymacs" nil t)
                  (autoload 'pymacs-exec "pymacs" nil t)
                  (autoload 'pymacs-call "pymacs")
                  (autoload 'pymacs-apply "pymacs"))
                :build
                ("make")))
 (python-environment status "installed" recipe
                     (:name python-environment :description "Python virtualenv API for Emacs Lisp" :type github :pkgname "tkf/emacs-python-environment" :depends
                            (deferred)))
 (request status "installed" recipe
          (:name request :description "Easy HTTP request for Emacs Lisp" :type github :submodule nil :pkgname "tkf/emacs-request"))
 (s status "installed" recipe
    (:name s :description "The long lost Emacs string manipulation library." :type github :pkgname "magnars/s.el"))
 (semi status "installed" recipe
       (:name semi :description "SEMI is a library to provide MIME feature for GNU Emacs." :depends flim :type github :branch "semi-1_14-wl" :pkgname "wanderlust/semi" :build
              (mapcar
               (lambda
                 (target)
                 (list el-get-emacs
                       (mapcar
                        (lambda
                          (pkg)
                          (mapcar
                           (lambda
                             (d)
                             `("-L" ,d))
                           (el-get-load-path pkg)))
                        '("apel" "flim"))
                       (split-string "-batch -q -no-site-file -l SEMI-MK -f")
                       target "prefix" "site-lisp" "site-lisp"))
               '("compile-semi" "install-semi"))
              :load-path
              ("site-lisp/semi/")))
 (switch-window status "installed" recipe
                (:name switch-window :description "A *visual* way to choose a window to switch to" :type github :pkgname "dimitri/switch-window" :features switch-window))
 (tramp status "installed" recipe
        (:name tramp :description "Transparent Remote Access, Multiple Protocols." :website "http://www.gnu.org/s/tramp/" :type git :url "git://git.savannah.gnu.org/tramp.git" :build
               `(("autoconf")
                 ("./configure" ,(concat "--with-emacs=" el-get-emacs)
                  "--with-contrib" ,(concat "--prefix="
                                            (expand-file-name
                                             (el-get-package-directory "tramp"))))
                 ("make")
                 ("make" "install"))
               :load-path
               ("./lisp")
               :autoloads
               ("trampver.el" "tramp-loaddefs.el")
               :prepare
               (progn
                 (autoload 'tramp-check-proper-method-and-host "tramp.el"))
               :info "share/info"))
 (undo-tree status "installed" recipe
            (:name undo-tree :description "Treat undo history as a tree" :website "http://www.dr-qubit.org/emacs.php" :type git :url "http://www.dr-qubit.org/git/undo-tree.git/"))
 (unify-buffer status "installed" recipe
               (:name unify-buffer :auto-generated t :type emacswiki :description "Concatenate multiple buffers" :website "https://raw.github.com/emacsmirror/emacswiki.org/master/unify-buffer.el"))
 (wanderlust status "installed" recipe
             (:name wanderlust :description "Wanderlust bootstrap." :depends semi :type github :pkgname "wanderlust/wanderlust" :build
                    (mapcar
                     (lambda
                       (target-and-dirs)
                       (list el-get-emacs
                             (mapcar
                              (lambda
                                (pkg)
                                (mapcar
                                 (lambda
                                   (d)
                                   `("-L" ,d))
                                 (el-get-load-path pkg)))
                              (append
                               '("apel" "flim" "semi")
                               (when
                                   (el-get-package-exists-p "bbdb")
                                 (list "bbdb"))))
                             "--eval"
                             (el-get-print-to-string
                              '(progn
                                 (setq wl-install-utils t)
                                 (setq wl-info-lang "en")
                                 (setq wl-news-lang "en")))
                             (split-string "-batch -q -no-site-file -l WL-MK -f")
                             target-and-dirs))
                     '(("wl-texinfo-format" "doc")
                       ("compile-wl-package" "site-lisp" "icons")
                       ("install-wl-package" "site-lisp" "icons")))
                    :info "doc/wl.info" :load-path
                    ("site-lisp/wl" "utils")
                    :post-init
                    (progn
                      (setq wl-icon-directory
                            (expand-file-name "etc/icons" default-directory)))))
 (websocket status "installed" recipe
            (:name websocket :description "A websocket implementation in elisp, for emacs." :type github :pkgname "ahyatt/emacs-websocket"))
 (yasnippet status "installed" recipe
            (:name yasnippet :website "https://github.com/capitaomorte/yasnippet.git" :description "YASnippet is a template system for Emacs." :type github :pkgname "capitaomorte/yasnippet" :compile "yasnippet.el" :submodule nil :build
                   (("git" "submodule" "update" "--init" "--" "snippets")))))
