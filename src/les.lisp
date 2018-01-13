(defpackage #:les
  (:use #:cl
        #:cl-who)
  (:export
   #:play
   #:record
   #:make-web-page))

(in-package #:les)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; backend

(defun play ()
  t)

(defun record ()
  t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; web

(setf (html-mode) :html5)

(defmacro make-web-page ((&key title) &body body)
  `(with-html-output-to-string (s)
     (:html
      (:head
       (:title ,title))
      (:body
       ,@body))))
