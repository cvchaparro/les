(defpackage #:les-test
  (:use #:cl
        #:prove
        #:les))

(in-package #:les-test)

(plan 1)
(ok (not (nothing)))
(finalize)
