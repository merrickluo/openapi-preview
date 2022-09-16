;;; openapi-preview.el --- Preview openapi files in browser. -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2022 A.I.
;;
;; Author: A.I. <merrick@luois.me>
;; Maintainer: A.I. <merrick@luois.me>
;; Created: 九月 16, 2022
;; Modified: 九月 16, 2022
;; Version: 0.0.1
;; Keywords: convenience docs tools
;; Homepage: https://github.com/merrickluo/openapi-preview
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;; Uses `redoc-cli' to generate html for preview.
;;
;;; Code:

(defcustom openapi-preview-redoc-command (executable-find "redoc-cli")
  "Path to the redoc-cli tool, default to `(executable-find \"redoc-cli\")'."
  :type 'string
  :group 'openapi-preview)

;;;###autoload
(defun openapi-preview()
  "Preview openapi definition in default browser."
  (interactive)
  (let* ((buffer "*openapi-preview*")
         (tmpfile (make-temp-file "openapi-preview" nil ".html")))
    (if (get-buffer buffer)
        (kill-buffer buffer))
    (let ((ret (call-process openapi-preview-redoc-command nil buffer t "build" (buffer-file-name) "-o" tmpfile)))
      (if (eq ret 0)
          (browse-url (format "file://%s" tmpfile))
        (delete-file tmpfile)
        (pop-to-buffer buffer)))))

(provide 'openapi-preview)
;;; openapi-preview.el ends here
