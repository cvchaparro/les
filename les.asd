(defsystem #:les
  :version (:read-file-form "version" :at 0)
  :description "Help English teachers test their student's speaking skills."
  :author "Cameron V Chaparro <cvchaparro.dev@gmail.com>"
  :license "GPLv3+"
  :components ((:module "src"
                :components
                ((:file "les"))))
  :long-description #.(read-file-string
                       (subpathname *load-pathname* "README.md"))
  :in-order-to ((test-op (test-op les-test))))
