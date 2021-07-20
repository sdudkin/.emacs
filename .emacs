;;;; Sergey's .emacs file
;; 01 jule 2021
;; Dudkin Sergey Uryevich
;; Each section in this file is introduced by a
;; line beginning with four semicolons; and each
;; entry is introduced by a line beginning with
;; three semicolons.

;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-enabled-themes (quote (misterioso)))
 '(inhibit-startup-screen t)
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;; Disable menu, tools and scroll bars in GUI mode
(when window-system
  (menu-bar-mode -1)
  (toggle-scroll-bar -1)
  (tool-bar-mode -1))

;;; Text mode and Auto Fill mode
;; The next two lines put Emacs into Text mode
;; and Auto Fill mode, and are for writers who
;; want to start writing prose rather than code.
(setq-default major-mode 'text-mode)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;;;; C style
;;; Linux kernel style
(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
         (column (c-langelem-2nd-pos c-syntactic-element))
         (offset (- (1+ column) anchor))
         (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))


(add-hook 'c-mode-common-hook
          (lambda ()
            ;; Add kernel style
            (c-add-style
             "linux-tabs-only"
             '("linux" (c-offsets-alist
                        (arglist-cont-nonempty
                         c-lineup-gcc-asm-reg
                         c-lineup-arglist-tabs-only))))))

(add-hook 'c-mode-hook
          (lambda ()
            (setq indent-tabs-mode t)
	     (setq show-trailing-whitespace t)
	     (c-set-style "linux-tabs-only")))

;;; Column enforce mode
;; set limit for columns in line
(load-file (expand-file-name "~/.emacs.d/column-enforce-mode.el"))
;; enable by default for CC mode
(add-hook 'c-mode-hook 'column-enforce-mode)
(setq column-enforce-comments t)
;; columns with number more than 80 will be highlighted
(setq column-enforce-column 80)
(global-set-key "\C-cc" 'column-enforce-mode)

;;; Narrowing
;; C-x n n Narrow down to between point and mark (narrow-to-region).
;; C-x n w Widen to make the entire buffer accessible again (widen).
;; C-x n p Narrow down to the current page (narrow-to-page).
;; C-x n d Narrow down to the current defun (narrow-to-defun).
(put 'narrow-to-region 'disabled nil)

;;; Compare windows
(global-set-key "\C-cw" 'compare-windows)

;;; Keybinding for 'occur'
(global-set-key "\C-co" 'occur)

;;; Unbind 'C-x f'
(global-unset-key "\C-xf")

