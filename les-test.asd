(defsystem #:les-test
  :description "Test the les application"
  :depends-on (#:les
               #:prove)
  :components ((:module "t"
                :serial t
                :components
                ((:file "les-test")))))
