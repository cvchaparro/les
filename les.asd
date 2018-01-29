(defsystem #:les
  :version (:read-file-form "version" :at 0)
  :description "Help English teachers test their student's speaking skills."
  :author "Cameron V Chaparro <cvchaparro.dev@gmail.com>"
  :license "GPLv3+"
  :depends-on (#:clack
               #:lack
               #:caveman2
               #:envy
               #:cl-ppcre
               #:cl-syntax-annot
               #:djula
               #:datafly
               #:sxql
               #:drakma
               #:cl-json
               #:split-sequence
               #:vecto
               #:md5
               #:cl-who)
  :components ((:module "src"
                :components
                ((:file "main" :depends-on ("config" "view" "db"))
                 (:file "web" :depends-on ("view"))
                 (:file "view" :depends-on ("config"))
                 (:file "db" :depends-on ("config"))
                 (:file "config"))))
  :long-description #.(read-file-string
                       (subpathname *load-pathname* "README.md"))
  :in-order-to ((test-op (test-op les-test))))
