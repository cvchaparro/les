(in-package #:cl-user)
(defpackage :les.db
  (:use #:cl
        #:cl-json
        #:drakma)
  (:import-from #:les.config
                #:config)
  (:import-from #:datafly
                #:*connection*
                #:connect-cached)
  (:export #:connection-settings
           #:db
           #:with-connection))
(in-package :les.db)

(defun connection-settings (&optional (db :maindb))
  (rest (assoc db (config :database))))

(defun db (&optional (db :maindb))
  (apply #'connect-cached (connection-settings db)))

(defmacro with-connection (conn &body body)
  `(let ((*connection* ,conn))
     ,@body))
