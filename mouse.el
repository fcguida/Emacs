
;; ====================================================================== ;;
;; Win32 Gnu Emacs mouse functions and bindings

(defun mouse-copy-sexp (event)
  "(fcg) Copy the sexp at the mouse cursor and insert it at point.
If the mouse event occured in another screen, copy the sexp from there.
If mouse cursor is at the end of a line, copy the entire line."
  (interactive "e")
  (let (beg end sexp)
    (save-excursion
      (save-window-excursion
	(mouse-set-point event)
	(if (eolp)
	    (setq beg (progn (beginning-of-line) (point))
		  end (progn (forward-line 1) (point)))
	  (setq beg (point)
		end (progn (unwind-protect (forward-sexp 1)) (point))))
	(setq sexp (buffer-substring beg end))))
    (insert sexp)))


(defun mouse-delete-sexp (event)
  "(fcg) Delete the sexp at the mouse cursor (the deleted text is not
placed in the kill-ring).  If the mouse cursor is at the end of a line,
kill the current line instead."
  (interactive "e")
  (mouse-set-point event)
  (if (eolp)
      (progn
	(beginning-of-line 1)
	(delete-region (point) (progn (end-of-line 1) (point))))
    (delete-region (point) (progn (forward-sexp 1) (point)))))


(defun mouse-swap-sexps (event)
  "(fcg) Swap the sexp at point with the one at the mouse click."
  (interactive "e")

  (let (p1 p2 s1)

    (save-excursion
      (save-window-excursion

	(setq s1 (buffer-substring
		  (point) (progn (forward-sexp 1) (point))))

	(mouse-set-point event)
	(insert s1)

	(setq p1 (point)
	      p2 (progn (forward-sexp 1) (point))
	      s1 (buffer-substring p1 p2))
	(delete-region p1 p2)))

    (save-excursion
      (insert s1)
      (delete-region (point)
		     (progn (forward-sexp 1) (point))))
))


(defun mouse-delete-word (event)
  "(fcg) Delete the sexp at the mouse cursor (the deleted text is not
placed in the kill-ring).  If the mouse cursor is at the end of a line,
kill the current line instead."
  (interactive "e")
  (mouse-set-point event)
  (delete-region (point) (progn (forward-word 1) (point))))


(defun mouse-swap-lines (event)
  "(fcg) Swap the line point in on with the one the mouse cursor is on."
  (interactive "e")
  (let ((start-col (current-column))
	point-line
	mouse-line
	beg end)
    (save-excursion
      (save-window-excursion
	(beginning-of-line)
	(setq beg (point)
	      end (progn (end-of-line) (point)))
	(setq point-line (buffer-substring beg end))
	(delete-region beg end)
	(mouse-set-point event)
	(beginning-of-line)
	(insert point-line)
	(setq beg (point)
	      end (progn (end-of-line) (point)))
	(setq mouse-line (buffer-substring beg end))
	(delete-region beg end)))
    (insert mouse-line)
    (move-to-column start-col)))

;; ====================================================================== ;;
;; Mouse Bindings

(define-key global-map [C-mouse-1]   	'mouse-copy-sexp)
(define-key global-map [C-down-mouse-1] 'nil)

(define-key global-map [C-mouse-3]   	'mouse-delete-sexp)
(define-key global-map [C-down-mouse-3] 'nil)

(define-key global-map [C-S-mouse-1]    'mouse-swap-lines)

(define-key global-map [C-S-mouse-3]   	'mouse-swap-sexps)

;; (define-key global-map 'button3		    	'mouse-track-adjust)
;; (define-key global-map '(control shift button3) 'mouse-swap-lines)
;; (define-key global-map '(control meta button1)  'open-rectangle)
;; (define-key global-map '(control meta button2)  'kill-rectangle)

;; (define-key global-map '(shift button3)	'function-menu)

;(define-key Buffer-menu-mode-map '(control button1) 'Buffer-menu-mouse-delete)
;(define-key Buffer-menu-mode-map '(control button2) 'Buffer-menu-other-window)

;; EOF ;;
