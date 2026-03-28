PROGRAM: all\_dists
DESCRIPTION: Given a tree in Newick (\*.nh) format, report distances
between all pairs of leaves. If multiple files are given,
then distances are computed by averaging across models,
and statistics describing the errors in the estimates
are reported (can be useful for bootstrapping; see
'phyloBoot --dump-mods').
USAGE: /home/mt269/phast/bin/all\_dists  [ ...]
OPTIONS:
--mod, -m
Read from tree model (\*.mod) file(s) instead of Newick file.
--tree, -t |
Use leaf names from given tree. Useful when primary files
use numbers rather than names.
--help, -h
Print this help message.