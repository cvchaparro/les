(defpackage #:les-test
  (:use #:cl
        #:prove
        #:les))

(in-package #:les-test)

(plan 2)

(ok (play) "can call PLAY function")
(ok (record) "can call RECORD function")

(finalize)
