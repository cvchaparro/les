(in-package #:cl-user)
(defpackage #:les.web
  (:use #:cl
        #:caveman2
        #:les.config
        #:les.view
        #:les.db
        #:datafly
        #:sxql
        #:split-sequence
        #:md5)
  (:export #:*web*))
(in-package #:les.web)

(syntax:use-syntax :annot)

;; Application
(defclass <web> (<app>) ())
(defvar *web* (make-instance '<web>))
(clear-routing-rules *web*)

;; Routes
(defroute "/" ()
  (render #p"index.html"))

;; Errors
(defmethod on-exception ((app <web>) (code (eql 404)))
  (declare (ignore app))
  (merge-pathnames #p"_errors/404.html"
                   *template-directory*))
