(ql:quickload :les)

(defpackage #:les.app
  (:use #:cl)
  (:import-from #:lack.builder
                #:builder)
  (:import-from #:ppcre
                #:scan
                #:regex-replace)
  (:import-from #:les.web
                #:*web*)
  (:import-from #:les.config
                #:config
                #:productionp
                #:*static-directory*))
(in-package :les.app)

(builder
 (:static
  :path (lambda (path)
          (if (ppcre:scan "^(?:/images/|/css/|/js/|/robot\\.txt$|/favicon\\.ico$)" path)
              path
              nil))
  :root *static-directory*)
 (if (productionp)
     nil
     :accesslog)
 (if (getf (config) :error-log)
     '(:backtrace
       :output (getf (config) :error-log))
     nil)
 :session
 (if (productionp)
     nil
     (lambda (app)
       (lambda (env)
         (let ((datafly:*trace-sql*))
           (funcall app env)))))
 *web*)
