;;; -*- lexical-binding: t; -*-

(defun mp-note ()
  "Post without title"
  (interactive)
  (when (yes-or-no-p (format "Are you sure you want to post to %s?" endpoint))
    (let ((data `(("h" . "entry")
                  ("content" . ,(buffer-substring-no-properties (point-min) (point-max)))))
          (syndication-targets (choose-syndication-targets)))
      (unless (null syndication-targets)
        (map-put data "mp-syndicate-to" (mapconcat 'identity syndication-targets " ")))
      (request endpoint
               :type "POST"
               :parser 'json-read
               :data data
               :headers `(("Authorization" . ,(format "Bearer %s" token)))
               :error (cl-function
                       (lambda (&key response &allow-other-keys)
                         (message "Error: %s" response)))
               :success (cl-function
                         (lambda (&key response &allow-other-keys)
                           (message "Post created: %s" (request-response-header response "Location"))))))))

(defun mp-article()
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


;; Syndication targets

;; TODO: Would like to do this without the request being synchronous,
;; but I'm not sure how to access buffer-file-name in the success callback.
(defun refresh-syndication-targets ()
  "Query micropub endpoint for syndication targets and save to config"
  (interactive)
  (let*
      ((thisrequest
        (request endpoint
                 :params '(("q" . "syndicate-to"))
                 :headers `(("Authorization" . ,(format "Bearer %s" token)))
                 :sync t
                 :parser 'json-read))
       (data (request-response-data thisrequest)))
    (write-region (format "%S" data) nil targets-config-file)))

;; TODO: has to be a better way of parsing this.
(defun load-syndication-targets ()
  (setq targets-config-string (get-string-from-file targets-config-file))
  (setq targets-config (car (read-from-string (format "(%s)" targets-config-string))))
  (setq targets (append (cdr (car (car targets-config))) nil))
  (mapcar #'(lambda (a) (cdr (car a))) targets))

(defun choose-syndication-targets ()
  "Prompt user to pick a syndication targets from a list."
  (interactive)
  (let ((targets (load-syndication-targets)))
    (completing-read-multiple "Syndicate to (separate targets with commas): " targets)))


;; Helpers

(defun get-string-from-file (filePath)
  "Return filePath's file content."
  (with-temp-buffer
    (insert-file-contents filePath)
    (buffer-string)))
