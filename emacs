
;;###############################;;
;;                               ;;
;;     Emacs Lisp Config File    ;;
;;                               ;;
;;         - vikingsheepman      ;;
;;                               ;;
;;###############################;;

;; For re-eval
(defvar first-time t)


;;###############################;;
;;                               ;;
;;     Enviroment                ;;
;;                               ;;
;;###############################;;

;; Add to default path
(add-to-list 'load-path "~/.emacs.d/evil")
(add-to-list 'load-path "~/.emacs.d/slime-master")
(add-to-list 'load-path "~/.emacs.d/colors/")

;; Load packages
(require 'evil)
(require 'slime)

;; Load files
(autoload 'linum-mode "linum" t)
(if (file-exists-p "~/.emacs.d/undo-tree.el")
    (load "~/.emacs.d/undo-tree.el"))
(if (file-exists-p "~/.emacs.d/multi-term.el")
    (load "~/.emacs.d/multi-term.el"))
(if (file-exists-p "~/.emacs.d/key-chord.el")
    (load "~/.emacs.d/key-chord.el"))
(if (file-exists-p "~/.emacs.d/sr-speedbar.el")
    (load "~/.emacs.d/sr-speedbar.el"))
(if (file-exists-p "~/.emacs.d/gas-mode.el")
    (load "~/.emacs.d/gas-mode.el"))


;;###############################;;
;;                               ;;
;;     General Settings          ;;
;;                               ;;
;;###############################;;

(setq inhibit-startup-message t)
(setq initial-scratch-message "")

;; settings to turn on
(global-font-lock-mode t)
(set-default-font "-xos4-Terminus-normal-normal-normal-*-14-*-*-*-c-80-iso10646-1")
(show-paren-mode t)
(column-number-mode 1)
(line-number-mode 1)
(fringe-mode 1)

;; settings to turn off
(blink-cursor-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(fringe-mode 1)

(setq default-major-mode 'text-mode)
(normal-erase-is-backspace-mode 1)
(setq make-backup-files nil)
(setq standard-indent 4)
(setq-default indent-tabs-mode nil)
(setq auto-fill-mode 1)
(setq windmove-wrap-around t)

;; control tab quotes a tab
(global-set-key [C-tab] "\C-q\t")
(setq backup-by-copying-when-mismatch t)

;; treat y/n as yes/no
(fset 'yes-or-no-p 'y-or-n-p)
(define-key query-replace-map [return] 'act)
(define-key query-replace-map [?\C-m] 'act)

;; status bar settings
(setq-default mode-line-format
      (list
       ;; buffer name/ file name as tool tip
       "["
       '(:eval (propertize "%b"))
       "] "
       ;; line and column
       "[" 
       (propertize "%l") ","
       (propertize "%c")
       "] "
       ;; relative position and size
       "["
       (propertize "%p") "/"
       (propertize "%I")
       "] "
       ;; current major mode
       "["
       'mode-name
       "] "
       ;; insert vs overwrite mode
       "["
       '(:eval (cond ((evil-insert-state-p) (propertize "I"))
                     ((evil-emacs-state-p) (propertize "E"))
                     ((evil-normal-state-p) (propertize "N"))
                     ((evil-visual-state-p) (propertize "V"))))
       ;; buffer modified status
       ","
       '(:eval (if (buffer-modified-p)
                 (propertize "M" 'face '(:foreground "#880000"))
                 (propertize "*")))
       ;; read only status
       '(:eval (when buffer-read-only
                 (concat "," (propertize "RO" 'face '(:foreground "#880000")))))
       "] "
       ;; time and uptime
       "["
       '(:eval (propertize (format-time-string "%H:%M")))
       "] %-"
       ))

;;theme
(load "~/.emacs.d/colors/tron.el")


;;###############################;;
;;                               ;;
;;     Global Keybindings        ;;
;;                               ;;
;;###############################;;

;; keybinds
(global-set-key "\C-x\C-n" 'bury-buffer)
(global-set-key "\M-g" 'set-mark-and-goto-line)
(global-set-key (kbd "s-n") 'linum-mode)
(global-set-key [delete] 'delete-char)

;; EVIL keybindings
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
(key-chord-define evil-visual-state-map "jj" 'evil-normal-state)
(define-key evil-motion-state-map ";" 'evil-ex)
(define-key evil-insert-state-map "\C-k" 'evil-previous-line)
(define-key evil-insert-state-map "\C-j" 'evil-next-line)
(define-key evil-insert-state-map "\C-h" 'evil-backward-char)
(define-key evil-insert-state-map "\C-l" 'evil-forward-char)
(define-key evil-insert-state-map [up] 'evil-previous-line)
(define-key evil-insert-state-map [down] 'evil-next-line)
(define-key evil-normal-state-map "\C-e" 'evil-end-of-line)
(define-key evil-insert-state-map "\C-e" 'end-of-line)
(define-key evil-visual-state-map "\C-e" 'evil-end-of-line)
(define-key evil-motion-state-map "\C-e" 'evil-end-of-line)
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)


;; SR-Speedbar keybindings
(global-set-key (kbd "s-b") 'sr-speedbar-toggle)

;; Change font size
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

;; Meta
(global-set-key "\M- " 'set-mark-command)
(global-set-key "\M-\C-h" 'backward-kill-word)
(global-set-key "\M-\C-r" 'query-replace)
(global-set-key "\M-r" 'replace-string)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-h" 'help-command)

;; Resize windows
(global-set-key (kbd "<C-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-right>") 'enlarge-window-horizontally)
(global-set-key (kbd "<C-down>") 'shrink-window)
(global-set-key (kbd "<C-up>") 'enlarge-window)

;; Move between windows
(global-set-key (kbd "<S-left>")  'windmove-left)
(global-set-key (kbd "<S-right>") 'windmove-right)
(global-set-key (kbd "<S-up>")    'windmove-up)
(global-set-key (kbd "<S-down>")  'windmove-down)

;; Move between frames
(global-set-key (kbd "<s-tab>")  'other-frame)

;; Function keys
(global-set-key [f1] 'manual-entry)
(global-set-key [f2] 'info)
(global-set-key [f3] 'repeat-complex-command)
(global-set-key [f4] 'advertised-undo)
(global-set-key [f5] 'eval-current-buffer)
(global-set-key [f6] 'buffer-menu)
(global-set-key [f7] 'other-window)
(global-set-key [f8] 'find-file)
(global-set-key [f9] 'save-buffer)
(global-set-key [f10] 'next-error)
(global-set-key [f11] 'compile)
(global-set-key [f12] 'grep)
(global-set-key [C-f1] 'compile)
(global-set-key [C-f2] 'grep)
(global-set-key [C-f3] 'next-error)
(global-set-key [C-f4] 'previous-error)
(global-set-key [C-f5] 'display-faces)
(global-set-key [C-f8] 'dired)
(global-set-key [C-f10] 'kill-compilation)

;; Keypad bindings
(global-set-key [up] "\C-p")
(global-set-key [down] "\C-n")
(global-set-key [left] "\C-b")
(global-set-key [right] "\C-f")
(global-set-key [home] "\C-a")
(global-set-key [end] "\C-e")
(global-set-key [prior] "\M-v")
(global-set-key [next] "\C-v")
(global-set-key [C-home] "\M-<")
(global-set-key [C-end] "\M->")
(global-set-key [C-prior] "\M-<")
(global-set-key [C-next] "\M->")


;;###############################;;
;;                               ;;
;;     Mode Settings             ;;
;;                               ;;
;;###############################;;

(if first-time
    (setq auto-mode-alist
          (append '(("\\.c$"     . c-mode)
                    ("\\.h$"     . c-mode)
                    ("\\.cpp$"   . c++-mode)
                    ("\\.hpp$"   . c++-mode)
                    ;;("\\.scala$" . scala-mode)
                    ("\\.lsp$"   . lisp-mode)
                    ("\\.scm$"   . scheme-mode)
                    ("\\.pl$"    . perl-mode)
                    ("\\.py$"    . python-mode)
                    ("\\.asm$"   . gas-mode)
                    )auto-mode-alist)))

(add-hook 'c-mode-hook
          (lambda ()
            (setq tab-width 4)
            (define-key c-mode-map "\C-m" 'reindent-then-newline-and-indent)
            (define-key c-mode-map "\C-ce" 'c-comment-edit)
            (setq c-auto-hungry-initial-state 'none)
            (setq c-delete-function 'backward-delete-char)
            (setq c-tab-always-indent t)
            (setq c-indent-level 4)
            (setq c-continued-statement-offset 4)
            (setq c-brace-offset -4)
            (setq c-argdecl-indent 0)
            (setq c-label-offset -4)))

(add-hook 'c++-mode-hook
          (lambda ()
            (setq tab-width 4)
            (define-key c++-mode-map "\C-m" 'reindent-then-newline-and-indent)
            (define-key c++-mode-map "\C-ce" 'c-comment-edit)
            (setq c++-auto-hungry-initial-state 'none)
            (setq c++-delete-function 'backward-delete-char)
            (setq c++-tab-always-indent t)
            (setq c-indent-level 4)
            (setq c-continued-statement-offset 4)
            (setq c++-empty-arglist-indent 4)))

(add-hook 'perl-mode-hook
          (lambda ()
            (setq tab-width 4)
            (define-key c++-mode-map "\C-m" 'reindent-then-newline-and-indent)
            (setq perl-indent-level 4)
            (setq perl-continued-statement-offset 4)))

(add-hook 'scheme-mode-hook
          (lambda ()
            (define-key scheme-mode-map "\C-m" 'reindent-then-newline-and-indent)))

(add-hook 'lisp-mode-hook
          (lambda ()
            (define-key lisp-mode-map "\C-m" 'reindent-then-newline-and-indent)
            (define-key lisp-mode-map "\C-i" 'lisp-indent-line)
            (define-key lisp-mode-map "\C-j" 'eval-print-last-sexp)))

(add-hook 'python-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (setq tab-width 4)
            (setq python-indent 4)))

(add-hook 'gas-mode-hook
          (lambda ()
            (setq gas-comment-column 54)))


;;###############################;;
;;                               ;;
;;     User Functions            ;;
;;                               ;;
;;###############################;;

;; Fullscreen
(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
                         (if (equal 'fullboth current-value)
                             (if (boundp 'old-fullscreen) old-fullscreen nil)
                           (progn (setq old-fullscreen current-value)
                                  'fullboth)))))
(global-set-key [f11] 'toggle-fullscreen)

;; switch buffers
(defun switch-to-other-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer)))
(global-set-key "\C-x\C-o" 'switch-to-other-buffer)

;; goto function
(defun set-mark-and-goto-line (line)
  (interactive "NLine #: ")
  (push-mark nil t nil)
  (goto-line line)
  (message "Mark set where you came from."))

;; remove a line of text
(defun nuke-line()
  "Kill an entire line, including the trailing newline character"
  (interactive)
  (setq previous-column (current-column))
  (end-of-line)
  (if (= (current-column) 0)
jj      (delete-char 1)
    (progn
      (beginning-of-line)
      (kill-line)
      (delete-char 1)
      (move-to-column previous-column))))
(global-set-key "\M-n" 'nuke-line)


;;###############################;;
;;                               ;;
;;     Plugin Settings           ;;
;;                               ;;
;;###############################;;

;; EVIL Settings
(evil-mode 1)
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(evil-set-initial-state 'shell-mode 'emacs)
(evil-set-initial-state 'term-mode 'emacs)
(evil-set-initial-state 'ansi-term-mode 'emacs)
(setq evil-normal-state-cursor '("#356A9C" hollow))
(setq evil-insert-state-cursor '("#6FC3DF" hbar))
(setq evil-visual-state-cursor '("#6FC3DF"))
(setq evil-emacs-state-cursor '("#6FC3DF"))

;; SLIME Settings
(setq inferior-lisp-program "/usr/bin/sbcl")
(slime-setup)

;; Key Chord Settings
(key-chord-mode 1)
(setq key-chord-two-keys-delay 1.0)

;; Multi-Term Settings
(autoload 'multi-term "multi-term" nil t)
(autoload 'multi-term-next "multi-term" nil t)
(setq multi-term-program "/bin/bash")
(global-set-key (kbd "C-c t") 'multi-term-next)
(global-set-key (kbd "C-c T") 'multi-term)
(custom-set-variables
 '(speedbar-use-images nil)
 '(term-default-bg-color "#000000")
 '(term-default-fg-color "#6FC3DF"))

;; EShell Settings
(setq eshell-prompt-function
  (lambda nil
    (concat
     (propertize (eshell/pwd) 'face '(:foreground "#B2FFFF"))
     (propertize " $ " 'face '(:foreground "#B2FFFF")))))
(setq eshell-highlight-prompt nil)

(defun eshell/clear ()
  "Clear the eshell buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)))

;; SR-Speedbar Settings
(setq sr-speedbar-right-side t)
(setq sr-speedbar-show-unknown-files t)
(setq sr-speedbar-use-icons nil)
