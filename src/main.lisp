(defpackage #:les
  (:use #:cl
        #:cl-who)
  (:import-from #:les.config
                #:config)
  (:import-from #:clack
                #:clackup)
  (:export #:start
           #:stop
           #:play
           #:record
           #:make-web-page))

(in-package :les)

(defvar *appfile-path*
  (asdf:system-relative-pathname :les #p"app.lisp"))

(defvar *handler* nil)

(defun start (&rest args &key server port debug &allow-other-keys)
  (declare (ignore server port debug))
  (when *handler*
    (restart-case (error "Server is already running.")
      (restart-server ()
        :report "Restart the server"
        (stop))))
  (setf *handler*
        (apply #'clackup *appfile-path* args)))

(defun stop ()
  (prog1
      (clack:stop *handler*)
    (setf *handler* nil)))

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
