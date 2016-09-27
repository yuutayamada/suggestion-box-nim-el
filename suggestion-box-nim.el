;;; suggestion-box-nim.el --- suggestion-box for Nim -*- lexical-binding: t; -*-

;; Copyright (C) 2016  Yuta Yamada

;; Author: Yuta Yamada <cokesboy"at"gmail.com>
;; Keywords: convenience
;; Version: 0.0.1
;; Package-Requires: ((emacs "25.1") (suggestion-box "20160924.1043"))
;; 20160918.1158
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This package supports showing type information after you expanded
;; company-mode's completion in nim-mode.  (and if the completion was
;; function or template, which "()" will be inserted, but this
;; specification might change when nimsuggest gets smarter)

;; Usage:
;;
;; Add below code to your Emacs configuration file (e.g, ~/.emacs.d/init.el)
;;
;;   (add-to-list 'nim-capf-after-exit-function-hook 'suggestion-box-nim-by-type)
;;
;;; Code:

(require 'suggestion-box)
(require 'subr-x)

(cl-defmethod suggestion-box-normalize ((_backend (eql nim)) raw-str)
  "Return normalized string."
  (suggestion-box-h-filter
   :content    (suggestion-box-h-trim raw-str "(" ")")
   :split-func (lambda (content) (split-string content ", "))
   :nth-arg    (suggestion-box-h-compute-nth "," 'paren)
   :sep "" :mask1 "" :mask2 ""))

;;;###autoload
(defun suggestion-box-nim-by-type (str)
  "Make suggestion-box for STR."
  (when-let ((type (and str (get-text-property 0 :nim-type str))))
    (suggestion-box-put type :backend 'nim)
    (suggestion-box type)))

(provide 'suggestion-box-nim)
;;; suggestion-box-nim.el ends here
