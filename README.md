# README

A small [micropub](https://indieweb.org/micropub) layer to turn spacemacs into a micropub client.

## Installation

```
$ git clone https://github.com/ngm/micropub-layer.git ~/.emacs.d/private/micropub
```

And add 

```
(micropub variables
          :token "your auth token" 
          :endpoint "url to your micropub endpoint"
          :targets-config-file "~/.emacs.d/private/micropub/targets-config-file"))
```

to your layer list.

This layer does not currently implement the process for getting a token to your endpoint, so please use [Gimme a Token](https://gimme-a-token.5eb.nl/) for now :)

## Methods 

### Setup

To discover the [syndication targets](https://indieweb.org/syndication_targets) available for your micropub endpoint, run:

```
M-x mp-refresh-syndication-targets
```

### Posting

The following posting methods are available through M-x:

- *mp-note*: posts the current buffer as a titleless [note](https://indieweb.org/note)
- *mp-article*: posts the current buffer as an [article](https://indieweb.org/article), and asks you for a title
- *mp-bookmark*: asks for a link and posts it as a [bookmark](https://indieweb.org/bookmark) post
- *mp-like*: asks for a link and posts it as a [like](https://indieweb.org/like) of that post
- *mp-reply*: asks for a link and posts the current buffer as a [reply](https://indieweb.org/reply) to that post
