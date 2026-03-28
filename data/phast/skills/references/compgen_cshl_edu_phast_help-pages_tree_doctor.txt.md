PROGRAM: tree\_doctor
DESCRIPTION: Scale, prune, merge, and otherwise tweak phylogenetic trees.
Expects input to be a tree model (.mod) file unless
filename ends with '.nh' or -n option is used, in which case
it will be expected to be a tree file in Newick format.
USAGE: /home/mt269/phast/bin/tree\_doctor [OPTIONS] |
OPTIONS:
--prune, -p

Remove all leaves whose names are included in the given list
(comma-separated), then remove nodes and combine branches
to restore as a complete binary tree (i.e., with each
node having zero children or two children). This option is
applied \*before\* all other options.
--prune-all-but, -P

Like --prune, but remove all leaves \*except\* the ones specified.
--get-subtree, -g
Like --prune, but remove all leaves who are not descendants of
node. (Note: implies --name-ancestors if given node not
explicitly named in input tree)
--rename, -r
Rename leaves according to the given mapping. The format of
 must be: "oldname1 -> newname1 ; oldname2 ->
newname2 ; ...". This option is applied \*after\* all other
options (i.e., old names will be used for --prune, --merge,
etc.)
--scale, -s
Scale all branches by the specified factor.
--name-ancestors, -a
Ensure names are assigned to all ancestral nodes. If a node
is unnamed, create a name by concatenating the names of a leaf
from its left subtree and a leaf from its right subtree.
--label-subtree, -L
Add a label to the subtree of the named node. If the node name
is followed by a "+" sign, then the branch leading to that node
is included in the subtree. This may be used multiple times to add
more than one label, though a single branch may have only one
label. --label-subtree and --label-branches options are parsed in
the order given, so that later uses may override earlier ones.
Labels are applied \*after\* all pruning, re-rooting, and re-naming
options are applied.
--label-branches, -l
Add a label to the branches listed. Branches are named by the name
of the node which descends from that branch. See --label-subtree
above for more information.
--tree-only, -t
Output tree only in Newick format rather than complete tree model.
--no-branchlen, -N
(Implies --tree-only). Output only topology in Newick format.
--dissect, -d
In place of ordinary output, print a description of the id,
name, parent, children, and distance to parent for each node
of the tree. Sometimes useful for debugging. Can be used with
other options.
--branchlen, -b
In place of ordinary output, print the total branch length of
the tree that would have been printed.
--depth, -D
In place of ordinary output, report distance from named node to
root
--reroot, -R
Reroot tree at internal node with specified name.
--subtree, -S
(for use with --scale) Alter only the branches in the subtree
beneath the specified node.
--with-branch, -B
(For use with --reroot or --subtree) include branch above specified
node with subtree beneath it.
--merge, -m  |
Merge with another tree model or tree. The primary model
() must have a subset of the species (leaves) in the
secondary model (), and the primary tree must be a
proper subtree of the secondary tree (i.e., the subtree of the
secondary tree beneath the LCA of the species in the primary
tree must equal the primary tree in terms of topology and
species names). If a full tree model is given for the
secondary tree, only the tree will be considered. The merged
tree model will have the rate matrix, equilibrium frequencies,
and rate distribution of the primary model, but a merged tree
that includes all species from both models. The trees will be
merged by first scaling the secondary tree such that the
subtree corresponding to the primary tree has equal overall
length to the primary tree, then combining the primary tree
with the non-overlapping portion of the secondary tree. The
names of matching species (leaves) must be exactly equal.
--extrapolate, -e  | default
Extrapolate to a larger set of species based on the given
phylogeny (Newick-format). The primary tree must be a subtree
of the phylogeny given in , but it need not be
a "proper" subtree (see --merge). A copy will be created
of the larger phylogeny then scaled such that the total branch
length of the subtree corresponding to the primary tree equals
the total branch length of the primary tree; this new version
will then be used in place of the primary tree. If the string
"default" is given instead of a filename, then a phylogeny
for 25 vertebrate species, estimated from sequence data for
Target 1 (CFTR) of the NISC Comparative Sequencing Program
(Thomas et al., Nature 424:788-793, 2003), will be assumed.
This option is similar to merge but differs in that the branch
length proportions of the output tree come completely from the
larger tree and the smaller tree doesn't have to be a proper
subset of the larger tree.
--newick,-n
The input file is in Newick format (necessary if file name does
not end in .nh)
--help, -h
Print this help message.