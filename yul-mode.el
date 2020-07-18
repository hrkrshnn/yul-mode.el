(defvar yul-mode-hook nil)

(setq default-tab-width 4)

(defvar yul-mode-map
  (let ((map (make-keymap)))
    (define-key map "\C-j" 'newline-and-indent)
    map)
  "Keymap for YUL major mode")

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.yul\\'" . yul-mode))

;; function, switch, case, default, if, for, break, continue, leave, let,
;; true, false, hex
(defconst yul-font-lock-keywords-1
  (list
   ;; break, case, continue, default, for, function, let, leave, switch
   '("\\<\\(break\\|c\\(?:\\(?:as\\|ontinu\\)e\\)\\|default\\|f\\(?:or\\|unction\\)\\|if\\|le\\(?:ave\\|t\\)\\|switch\\)\\>" . font-lock-builtin-face)
   ;; false, hex, true
   '("\\<\\(false\\|hex\\|true\\)\\>" . font-lock-constant-face))
  "Minimal highlighting expressions for YUL mode")


(defvar yul-font-lock-keywords yul-font-lock-keywords-1
  "Default highlighting expressions for YUL mode")

(defun yul-indent-line ()
  "Indent current line as YUL code"
  (interactive)
  (beginning-of-line)
  (if (bobp)
	  (indent-line-to 0)))

(defvar yul-mode-syntax-table
  (let ((yul-mode-syntax-table (make-syntax-table)))
	(modify-syntax-entry ?/ ". 124b" yul-mode-syntax-table)
	(modify-syntax-entry ?* ". 23" yul-mode-syntax-table)
	(modify-syntax-entry ?\n "> b" yul-mode-syntax-table)
	yul-mode-syntax-table))

(defun yul-mode ()
  (interactive)
  (kill-all-local-variables)
  (use-local-map yul-mode-map)
  (set-syntax-table yul-mode-syntax-table)
  ;; Set up font-lock
  (set (make-local-variable 'font-lock-defaults) '(yul-font-lock-keywords))
  ;; Register our indentation function
  (set (make-local-variable 'indent-line-function) 'yul-indent-line)
  (setq major-mode 'yul-mode)
  (setq mode-name "Yul")
  ;; TODO improve this
  (whitespace-mode)
  (run-hooks 'yul-mode-hook))

(provide 'yul-mode)

;;; yul-mode.el ends here
