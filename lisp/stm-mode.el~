;; a simple major mode for simtalk
;; create the list for font-lock.
;; each category of keyword is given a particular face
(setq mystm-font-lock-keywords
      (let* (
	     ;; define several categories of keywords
	     (x-keywords '("and" "else" "mod" "result" "elseif" "next" "return" "to" "basis" "end" "not" "root" "exitLoop" "until" "byref" "or" "self" "var" "continue" "for" "param" "create" "forget" "pi" "wait" "current" "if" "print" "stopuntil" "prio" "waituntil" "switch" "div"  "when" "downto" "loop" "repeat" "then" "while"))
	     (x-types '("Acceleration" "Money" "Any" "Object" "Array" "Queue" "Boolean" "Real" "Date" "Speed" "DateTime" "Stack" "Integer" "String" "Length" "Table" "List" "Time" "Method" "Weight" "acceleration" "money" "any" "object" "array" "queue" "boolean" "real" "date" "speed" "datetime" "stack" "integer" "string" "length" "table" "list" "time" "method" "weight"))
	     (x-constants '("void" "true" "false" "waitExpired" "RootFolder"))

	     ;; generate regex string for each category of keywords
	     (x-keywords-regexp (regexp-opt x-keywords 'words))
	     (x-types-regexp (regexp-opt x-types 'words))
	     (x-constants-regexp (regexp-opt x-constants 'words)))
	     ;; (x-events-regexp (regexp-opt x-events 'words))
	     ;; (x-functions-regexp (regexp-opt x-functions 'words)))a

	`(
	  (,x-types-regexp . font-lock-type-face)
	  (,x-constants-regexp . font-lock-constant-face)
	  ;; (,x-events-regexp . font-lock-builtin-face)
	  ;; (,x-functions-regexp . font-lock-function-name-face)
	  (,x-keywords-regexp . font-lock-keyword-face)
	  ;; note: order above matters, because once colored, that part won't change.
	  ;; in general, put longer words first
	  )))

;; --------------------------------------------------
;; COMMENT SYNTAX
(defvar mystm-mode-syntax-table nil "Syntaxt table for `mystm-mode'.")
(setq mystm-mode-syntax-table
      (let ((synTable (make-syntax-table)))
	;; simtalk style comment: "-- ..."
	(modify-syntax-entry ?\- ". 12b" synTable)
	(modify-syntax-entry ?\n "> b" synTable)
	synTable))
;; --------------------------------------------------

;; --------------------------------------------------
;; AUTOLOAD
(define-derived-mode mystm-mode text-mode "simtalk mode"
  "Major mode for editing Simtalk"
  ;; code for syntax highlighting
  (setq font-lock-defaults '((mystm-font-lock-keywords))) ;add syntaxt highlighting
  (set-syntax-table mystm-mode-syntax-table) ;add commentting behavior
  (setq-local comment-start "--")
  (setq-local comment-end "")
  )

;; ;; add the mode to the `features' list
(provide 'mystm-mode)
;; --------------------------------------------------
