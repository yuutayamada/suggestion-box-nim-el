# suggestion-box-nim.el

This package supports showing type information after you expanded
company-mode's completion in nim-mode.  (and if the completion was
function or template, which "()" will be inserted, but this
specification might change when nimsuggest become more smarter)

![suggestion-box](https://cloud.githubusercontent.com/assets/1082473/18810060/49ceac58-8241-11e6-9d4a-bc22d0844fec.gif)

## Usage:

Add below code to your Emacs configuration file (e.g, ~/.emacs.d/init.el)

``` lisp
(add-to-list 'nim-capf-after-exit-function-hook 'suggestion-box-nim-by-type)

```

