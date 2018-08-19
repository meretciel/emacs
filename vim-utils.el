
;; In this script, we will implement some utility functions.




(defun utils-empty-line-p ()
  (let ( is-empty-line (previous-pos (point)))
	(move-beginning-of-line nil)
	(setq is-empty-line (looking-at "^$"))
	(goto-char previous-pos)
	is-empty-line))


;;(defmacro utils-make-insert-prefix-func (prefix-char)
;;  (let ( ( insert-prefix-func-name  (concat "vim-insert-prefix-" prefix-char) ) )
;;	`(defun ,insert-prefix-func-name ()
;;	   (interactive)
;;	   (insert ,prefix-char)
;;	   (self-insert-command 1))))


;;(defmacro utils-make-special-key-map (prefix-char)
;;  `(let* ( (vim-insert-prefix-func (utils-make-insert-prefix-func ,prefix-char))
;;		   (vim-special-key-map '('keymap (t . vim-insert-prefix-func))))
;;	vim-special-key-map))
	



(defmacro utils-make-insert-prefix-func (prefix-char)
  (let ( ( insert-prefix-func-name  (make-symbol (concat "vim-insert-prefix-" prefix-char)) ) )
	`(defun ,insert-prefix-func-name ()
	   (interactive)
	   (insert ,prefix-char)
	   (self-insert-command 1))))


(defmacro utils-make-special-key-map (prefix-char) 
  (let ( (vim-insert-prefix-func (make-symbol "vim-insert-prefix-func"))
		 (vim-special-keymap     (make-symbol "vim-special-keymap")) ) 
	`(progn
		(fset (quote ,vim-insert-prefix-func) (utils-make-insert-prefix-func ,prefix-char))
		(setq ,vim-special-keymap '(keymap (t . ,vim-insert-prefix-func)))
		,vim-special-keymap)))


;;(defmacro utils-make-special-key-map (prefix-char) 
;;  `(let ( (vim-insert-prefix-func (make-symbol "vim-insert-prefix-func"))
;;		  (vim-special-keymap     (make-symbol "vim-special-keymap")) ) 
;;		(fset vim-insert-prefix-func (utils-make-insert-prefix-func ,prefix-char))
;;		(set vim-special-keymap '(keymap (t . vim-insert-prefix-func)))
;;		vim-special-keymap))

(defmacro utils-make-special-key-map (prefix-char) 
  `(let ( (vim-insert-prefix-func (make-symbol "vim-insert-prefix-func"))
		  (vim-special-keymap     (make-symbol "vim-special-keymap")))
	   (fset vim-insert-prefix-func (utils-make-insert-prefix-func ,prefix-char))
	   (set vim-special-keymap (list 'keymap (cons t (symbol-function vim-insert-prefix-func))))
	   (eval vim-special-keymap)))
