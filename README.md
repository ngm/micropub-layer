# README
A small micropub layer for spacemacs. 

## Installation

git clone https://github.com/hjertnes/micropub-layer.git ~/.emacs.d/private/micropub
And add (micropub variables: token "YOUR AUTH TOKEN" endpoint "url to your micropub endpoint") to your layer list


## Methods: 
All methods are available through M-x

mp-update: posts the current buffer as a titleless post
mp-post: posts the current buffer, and asks you for a title
mp-like: asks for a link and posts it as a "like-of" post
mp-facepalm: asks for a link and posts it as "facepalm-of" post(a non standard context I added to my end point)
mp-reply: posts the current buffer and asks for a link and posts it as a "in-reply-to" post
