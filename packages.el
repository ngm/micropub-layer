(defconst micropub-packages '(request ido))
(defun micropub/post-init-ido())
(defun micropub/post-init-request()
 (use-package request :config 
  (progn
    (use-package ido :config 
     (progn
      (load "~/.emacs.d/private/micropub/micropub.el"))))))

