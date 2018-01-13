(defpackage #:les-test
  (:use #:cl
        #:prove
        #:les))

(in-package #:les-test)

(plan 4)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; backend

(ok (play) "can call PLAY function")
(ok (record) "can call RECORD function")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; web

(is (make-web-page (:title "hello") "hello, world")
    (concatenate 'string
                 "<html>"
                 "<head>"
                 "<title>hello</title>"
                 "</head>"
                 "<body>hello, world</body>"
                 "</html>")
    "can generate a basic HTML page")
(is (make-web-page (:title "hello")
                   (:h1 "hello!")
                   (:p "well, hi there!"))
    (concatenate 'string
                 "<html>"
                 "<head>"
                 "<title>hello</title>"
                 "</head>"
                 "<body>"
                 "<h1>hello!</h1>"
                 "<p>well, hi there!</p>"
                 "</body>"
                 "</html>")
    "can generate a basic with h1 and p tags in the body page")

(finalize)
