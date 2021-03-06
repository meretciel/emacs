
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

;; Basic Movement 
(define-key vim-normal-mode-map (kbd "h") 'backward-char)
(define-key vim-normal-mode-map (kbd "j") 'next-line)
(define-key vim-normal-mode-map (kbd "k") 'previous-line)
(define-key vim-normal-mode-map (kbd "l") 'forward-char)

;; Movement related to work
(define-key vim-normal-mode-map (kbd "b") 'backward-word)
(define-key vim-normal-mode-map (kbd "B") 'vim-shortcut-B)
(define-key vim-normal-mode-map (kbd "e") 'vim-shortcut-e)
(define-key vim-normal-mode-map (kbd "E") 'vim-shortcut-E)
(define-key vim-normal-mode-map (kbd "w") 'vim-shortcut-w)
(define-key vim-normal-mode-map (kbd "W") 'vim-shortcut-W)

;; Editing Shortcuts
(define-key vim-normal-mode-map (kbd "S") 'vim-shortcut-S)
(define-key vim-normal-mode-map (kbd "P") 'yank)
(define-key vim-normal-mode-map (kbd "p") 'vim-shortcut-p)
(define-key vim-normal-mode-map (kbd "yy") 'vim-shortcut-yy)

(define-key vim-normal-mode-map (kbd "i") 'disable-vim-normal-mode)
(define-key vim-normal-mode-map (kbd "a") 'vim-shortcut-a)
(define-key vim-normal-mode-map (kbd "C-c C-n") 'vim-toggle-relative-line)
(define-key vim-normal-mode-map (kbd ":w RET") 'save-buffer)
(define-key vim-normal-mode-map (kbd ",d") 'vim-shortcut-delete-all)
;;(define-key vim-normal-mode-map (kbd ":open RET") 'find-file)
;;(define-key vim-normal-mode-map (kbd ":edit RET") 'find-file)
;;(define-key vim-normal-mode-map (kbd ":new RET") 'find-file-horizontal-split)
;;(define-key vim-normal-mode-map (kbd ":newframe RET") 'make-frame-command)
;;(define-key vim-normal-mode-map (kbd ":buffer RET") 'switch-to-buffer)
;;(define-key vim-normal-mode-map (kbd ":killbuffer RET") 'kill-buffer)
;;(define-key vim-normal-mode-map (kbd ":vnew RET") 'find-file-vertical-split)
;;(define-key vim-normal-mode-map (kbd ":vsplit RET") 'split-window-horizontally)
;;(define-key vim-normal-mode-map (kbd ":hsplit RET") 'split-window-vertically)
;;(define-key vim-normal-mode-map (kbd ":close RET") 'delete-window)
(define-key vim-normal-mode-map (kbd "::") 'execute-extended-command)
(define-key vim-normal-mode-map (kbd "A") 'vim-shortcut-move-end-of-line)
(define-key vim-normal-mode-map (kbd "I") 'vim-shortcut-move-beginning-of-line)
(define-key vim-normal-mode-map (kbd "gg") 'beginning-of-buffer)
(define-key vim-normal-mode-map (kbd "go") 'goto-line)
(define-key vim-normal-mode-map (kbd "G") 'vim-shortcut-G)
(define-key vim-normal-mode-map (kbd "dd") 'vim-shortcut-remove-line)
(define-key vim-normal-mode-map (kbd "x") 'delete-forward-char)
(define-key vim-normal-mode-map (kbd "^") 'move-beginning-of-line)
(define-key vim-normal-mode-map (kbd "0") 'move-beginning-of-line)
(define-key vim-normal-mode-map (kbd "$") 'move-end-of-line)
;;(define-key vim-normal-mode-map (kbd "o") 'vim-shortcut-open-newline-below)
(define-key vim-normal-mode-map (kbd "o") 'vim-shortcut-o-trigger)
(define-key vim-normal-mode-map (kbd "O") 'vim-shortcut-O-trigger)
(define-key vim-normal-mode-map (kbd "s") 'vim-shortcut-substitute)
(define-key vim-normal-mode-map (kbd "/") nil)

(defalias 'edit     'find-file)
(defalias 'buffer   'switch-to-buffer)
(defalias 'bf       'switch-to-buffer)
(defalias 'buffernf 'switch-to-buffer-other-frame)
(defalias 'bfnf     'switch-to-buffer-other-frame)
(defalias 'vsplit   'split-window-horizontally)
(defalias 'hsplit   'split-window-vertically)
(defalias 'kb       'kill-buffer)
(defalias 'close    'delete-window)
(defalias 'new-frame 'make-frame-command)
(defalias 'nf        'make-frame-command)
(defalias 'edit-in-new-frame 'find-file-other-frame)
(defalias 'editnf 'find-file-other-frame)
(defalias 'edit-nf 'find-file-other-frame)
;; This section is related to parenthesis matching in normal mode
(define-key vim-normal-mode-map (kbd "%") 'vim-paren-match)


;; This section is related to visual mode
(define-key vim-normal-mode-map (kbd "v") 'enable-vim-visual-mode)
(define-key vim-normal-mode-map (kbd "V") 'enable-vim-visual-line-mode)

(define-key vim-normal-mode-map (kbd "C-a") 'mark-whole-buffer)
;; This section will have global impact
(defvar vim-special-keymap-g nil "keymap for prefix key g")
(defvar vim-special-keymap-o nil "keymap for prefix key o")
(defvar vim-special-keymap-v nil "keymap for prefix key v")


;; Define the special keymap with prefix j.

;; Option 1
;;(defvar vim-special-keymap-j nil "keymap for prefix key j")
;;(setq vim-special-keymap-j (make-sparse-keymap))

;;(setq vim-special-keymap-j
;; (append vim-special-keymap-j '((t . vim-insert-prefix-j))))

;;(defun vim-insert-prefix-j ()
;;  (interactive)
;;  (insert "j")
;;  (self-insert-command 1))
;;(define-key vim-special-keymap-j (kbd "k") 'enable-vim-normal-mode)

;; Opetion 2
;;(defvar vim-special-keymap-j nil "keymap for prefix key j")
(defvar vim-special-keymap-j (utils-make-special-key-map "j"))
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
  (if (not (equal (line-beginning-position) (line-end-position) ))
	  (progn
		(move-beginning-of-line nil)
		(kill-line)))
  (delete-forward-char 1))


(defun vim-shortcut-open-newline-below (&optional N)
  (interactive "P")
  (let ((current-line (line-number-at-pos)))
	(move-beginning-of-line 2)
	(if (equal current-line (line-number-at-pos))
		(progn
		  (move-end-of-line nil)
		  (insert "\n"))))
 
  (let ((n (if (null N)
			   1
			 (prefix-numeric-value N))))
	(open-line n))
  (disable-vim-normal-mode))

(defun vim-shortcut-o-trigger (&optional N)
  (interactive "P")
  (with-timeout (0.18 (vim-shortcut-open-newline-below N))
	(let ((user-input (read-char)))
	  (if (equal user-input ?o)
		  ;; insert a new line below and disable the normal mode
		  (let ( (n (if (null N) 1 (prefix-numeric-value N)))
				 (prev-pos (point)))
			(move-end-of-line nil)
			(insert (make-string n ?\n))
			(goto-char prev-pos))
		
		(move-end-of-line nil)
		(insert "\n")
		(insert user-input)
		(disable-vim-normal-mode)))))

(defun vim-shortcut-O-helper (&optional N)
  (let ( (n (if (null N) 1 (prefix-numeric-value N))) )
	(move-beginning-of-line nil)
	(insert (make-string n ?\n))
	(move-beginning-of-line 0)))
  

(defun vim-shortcut-O-trigger (&optional N)
  (interactive "P")
  (with-timeout (0.18
				 (vim-shortcut-O-helper N)
				 (disable-vim-normal-mode))

	(let ( (user-input (read-char)) )
	  (if (equal user-input ?O)
		  (let ( (n (if (null N) 1 (prefix-numeric-value N)))
				 (prev-pos (point)) )
			(move-beginning-of-line nil)
			(insert (make-string n ?\n))
			(goto-char (+ n prev-pos)))

		(move-beginning-of-line nil)
		(insert "\n")
		(move-beginning-of-line -1)
		(insert user-input)
		(disable-vim-normal-mode)))))


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
  (let ( (prev-pos (point)) )
	(forward-word 1)
	(backward-char 1)
	(if (= prev-pos (point))
		(progn 
		  (forward-char)
		  (vim-shortcut-e)))))
	  

(defun vim-shortcut-w ()
  (interactive)
  (forward-word 2)
  (backward-word 1))

(defun vim-shortcut-a ()
  (interactive)
  (let ( (prev-pos (point)) )
	(move-end-of-line nil)
	(if (equal prev-pos (point))
		(progn
		  (insert " ")
		  (disable-vim-normal-mode))
	  (goto-char prev-pos)
	  (forward-char 1)
	  (disable-vim-normal-mode))))

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
  (force-mode-line-update)
  (keyboard-quit))

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

;; Maybe we do not need this one.
(defvar vim-start-new-line-when-paste nil
  "If we need to start a new line when paste.
   Note that if we use the default keybinding to past, this will break.")

(defvar vim-start-new-line-text nil
  "This stores the string that requires to start a new line when paste.")

;;(make-variable-buffer-local 'vim-start-new-line-when-paste)
;;(make-variable-buffer-local 'vim-start-new-line-text)


(defun vim-shortcut-p ()
  (interactive)
  (let (start end (current (point)))
	(if (and vim-start-new-line-when-paste
			 (string= (car kill-ring-yank-pointer)
				 vim-start-new-line-text))
		(progn
		  (move-end-of-line nil)
		  (open-line 1)
		  (next-line)
		  (yank))

	(move-beginning-of-line nil)
	(setq start (point))
	(move-end-of-line nil)
	(setq end (point))
	(cond
	 ( (eq start end) ;; the line is empty
	   (yank))
	 ( (eq current end)
	   (insert " ")
	   (yank))
	 ( t
	   (goto-char current)
	   (forward-char)
	   (yank))))))

(defun vim-shortcut-yy ()
  (interactive)
  (let (start end (point-before (point)))
	(move-beginning-of-line nil)
	(setq start (point))
	(move-end-of-line nil)
	(setq end (point))
	(kill-ring-save start end)
	(setq vim-start-new-line-when-paste t)
	(setq vim-start-new-line-text (car kill-ring-yank-pointer))
	(goto-char point-before)))


(defun vim-paren-match ()
  "If the cursor is on a (), press % will make the cursor jump to the matched paren."
  (interactive)
  (let ( (current-char (following-char)))
	(cond
	 ( (equal current-char ?\()
	   (forward-list)
	   (backward-char))
	 ( (equal current-char ?\))
	   (forward-char)
	   (backward-list)))))


(defun vim-shortcut-S ()
  (interactive)
  (if (utils-empty-line-p)
	  (disable-vim-normal-mode)
	(kill-whole-line)
	(disable-vim-normal-mode)))

;;(define-key vim-normal-mode-map (kbd "C-c C-n") 'vim-toggle-relative-line)
(defun vim-toggle-relative-line ()
  (interactive)
  (cond
   ( (eq display-line-numbers t) (setq display-line-numbers 'relative))
   ( (eq display-line-numbers 'relative) (setq display-line-numbers t))))


(defun vim-shortcut-E ()
  (interactive)
  (let ((current-pos (point)))
	(skip-chars-forward "^ \n\t")
	(backward-char)
	(if (>= current-pos (point))
		(progn
		  (forward-char)
		  (skip-chars-forward " \n\t")
		  (vim-shortcut-E)))))
	  
(defun vim-shortcut-B ()
  (interactive)
  (let ((current-pos (point)))
	(skip-chars-backward "^ \n\t")
	(if (<= current-pos (point))
		(progn
		  (skip-chars-backward " \n\t")
		  (vim-shortcut-B)))))


(defun vim-shortcut-W ()
  (interactive)
  (let ((current-pos (point)))
	(vim-shortcut-E)
	(forward-char)
	(skip-chars-forward " \n")))

(provide 'vim-normal-mode)
