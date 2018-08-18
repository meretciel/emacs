
;; In this script, we will implement some utility functions.




(defun utils-empty-line-p ()
  (let ( is-empty-line (previous-pos (point)))
	(move-beginning-of-line nil)
	(setq is-empty-line (looking-at "^$"))
	(goto-char previous-pos)
	is-empty-line))
