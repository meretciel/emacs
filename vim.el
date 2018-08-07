

;; define the ,vim mode
(defvar vim-normal-mode nil "Mode that replicate some of the vim functionality")
(make-variable-buffer-local 'vim-normal-mode)


(defvar vim-normal-mode-cursor-color "#FF0000"
  "Cursor color when in the normal mode.")




;; define the keymap and add keybinding
(defvar vim-normal-mode-map nil "Keymap for vim-major mode")
(if vim-normal-mode-map
	nil
    (progn
	  (setq vim-normal-mode-map (make-keymap))
	  (suppress-keymap vim-normal-mode-map)))


	  
;; movement 
(define-key vim-normal-mode-map (kbd "h") 'backward-char)
(define-key vim-normal-mode-map (kbd "j") 'next-line)
(define-key vim-normal-mode-map (kbd "k") 'previous-line)
(define-key vim-normal-mode-map (kbd "l") 'forward-char)
(define-key vim-normal-mode-map (kbd "b") 'backward-word)
(define-key vim-normal-mode-map (kbd "e") 'vim-shortcut-e)
;;(define-key vim-normal-mode-map (kbd "E") 'forward-word)
(define-key vim-normal-mode-map (kbd "w") 'vim-shortcut-w)

(define-key vim-normal-mode-map (kbd "i") 'disable-vim-normal-mode)
(define-key vim-normal-mode-map (kbd "a") 'vim-shortcut-a)

(define-key vim-normal-mode-map (kbd ":w RET") 'save-buffer)
(define-key vim-normal-mode-map (kbd ",d") 'vim-shortcut-delete-all)
(define-key vim-normal-mode-map (kbd ":open RET") 'find-file)
(define-key vim-normal-mode-map (kbd ":new RET") 'find-file-horizontal-split)
(define-key vim-normal-mode-map (kbd ":buffer RET") 'switch-to-buffer)
(define-key vim-normal-mode-map (kbd ":killbuffer RET") 'kill-buffer)
(define-key vim-normal-mode-map (kbd ":vnew RET") 'find-file-vertical-split)
(define-key vim-normal-mode-map (kbd ":vsplit RET") 'split-window-horizontally)
(define-key vim-normal-mode-map (kbd ":hsplit RET") 'split-window-vertically)
(define-key vim-normal-mode-map (kbd ":close RET") 'delete-window)
(define-key vim-normal-mode-map (kbd "A") 'vim-shortcut-move-end-of-line)
(define-key vim-normal-mode-map (kbd "I") 'vim-shortcut-move-beginning-of-line)
(define-key vim-normal-mode-map (kbd "gg") 'beginning-of-buffer)
(define-key vim-normal-mode-map (kbd "go") 'goto-line)
(define-key vim-normal-mode-map (kbd "G") 'vim-shortcut-G)
(define-key vim-normal-mode-map (kbd "dd") 'vim-shortcut-remove-line)
(define-key vim-normal-mode-map (kbd "x") 'delete-forward-char)
(define-key vim-normal-mode-map (kbd "^") 'move-beginning-of-line)
(define-key vim-normal-mode-map (kbd "$") 'move-end-of-line)
(define-key vim-normal-mode-map (kbd "o") 'vim-shortcut-open-newline-below)
(define-key vim-normal-mode-map (kbd "s") 'vim-shortcut-substitute)


;; This section related to visual mode
(define-key vim-normal-mode-map (kbd "v") 'enable-vim-visual-mode)
(define-key vim-normal-mode-map (kbd "V") 'enable-vim-visual-line-mode)

(define-key vim-normal-mode-map (kbd "C-a") 'mark-whole-buffer)
;; This section will have global impact
(defvar vim-special-keymap-j nil "keymap for prefix key j")
(defvar vim-special-keymap-g nil "keymap for prefix key g")
(defvar vim-special-keymap-o nil "keymap for prefix key o")
(defvar vim-special-keymap-v nil "keymap for prefix key v")

(setq vim-special-keymap-j (make-sparse-keymap))


(setq vim-special-keymap-j
 (append vim-special-keymap-j '((t . vim-insert-prefix-j))))


(defun vim-insert-prefix-j ()
  (interactive)
  (insert "j")
  (self-insert-command 1))








(define-key vim-special-keymap-j (kbd "k") 'enable-vim-normal-mode)





(global-set-key (kbd "j") vim-special-keymap-j)
(global-set-key (kbd "<ESC><ESC><ESC>") 'vim-shortcut-exit)


(defun vim-shortcut-move-end-of-line ()
  (interactive)
  (move-end-of-line nil)
  (disable-vim-normal-mode))

(defun vim-shortcut-move-beginning-of-line ()
  (interactive)
  (move-beginning-of-line nil)
  (disable-vim-normal-mode))

(defun vim-shortcut-remove-line ()
  (interactive)
  (if (not (eq (line-beginning-position) (line-end-position) ))
	  (progn
		(move-beginning-of-line nil)
		(kill-line)))
  (delete-forward-char 1))


(defun vim-shortcut-open-newline-below (&optional N)
  (interactive "P")
  (move-beginning-of-line 2)
  
  (let ((n (if (null N)
			   1
			 (prefix-numeric-value N))))
	(open-line n))
  (disable-vim-normal-mode))



(defun vim-shortcut-substitute ()
  (interactive)
  (delete-forward-char 1)
  (disable-vim-normal-mode))


(defun vim-shortcut-exit ()
  (interactive)
  (enable-vim-normal-mode)
  (keyboard-quit))

(defun vim-shortcut-e ()
  (interactive)
  (forward-word 1)
  (backward-char 1))

(defun vim-shortcut-w ()
  (interactive)
  (forward-word 2)
  (backward-word 1))

(defun vim-shortcut-a ()
  (interactive)
  (forward-char 1)
  (disable-vim-normal-mode))

(defun vim-shortcut-G (&optional N)
  (interactive "P")
  (if (null N)
	  (end-of-buffer)
	(goto-line (prefix-numeric-value N))))
	  


(defun vim-shortcut-delete-all ()
  (interactive)
  (mark-whole-buffer)
  (kill-region (region-beginning) (region-end)))



;; define the vim mode function
(defun vim-normal-mode (&optional arg)
    "vim mode."
	(interactive "P")
	(setq vim-normal-mode
		(if (null arg)
			(not vim-normal-mode)
		  (> (prefix-numeric-value arg) 0)))
	(if vim-normal-mode
		(set-cursor-color vim-normal-mode-cursor-color)
	  (set-cursor-color global-constant-cursor-color)))



(if (not (assq 'vim-normal-mode minor-mode-alist))
	(setq minor-mode-alist
		  (cons '(vim-normal-mode " vim-normal") minor-mode-alist)))

(if (not (assq 'vim-normal-mode minor-mode-map-alist))
	(setq minor-mode-map-alist
		  (cons (cons 'vim-normal-mode vim-normal-mode-map)
				minor-mode-map-alist)))


(defun enable-vim-normal-mode ()
  (interactive)
  (message "enable vim normal mode")
  (disable-vim-visual-mode)
  (disable-vim-visual-line-mode)
  (vim-normal-mode 1)
  (force-mode-line-update))

(defun disable-vim-normal-mode ()
  (interactive)
  (message "disable vim normal mode.")
  (vim-normal-mode 0)
  (disable-vim-visual-mode)
  (disable-vim-visual-line-mode)
  (force-mode-line-update))

(defun find-file-horizontal-split (filename)
  (interactive "f")
  (split-window-vertically)
  (find-file-other-window filename))


(defun find-file-vertical-split (filename)
  (interactive "f")
  (split-window-horizontally)
  (find-file-other-window filename))


(defun vim-update-cursor-color ()
  	(if vim-normal-mode
		(set-cursor-color vim-normal-mode-cursor-color)
	  (set-cursor-color global-constant-cursor-color)))

;; Update the cursor color before each commande
;; This has global effect.
(add-hook 'pre-command-hook 'vim-update-cursor-color)

