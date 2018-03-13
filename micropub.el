(defun mp-update ()
  "Post without title"
  (interactive)
  (if (yes-or-no-p "Are you sure you want to post this?" )
      (request
       endpoint
       :type "POST"
       :data `(("h"."entry")("content" . ,(buffer-substring-no-properties (point-min) (point-max))))
       :headers `(("Authorization" . ,(format "Bearer %s" token)))
       :success (cl-function (lambda (&key data &allow-other-keys) (message "Success"))))))
(defun mp-post()
  "Post with title"
  (interactive)
  (if (yes-or-no-p "Are you sure you want to post this?" )
      (request
       endpoint
       :type "POST"
       :data `(("h"."entry")("name" . ,(read-string "Title: "))("content" . ,(buffer-substring-no-properties (point-min) (point-max))))
       :headers `(("Authorization" . ,(format "Bearer %s" token)))
       :success (cl-function (lambda (&key data &allow-other-keys) (message "Success"))))))
(defun mp-like()
  "Post a link as like-of"
  (interactive)
  (if (yes-or-no-p "Are you sure you want to post this?" )
      (request
       endpoint
       :type "POST"
       :data `(("h"."entry")("like-of" . ,(read-string "Link: ")))
       :headers `(("Authorization" . ,(format "Bearer %s" token)))
       :success (cl-function (lambda (&key data &allow-other-keys) (message "Success"))))))
(defun mp-facepalm()
  "Post link as facepalm-of"
  (interactive)
  (if (yes-or-no-p "Are you sure you want to post this?" )
      (request
       endpoint
       :type "POST"
       :data `(("h"."entry")("facepalm-of" . ,(read-string "Link: ")))
       :headers `(("Authorization" . ,(format "Bearer %s" token)))
       :success (cl-function (lambda (&key data &allow-other-keys) (message "Success"))))))
(defun mp-reply ()
  "Post reply"
  (interactive)
  (if (yes-or-no-p "Are you sure you want to post this?" )
      (request
       endpoint
       :type "POST"
       :data `(("h"."entry")("in-reply-to" . (read-string "Link: "))("content" . ,(buffer-substring-no-properties (point-min) (point-max))))
       :headers `(("Authorization" . ,(format "Bearer %s" token)))
       :success (cl-function (lambda (&key data &allow-other-keys) (message "Success"))))))
