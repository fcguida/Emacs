
## Emacs
Some emacs lisp files, functions and settings:

----------
### mouse.el
Some handy single mouse click fxns to delete the sexp at point and snarf a
new one and insert it. The real power is working in split windows - works
from other windows, but not from other frames just yet. Example bindings are
at the end of the file.

#### mouse-copy-sexp
Copy the sexp at the mouse cursor and insert it at point.
If the mouse event occured in another screen, copy the sexp from there.
If mouse cursor is at the end of a line, copy the entire line.

#### mouse-delete-sexp
Delete the sexp at the mouse cursor (the deleted text is not
placed in the kill-ring).  If the mouse cursor is at the end of a line,
kill the current line instead.

#### mouse-swap-sexps
Swap the sexp at point with the one at the mouse click.

#### mouse-delete-word
Delete the word at the mouse cursor (the deleted text is not
placed in the kill-ring).  If the mouse cursor is at the end of a line,
kill the current line instead.

#### mouse-swap-lines
Swap the line point in on with the one the mouse cursor is on.
