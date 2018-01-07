(defsystem #:les
  :version "0.0.1"
  :description "Help English teachers test their student's speaking skills."
  :author "Cameron V Chaparro <cvchaparro.dev@gmail.com>"
  :license "GPLv3+"
  :components ((:module "src"
                :components
                ((:file "les"))))
  :long-description #.(uiop:read-file-string
                       (uiop:subpathname *load-pathname* "README.md")))
