;; haskell-mode convenience functions
;;
;; haskell-line-to-repl trims a line and sends it to the interactive haskell
;; process useful for testing out code in a monadic block interactively Now you
;; can run those send those x <- monadStuff lines of code with ease
;;
;; author: HVic
;;
;; INSTALL
;; add the following lines to to .emacs or .spacemacs (in user-config):
;; (load-file "/path/to/haskell-mode-extra.el")
;; (require 'haskell-mode)
;; (define-key haskell-mode-map (kbd "<C-return>") 'haskell-line-to-repl)

;; trim code: http://ergoemacs.org/emacs/modernization_elisp_lib_problem.html
(defun s-trim-left (s)
  (if (string-match "\\`[ \t\n\r]+" s)
      (replace-match "" t t s)
    s))

(defun s-trim-right (s)
  (if (string-match "[ \t\n\r]+\\'" s)
      (replace-match "" t t s)
    s))

(defun s-trim (s)
  (s-trim-left (s-trim-right s)))

(defun haskell-line-to-repl ()
  (interactive)
  (let ((trimmed (s-trim (thing-at-point 'line))))
    (haskell-interactive-switch)
    (goto-char (point-max))
    (insert trimmed)
    (funcall (key-binding (kbd "RET"))) 
    (goto-char (point-max))
    (haskell-interactive-switch-back)
    (forward-line 1)
    )
  )
