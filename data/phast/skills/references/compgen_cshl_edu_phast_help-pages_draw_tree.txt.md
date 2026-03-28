PROGRAM: draw\_tree
DESCRIPTION: Produces a simple postscript rendering of a tree.
USAGE: draw\_tree [-dbvs] |
OPTIONS:
 (Required) File name of tree (expected to be in
Newick format, unless filename ends with '.mod', in
which case expected to be a tree model file).
-d Print "diagonal" branches, instead of "right-angle" or
"square" ones (produces a "cladogram", as opposed to a
"phenogram"). This option implies -s.
-b Suppress branch lengths.
-v Vertical layout.
-s Don't draw branches to scale.