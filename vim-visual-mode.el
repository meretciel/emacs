;; In this file, we will define different visual mode

(defvar vim-global-const-comment-symbol ";;") 
(make-variable-buffer-local 'vim-global-const-comment-symbol)


;; (normal) visual mode

(defvar vim-visual-mode nil "Mode that replicates vim visual mode")
(make-variable-buffer-local 'vim-visul-mode)


;; define the keymap and add keybinding
(defvar vim-visual-mode-map nil "Keymap for vim-major mode")
(if vim-visual-mode-map
	nil
    (progn
	  (setq vim-visual-mode-map (make-sparse-keymap))))


;; visual line mode
(defvar vim-visual-line-mode nil "Repliate of vim visual-line mode")
(make-variable-buffer-local 'vim-visual-line-mode)

(defvar vim-visual-line-mode-map nil "Keymap for vim-visual-line mode")
(if vim-visual-line-mode-map
	nil
  (setq vim-visual-line-mode-map (make-sparse-keymap)))

;; define the key binding in the vim visual mode
(define-key vim-visual-mode-map (kbd "ESC") 'keyboard-quit)
(define-key vim-visual-mode-map (kbd "s")   'vvm-change-text)
(define-key vim-visual-mode-map (kbd "::")  'execute-extended-command)
(define-key vim-visual-mode-map (kbd ":x")  'eval-expression)
;;(define-key vim-visual-mode-map (kbd "M-:") 'eval-expression)



;; define the vim-visul-line-mode

(define-key vim-visual-line-mode-map (kbd "j")   'vvlm-next-line)
(define-key vim-visual-line-mode-map (kbd "k")   'vvlm-previous-line)
(define-key vim-visual-line-mode-map (kbd "d")   'vvlm-kill-selected)
(define-key vim-visual-line-mode-map (kbd "ESC") 'keyboard-quit)
(define-key vim-visual-line-mode-map (kbd ",c") 'vvlm-add-comment)
(define-key vim-visual-line-mode-map (kbd ",u") 'vvlm-remove-comment)
(define-key vim-visual-line-mode-map (kbd "::")  'execute-extended-command)
(define-key vim-visual-line-mode-map (kbd ":x")  'eval-expression)


(defun vim-visual-line-mode (&optional arg)
  "vim-visual-line mode"
  (interactive "P")
  (setq vim-visual-line-mode
		(if (null arg)
			(not vim-visul-line-mode)
		  (> (prefix-numeric-value arg) 0))))

(if (not (assq 'vim-visual-line-mode minor-mode-alist))
	(setq minor-mode-alist
		  (cons '(vim-visual-mode " vim-visual-line") minor-mode-alist)))

(if (not (assq 'vim-visual-line-mode minor-mode-map-alist))
	(setq minor-mode-map-alist
		  (cons (cons 'vim-visual-line-mode vim-visual-line-mode-map)
				minor-mode-map-alist)))




;; define the vim-visul mode function
(defun vim-visual-mode (&optional arg)
    "vim mode."
	(interactive "P")
	(setq vim-visual-mode
		(if (null arg)
			(not vim-visual-mode)
		  (> (prefix-numeric-value arg) 0))))



(if (not (assq 'vim-visual-mode minor-mode-alist))
	(setq minor-mode-alist
		  (cons '(vim-visual-mode " vim-visual") minor-mode-alist)))

(if (not (assq 'vim-visual-mode minor-mode-map-alist))
	(setq minor-mode-map-alist
		  (cons (cons 'vim-visual-mode vim-visual-mode-map)
				minor-mode-map-alist)))




(defun enable-vim-visual-mode ()
  (interactive)
  (message "enable vim visual mode")
  (vim-visual-mode 1)
  (set-mark-command nil)
  (force-mode-line-update))

(defun disable-vim-visual-mode ()
  (interactive)
  (message "disable vim visual mode")
  (vim-visual-mode 0)
  (force-mode-line-update))



(defun enable-vim-visual-line-mode ()
  (interactive)
  (message "enable vim-line-visual-mode")
  (vim-visual-line-mode 1)
  (force-mode-line-update)
  (move-beginning-of-line nil)
  (set-mark-command nil)
  (move-end-of-line nil))



(defun disable-vim-visual-line-mode ()
  (interactive)
  (message "disable vim-visual-line mode")
  (vim-visual-line-mode 0)
  (force-mode-line-update))


(defun vvlm-previous-line ()
  (interactive)
  (let* ((vvlm-line-of-point (line-number-at-pos (point)))
		 (vvlm-line-of-mark  (line-number-at-pos (mark-marker))))
	(cond
	 ( (eq vvlm-line-of-point vvlm-line-of-mark)
	   ;; Initially, the point and the mark are at the same lie
	   ;; The mark is at the beginning of the line and the point is at
	   ;; the end of the line. This can be considered as an invariant
	   (exchange-point-and-mark)
	   (previous-line))
	 ( t (previous-line)))
	(move-beginning-of-line nil)))

(defun vvlm-next-line ()
  (interactive)
  (let* ((vvlm-line-of-point (line-number-at-pos (point)))
		 (vvlm-line-of-mark  (line-number-at-pos (mark-marker))))
	(if (not (eq vvlm-line-of-point vvlm-line-of-mark))
		(next-line)
	  (if (< (point) (mark-marker))
		  (exchange-point-and-mark))
	  (next-line)
	  (move-end-of-line nil))))


(defun vvlm-kill-selected ()
  (interactive)
  (if (use-region-p)
	  (progn
		(kill-region (region-beginning) (region-end))
		(delete-forward-char 1)
		(setq vim-start-new-line-when-paste t)
		(setq vim-start-new-line-text (car kill-ring-yank-pointer))
		(enable-vim-normal-mode))))



;;(defun vvm-change-text ()
;;  (interactive)
;;  (forward-char)
;;  (kill-region (region-beginning) (region-end))
;;  (disable-vim-normal-mode))

(defun vvm-change-text ()
  (interactive)
  (let (( l-region-start (region-beginning) )
		( l-region-end   (region-end) ) )
	(move-end-of-line nil)
	(let ( (current-pos (point)) )
	  (if (equal l-region-end current-pos)
		  (kill-region l-region-start l-region-end)
		(goto-char l-region-end)
		(forward-char)
		(kill-region (region-begging) (region-end)))))
  (disable-vim-normal-mode))
		  

(defun vvlm-add-comment ()
  (interactive)
  (let ( ( start-pos (min (region-beginning) (region-end) ) )
		 ( num-lines (count-lines (region-beginning) (region-end)) ) )
	(goto-char start-pos)
	(cl-loop repeat num-lines do
			 (if (not (utils-empty-line-p))
				 (progn
				   (move-beginning-of-line nil)
				   (insert vim-global-const-comment-symbol)))
			   (move-beginning-of-line 2))
;;	(goto-char start-pos)
	(enable-vim-normal-mode)))


(defun vvlm-remove-comment ()
  (interactive)
  (let ( ( start-pos (min (region-beginning) (region-end) ) )
		 ( num-lines (count-lines (region-beginning) (region-end)) ) )
	(let ( limit
	       (target-string (concat "^" vim-global-const-comment-symbol)))
	  (goto-char start-pos)
	  (cl-loop repeat num-lines do
			   (if (not (utils-empty-line-p))
				   (progn
					 (move-end-of-line nil)
					 (setq limit (point))
					 (move-beginning-of-line nil)
					 (if (re-search-forward target-string limit t)
						 (replace-match ""))))
			   (move-beginning-of-line 2))
	  (goto-char start-pos)
	  (enable-vim-normal-mode))))






