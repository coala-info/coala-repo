# gotree CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| gotree_acr | PASS |  |
| gotree_annotate | PASS |  |
| gotree_asr | PASS |  |
| gotree_brlen_add | PASS |  |
| gotree_brlen_clear | PASS |  |
| gotree_brlen_cut | PASS |  |
| gotree_brlen_round | PASS |  |
| gotree_brlen_scale | PASS |  |
| gotree_brlen_set | PASS |  |
| gotree_brlen_setmin | PASS |  |
| gotree_brlen_setrand | PASS |  |
| gotree_collapse_clade | PASS |  |
| gotree_collapse_depth | PASS |  |
| gotree_collapse_length | PASS |  |
| gotree_collapse_name | PASS |  |
| gotree_collapse_single | PASS | synthetic data: a tiny tree with a single-child node was written by hand. |
| gotree_collapse_support | PASS |  |
| gotree_comment_clear | PASS |  |
| gotree_comment_transfer | PASS |  |
| gotree_compare_edges | PASS | synthetic data: compared trees are NNI neighbours made by gotree nni from a real tree. |
| gotree_compare_tips | PASS |  |
| gotree_compare_trees | PASS | synthetic data: compared trees are NNI neighbours made by gotree nni from a real tree. |
| gotree_compute_bipartitiontree | PASS |  |
| gotree_compute_consensus | PASS | synthetic data: input trees are NNI neighbours made by gotree nni from a real tree. |
| gotree_compute_edgetrees | PASS |  |
| gotree_compute_mutations | PASS | ancestral sequences come from gotree asr on a real alignment and tree. |
| gotree_compute_roccurve | Failed | tool bug: every branch is counted as a false positive even when the true tree is identical to the input tree. |
| gotree_compute_support_fbp | PASS | synthetic data: bootstrap trees are NNI neighbours made by gotree nni from a real tree. |
| gotree_compute_support_tbe | PASS | synthetic data: bootstrap trees are NNI neighbours made by gotree nni from a real tree. |
| gotree_cut_date | PASS |  |
| gotree_divide | PASS |  |
| gotree_download_itol | Not completed | needs an iTOL account tree id from an external server. |
| gotree_download_ncbitax | Not completed | downloads the full NCBI taxonomy from an external server; too heavy to test, and HTTPS fails in this image. |
| gotree_download_panther | Failed | image problem: the image has no CA certificates, so the HTTPS download fails with an unknown authority error. |
| gotree_draw_cyjs | PASS |  |
| gotree_draw_png | PASS |  |
| gotree_draw_svg | PASS |  |
| gotree_draw_text | PASS |  |
| gotree_generate_balancedtree | PASS |  |
| gotree_generate_caterpillartree | PASS |  |
| gotree_generate_startree | PASS |  |
| gotree_generate_topologies | PASS |  |
| gotree_generate_uniformtree | PASS |  |
| gotree_generate_yuletree | PASS |  |
| gotree_graft | PASS |  |
| gotree_labels | PASS |  |
| gotree_ltt | PASS |  |
| gotree_matrix | PASS |  |
| gotree_merge | PASS |  |
| gotree_nni | PASS |  |
| gotree_prune | PASS |  |
| gotree_reformat_newick | PASS |  |
| gotree_reformat_nexus | PASS |  |
| gotree_reformat_phyloxml | PASS |  |
| gotree_rename | PASS |  |
| gotree_repopulate | PASS |  |
| gotree_reroot_midpoint | PASS |  |
| gotree_reroot_outgroup | PASS |  |
| gotree_resolve | PASS |  |
| gotree_resolve_named | PASS |  |
| gotree_rotate_rand | PASS |  |
| gotree_rotate_sort | PASS |  |
| gotree_rtt | PASS |  |
| gotree_sample | PASS |  |
| gotree_shuffletips | PASS |  |
| gotree_stats | PASS |  |
| gotree_stats_edges | PASS |  |
| gotree_stats_monophyletic | PASS |  |
| gotree_stats_nodes | PASS |  |
| gotree_stats_rooted | PASS |  |
| gotree_stats_splits | PASS |  |
| gotree_stats_tips | PASS |  |
| gotree_subtree | PASS |  |
| gotree_support_clear | PASS |  |
| gotree_support_round | PASS |  |
| gotree_support_scale | PASS |  |
| gotree_support_setrand | PASS |  |
| gotree_unroot | PASS |  |
| gotree_upload_itol | Not completed | uploads a tree to the external iTOL server; skipped. |

## gotree_acr

### Tool Description
Reconstructs most parsimonious ancestral characters.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Reconstructs most parsimonious ancestral characters.

Depending on the chosen algorithm, it will run:
1) UP-PASS and
2) Either
   a) DOWN-PASS or
   b) DOWN-PASS+DELTRAN or
   c) ACCTRAN
   d) NONE

Should work on multifurcated trees.

If --random-resolve is given then, during the last pass, each time 
a node with several possible states still exists, one state is chosen 
randomly before going deeper in the tree.

Version: 

Usage:
  gotree acr [flags]

Flags:
      --algo string         Parsimony algorithm for resolving ambiguities: acctran, deltran, or downpass (default "acctran")
  -h, --help                help for acr
  -i, --input string        Input tree (default "stdin")
      --out-states string   Output mapping file between node names and states (default "none")
      --out-steps string    Output file with number of parsimony steps (default "stdout")
  -o, --output string       Output file (default "stdout")
      --random-resolve      Random resolve states when several possibilities in: acctran, deltran, or downpass
      --states string       Tip state file (One line per tip, tab separated: tipname\tstate) (default "stdin")

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_annotate

### Tool Description
Annotates internal branches of a tree with given data.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Annotates internal branches of a tree with given data.

Annotations may be (in order of priority):
- A tree with labels on internal nodes (-c). in that case, it will label each branch of 
   the input tree with label of the closest branch of the given compared tree (-c) in terms
   of transfer distance. The labels are of the form: "label_distance_depth"; Only internal branches
   are annotated, and no internal branch is annotated with a terminal branch.
- A file with one line per internal node to annotate (-m), and with the following format:
   <name of internal branch/node n1>:<name of taxon n2>,<name of taxon n3>,...,<name of taxon ni>
	=> If 0 name is given after ':' an error is returned
	=> If 1 name 'n2' is given after ':' : we search for n2 in the tree (tip or internal node)
       and rename it as n1
    => If > 1 names '[n2,...,ni]' are given after ':' : We find the LCA of every tips whose name 
	   is in '[n2,...,ni]' and rename it as n1.
	=> If --subtrees is given: for each annotation line, not only the given internal node is annotated, but all its descending internal nodes as well (usefull for some branch tests, e.g. hyphy, etc.)

If --comment is specified, then we do not change the names, but the comments of the given nodes.
Otherwise output tree won't have bootstrap support at the branches anymore

If neither -c nor -m are given, gotree annotate will wait for a reference tree on stdin

Version: 

Usage:
  gotree annotate [flags]

Flags:
      --comment           Annotations are stored in Newick comment fields
  -c, --compared string   Compared tree file (default "stdin")
  -h, --help              help for annotate
  -i, --input string      Input tree(s) file (default "stdin")
  -m, --map-file string   Name map input file (default "none")
  -o, --output string     Resolved tree(s) output file (default "stdout")
      --subtrees          Annotate the internal node and all descending intern nodes with the given annotations

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_asr

### Tool Description
Reconstructs most parsimonious ancestral sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Reconstructs most parsimonious ancestral sequences.

Depending on the chosen algorithm, it will run:
1) UP-PASS and
2) Either
   a) DOWN-PASS or
   b) DOWN-PASS+DELTRAN or
   c) ACCTRAN
   d) NONE

Should work on multifurcated trees

If --random-resolve is given then, during the last pass, each time 
a node with several possible states still exists, one state is chosen 
randomly before going deeper in the tree.

Version: 

Usage:
  gotree asr [flags]

Flags:
      --algo string      Parsimony algorithm for resolving ambiguities: acctran, deltran, or downpass (default "acctran")
  -a, --align string     Alignment input file (default "stdin")
  -h, --help             help for asr
  -i, --input string     Input tree (default "stdin")
      --input-strict     Strict phylip input format (only used with -p)
      --log string       Output log file (default "stdout")
  -o, --output string    Output file (default "stdout")
  -p, --phylip           Alignment is in phylip? default : false (Fasta)
      --random-resolve   Random resolve states when several possibilities in: acctran, deltran, or downpass

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_brlen_add

### Tool Description
Add the given length to all branches of the tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Add the given length to all branches of the tree.

Example:

gotree brlen add -i tree.nwk -l <length>

Version: 

Usage:
  gotree brlen add [flags]

Flags:
  -l, --add-length float   Length to add to all branches
  -h, --help               help for add
  -o, --output string      Output tree file (default "stdout")

Global Flags:
      --external        Applies to external branches (default true)
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input tree (default "stdin")
      --internal        Applies to internal branches (default true)
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_brlen_clear

### Tool Description
Clear lengths from input trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Clear lengths from input trees.
	
	if --internal=false is given, it won't apply to internal branches (only external)
	if --external=false is given, it won't apply to external branches (only internal)

Version: 

Usage:
  gotree brlen clear [flags]

Flags:
  -h, --help            help for clear
  -o, --output string   Cleared tree output file (default "stdout")

Global Flags:
      --external        Applies to external branches (default true)
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input tree (default "stdin")
      --internal        Applies to internal branches (default true)
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_brlen_cut

### Tool Description
Cut branches whose length is greater than or equal to the given length.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Cut branches whose length is greater than or equal to the given length.

As output, it prints groups of tips that are in connected components of the now disconnected tree.

Output format: One line per group/connected component. Each line contains id \t ntips \t t1,t2,t3, 
with id="id of the input tree", ntips="Number of tips in that group" and t1,t2,t3="a coma separated list of tips in the group".

Example:

gotree brlen cut -i tree.nhx -l 0.1 -o groups.txt

Version: 

Usage:
  gotree brlen cut [flags]

Flags:
  -h, --help               help for cut
  -l, --max-length float   Length cutoff. Branches with length greater than or equal to this cutoff are considered removed (default 0.5)
  -o, --output string      Output file with groups of tips/connected components (default "stdout")

Global Flags:
      --external        Applies to external branches (default true)
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input tree (default "stdin")
      --internal        Applies to internal branches (default true)
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_brlen_round

### Tool Description
Rounds branch lengths of input trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Rounds branch lengths of input trees.

The precision is given by -p|--precision option, and is expressed in 1/10^precision

if -p 5 is given, precision of 10⁻5 is considered.


Does not do anything if precision is <=0;
Takes precision=15 if precision>15.

if --internal=false is given, it won't apply to internal branches (only external)
if --external=false is given, it won't apply to external branches (only internal)

Version: 

Usage:
  gotree brlen round [flags]

Flags:
  -h, --help            help for round
  -o, --output string   Rounded length output tree file (default "stdout")
  -p, --precision int   Rounding length precision (x means 10^-x) (default 3)

Global Flags:
      --external        Applies to external branches (default true)
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input tree (default "stdin")
      --internal        Applies to internal branches (default true)
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_brlen_scale

### Tool Description
Scale lengths from input trees by a given factor.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Scale lengths from input trees by a given factor.
	
	if --internal=false is given, it won't apply to internal branches (only external)
	if --external=false is given, it won't apply to external branches (only internal)

Version: 

Usage:
  gotree brlen scale [flags]

Flags:
  -f, --factor float    Branch length scaling factor (default 1)
  -h, --help            help for scale
  -o, --output string   Scaled length output tree file (default "stdout")

Global Flags:
      --external        Applies to external branches (default true)
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input tree (default "stdin")
      --internal        Applies to internal branches (default true)
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_brlen_set

### Tool Description
Set the given branch length to all branches

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Set the given branch length to all branches

Example of usage:

gotree brlen set -i tree.nw -o out.nw -l 0.001
if --internal=false is given, it won't apply to internal branches (only external)
if --external=false is given, it won't apply to external branches (only internal)

Version: 

Usage:
  gotree brlen set [flags]

Flags:
  -h, --help            help for set
  -l, --length float    Desired branch length
  -o, --output string   Min length output tree file (default "stdout")

Global Flags:
      --external        Applies to external branches (default true)
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input tree (default "stdin")
      --internal        Applies to internal branches (default true)
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_brlen_setmin

### Tool Description
Set a min branch length to all branches with length < cutoff

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Set a min branch length to all branches with length < cutoff

Example of usage:

gotree brlen setmin -i tree.nw -o out.nw -l 0.001

if --internal=false is given, it won't apply to internal branches (only external)
if --external=false is given, it won't apply to external branches (only internal)

Version: 

Usage:
  gotree brlen setmin [flags]

Flags:
  -h, --help            help for setmin
  -l, --length float    Min Length cutoff
  -o, --output string   Min length output tree file (default "stdout")

Global Flags:
      --external        Applies to external branches (default true)
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input tree (default "stdin")
      --internal        Applies to internal branches (default true)
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_brlen_setrand

### Tool Description
Assign a random length to edges of input trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Assign a random length to edges of input trees.

Branch lengths are drawn in an exponential distribution of parameter lambda=1/mean.
Two possibilities for the mean:

1) If --mean-min and --mean-max are given, and mean-min < mean-max and are both > 0 then 
"mean" is drawn uniformly in the interval [mean-min,mean-max]

2) Otherwise, 'mean' is set to --mean value.

if --internal=false is given, it won't apply to internal branches (only external)
if --external=false is given, it won't apply to external branches (only internal)

if --min-len > 0, it will apply only to branches with length >= min-len
if --max-len > 0, it will apply only to branches with length <= max-len

Version: 

Usage:
  gotree brlen setrand [flags]

Flags:
  -h, --help             help for setrand
      --max-len float    Applies only to branches having length <= max-length (taken into account iff > 0) (default -1)
      --max-mean float   Mean of the exponential distribution of branch lengths will be drawn uniformly in the interval [min-mean,max-mean] (default 0.05)
  -m, --mean float       Mean of the exponential distribution of branch lengths (default 0.1)
      --min-len float    Applies only to branches having length >= min-length (taken into account iff > 0) (default -1)
      --min-mean float   Mean of the exponential distribution of branch lengths will be drawn uniformly in the interval [min-mean,max-mean] (default 0.001)
  -o, --output string    Random length output tree file (default "stdout")

Global Flags:
      --external        Applies to external branches (default true)
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input tree (default "stdin")
      --internal        Applies to internal branches (default true)
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_collapse_clade

### Tool Description
Collapse the clade defined by the given tip names, and replace it by a tip with a given name.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Collapse the clade defined by the given tip names, and replace it by a tip with a given name.

Example:

gotree collapse clade -i tree.nw -l tip.txt -n newtip
or
gotree collapse clade -i tree.nw -n newtip tip1 tip2 tip3

To write a file containing the collapsed clade only, use option -c / --clade-output

Version: 

Usage:
  gotree collapse clade [flags]

Flags:
  -c, --clade-output string   Output tree file with the collapsed clade (default "none")
  -h, --help                  help for clade
      --strict                Enforce the outgroup to be monophyletic (else throw an error)
  -l, --tip-file string       File containing names of tips of the outgroup (default "none")
  -n, --tip-name string       Name of the tip that will replace the clade (default "none")

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input tree (default "stdin")
  -o, --output string   Collapsed tree output file (default "stdout")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_collapse_depth

### Tool Description
Collapse branches having a given depth.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Collapse branches having a given depth.

Removes internal branches (not connected to the root in case of rooted trees) 
having depth (number of taxa on the lightest side of the bipartition) d such that:

min-depth<=d<=max-depth

will be collapsed.

If --root is given, then it applies also to internal branches connected to the root in the case 
of rooted trees. This may unroot the tree.

If --tips is given, then it applies also to external branches (if min-depth<=1), just by setting their length to 0.0

Version: 

Usage:
  gotree collapse depth [flags]

Flags:
  -h, --help            help for depth
  -M, --max-depth int   Max Depth cutoff to collapse branches
  -m, --min-depth int   Min depth cutoff to collapse branches
      --root            Applies also to branches connected to the root (may unroot the tree)
      --tips            Applies also to tips (keeps a 0.0 length tip)

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input tree (default "stdin")
  -o, --output string   Collapsed tree output file (default "stdout")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_collapse_length

### Tool Description
Collapse short branches of the input tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Collapse short branches of the input tree.

Short branches are defined by a threshold (-l). All internal branches 
with length <= threshold are removed.

If --root is given, then it applies also to internal branches connected to the root in the case 
of rooted trees. This may unroot the tree. In that case, so far the two branches connected to the root are 
considered independently whereas it may be more useful to consider them as a single bipartition if the 
tree is going to be unrooted.

If --tips is given, then it applies also to external branches, just by setting their length to 0.0

Version: 

Usage:
  gotree collapse length [flags]

Flags:
  -h, --help           help for length
  -l, --length float   Length cutoff to collapse branches
      --root           Applies also to branches connected to the root (may unroot the tree)
      --tips           Applies also to tips (keeps a 0.0 length tip)

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input tree (default "stdin")
  -o, --output string   Collapsed tree output file (default "stdout")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_collapse_name

### Tool Description
Collapse branches having given name or ID.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Collapse branches having given name or ID.

	Names (or ID) are defined in an input file (-b)

	If an external branch name/id is given, then does not do anything.

	Branch identifiers are defined by preorder traversal of the tree, sorted as described in the input newick file.
	If the tree or its newick representation is modified, identifiers will be different.

Version: 

Usage:
  gotree collapse name [flags]

Flags:
  -b, --brfile string   File with one branch name/id per line (default "none")
  -h, --help            help for name
      --id              Input file contains branch ids (otherwise, branch names)

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input tree (default "stdin")
  -o, --output string   Collapsed tree output file (default "stdout")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_collapse_single

### Tool Description
Collapse branches that connect single nodes.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Collapse branches that connect single nodes.

Single nodes are defined as nodes that:
- Connect only 2 neighbors
- Are not the root

* Branch lengths are added
* Max branch support is assigned to remaining branch

Ex:
           t1           t1
           /	       /
 n0--n1--n2   => n0--n2
           \	       \
            t2          t2

Version: 

Usage:
  gotree collapse single [flags]

Flags:
  -h, --help   help for single

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input tree (default "stdin")
  -o, --output string   Collapsed tree output file (default "stdout")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_collapse_support

### Tool Description
Collapse lowly supported branches of the input tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Collapse lowly supported branches of the input tree.

Lowly supported branches are defined by a threshold (-s). All internal branches 
with support < threshold and that are not connected to the root in case of rooted tree
 are removed.

 If --root is given, then it applies also to internal branches connected to the root in the case 
 of rooted trees. This may unroot the tree.

Version: 

Usage:
  gotree collapse support [flags]

Flags:
  -h, --help            help for support
      --root            Applies also to branches connected to the root (may unroot the tree)
  -s, --support float   Support cutoff to collapse branches

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input tree (default "stdin")
  -o, --output string   Collapsed tree output file (default "stdout")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_comment_clear

### Tool Description
Removes node/tip/edges comments from all nodes/tips/edges of the tree

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Removes node/tip/edges comments from all nodes/tips/edges of the tree

Example:
t.nw : (t1[c1],t2[c2],(t3[c3],t4[c4])[c5]);

gotree clear comments -i t.nw :
(t1,t2,(t3,t4));

If --edges-only is given: will only remove edge comments
If --nodes-only is given: will only remove nodes comments
If both or none are given, will remove every comments.

Version: 

Usage:
  gotree comment clear [flags]

Flags:
      --edges-only   Clear comments on edges only
  -h, --help         help for clear
      --nodes-only   Clear comments on nodes only
      --terminal     Clear comments on tips / terminal branches only

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input tree (default "stdin")
  -o, --output string   Cleared tree output file (default "stdout")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_comment_transfer

### Tool Description
Transfers node names to comments and removes node names

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Transfers node names to comments and removes node names

Version: 

Usage:
  gotree comment transfer [flags]

Flags:
  -h, --help      help for transfer
      --reverse   Reverses the orientation of the transfer (comment to name)

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input tree (default "stdin")
  -o, --output string   Cleared tree output file (default "stdout")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_compare_edges

### Tool Description
Compare edges of a reference tree with another tree

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Compare edges of a reference tree with another tree

If the compared tree file contains several trees, it will take the first one only

Version: 

Usage:
  gotree compare edges [flags]

Flags:
  -h, --help            help for edges
      --moved-taxa      only if --transfer-dist is given: Then display, for each branch, taxa that must be moved
  -m, --transfer-dist   If transfer dist must be computed for each edge

Global Flags:
  -c, --compared string   Compared trees input file (default "none")
      --format string     Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --reftree string    Reference tree input file (default "stdin")
      --seed int          Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int       Number of threads (Max=20) (default 1)
```

## gotree_compare_tips

### Tool Description
Print diff between tip names of two trees or between a tree and a list of tips.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Print diff between tip names of two trees or between a tree and a list of tips.

* Example between 2 trees:
t1.nh : (t1,t2,(t3,t4));
t2.nh : (t10,t2,(t3,t4));

gotree difftips -i t1.nh -c t2.nh

should produce the following output:
< t1
> t10
= 3

* Example between a tree and a list of tips:
t1.nh : (t1,t2,(t3,t4));
t2.txt : 

t10
t2
t3
t4

gotree difftips -i t1.nh -f t2.txt

should produce the following output:
< t1
> t10
= 3

* Options
-c has priority over -f

Version: 

Usage:
  gotree compare tips [flags]

Flags:
  -h, --help             help for tips
  -f, --tipfile string   Tip File (Optional) (default "none")

Global Flags:
  -c, --compared string   Compared trees input file (default "none")
      --format string     Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --reftree string    Reference tree input file (default "stdin")
      --seed int          Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int       Number of threads (Max=20) (default 1)
```

## gotree_compare_trees

### Tool Description
Compare a reference tree with a set of trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Compare a reference tree with a set of trees.

If --binary is given:
For each trees in the compared tree file, it will print tab separated values with:
1) The index of the compared tree in the file
2) "true" if the tree is identical, 
   "false" otherwise

Otherwise:
For each trees in the compared tree file, it will print tab separated values with:
1) The index of the compared tree in the file
2) The number of branches that are specific to the reference tree
3) The number of branches that are common to both trees
4) The number of branches that are specific to the compared tree

If --rf is given, it only computes the Robinson-Foulds distance, as the sum of 
reference + compared specific branches.

If --weighted is given:
For each trees in the compared tree file, it will print tab separated values with:
1) The index of the compared tree in the file
2) The weighted Robinson-Foulds distance (Robinson & Foulds, 1979)
3) The Khuner-Felsenstein branch score (Khuner & Felsenstein, 1994)

If --weighted and --binary are given:
For each trees in the compared tree file, it will print tab separated values with:
1) The index of the compared tree in the file
2) "true" if the tree is identical, both in topology and branch lengths, 
   "false" otherwise

Version: 

Usage:
  gotree compare trees [flags]

Flags:
      --binary     If true, then just print true (identical tree) or false (different tree) for each compared tree
  -h, --help       help for trees
      --rf         If true, outputs Robinson-Foulds distance, as the sum of reference + compared specific branches
  -l, --tips       Include tips in the comparison
      --weighted   If true, outputs comparison metrics including branch lengths

Global Flags:
  -c, --compared string   Compared trees input file (default "none")
      --format string     Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --reftree string    Reference tree input file (default "stdin")
      --seed int          Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int       Number of threads (Max=20) (default 1)
```

## gotree_compute_bipartitiontree

### Tool Description
Builds a tree with only one branch/bipartition.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Builds a tree with only one branch/bipartition.

To do so, it takes an input tree, and one set of tip/leave names.

It will output a tree with one branch separating the given tips from the others of the input tree.

If a given tip does not exist in the input tree, it will not be taken into account (with a warning).

If not tips remain, it will give an error.

Tips may be given using a file with --tipfile (-f) or as last arguments of the command line:

   gotree compute bipartitiontree -i tree.nw -f tipfile -o outtree.nw
or gotree compute bipartitiontree -i tree.nw -o outtree.nw tip1 tip2 tip3

Version: 

Usage:
  gotree compute bipartitiontree [flags]

Flags:
  -h, --help             help for bipartitiontree
  -i, --input string     Input tree (default "stdin")
  -o, --output string    Output tree (default "stdout")
  -f, --tipfile string   Tip file (default "none")

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_compute_consensus

### Tool Description
Computes the consensus of a set of input trees

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Computes the consensus of a set of input trees
Trees must have the same tip names.

Two parameters:
-i : Input file containing several trees
-f : Percentage threshold to keep a bipartition in the consensus 
     It must be >=0.5 && <=1

In the output consensus tree:
1) Branch supports are computed as the proportion of trees in which
   the bipartition is present
2) Branch lengths are computed as the average length of the same branch
   over all the trees where it is present

Version: 

Usage:
  gotree compute consensus [flags]

Flags:
  -f, --freq-min float   Minimum frequency to keep the bipartitions (default 0.5)
  -h, --help             help for consensus
  -i, --input string     Input tree (default "stdin")
  -o, --output string    Output file (default "stdout")

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_compute_edgetrees

### Tool Description
For each edge of the input tree, builds a tree with only this edge.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
For each edge of the input tree, builds a tree with only this edge.

The resulting trees are star trees to which we added one biparition. All branch lengths are set to 1.

Version: 

Usage:
  gotree compute edgetrees [flags]

Flags:
      --deepest          Output a tree only for the deepest bipartition
  -h, --help             help for edgetrees
  -o, --out string       Output tree files prefix (default "stdout")
  -i, --reftree string   Reference tree input file (default "stdin")
      --text-format      Output bipartitions in the form t1,t2,...,tp|tp+1,...tn instead of newick

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_compute_mutations

### Tool Description
Extract the list of mutations along the branches of the phylogeny, given

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Extract the list of mutations along the branches of the phylogeny, given 
	the full list of ancestral (and terminal) sequences.

	The input tree must have internal node names specified and must be rooted.
	The input alignment (fasta or phylip only) must specify one sequence per internal 
	node name and tip.

	The output consists of the list of mutations that appear along the branches of the 
	tree, tab separated text file:

	1. Tree index (useful if several trees in the input tree file)
	2. Alignment site index
	3. Branch index
	4. Child node name
	5. Parent character
	6. Child character
	7. Number of descendent tips
	8. Number of descendent tips that have the child character

	If --eems is specified, then it will compute the number of emergences, i.e. the number of occurence of
	each mutation that is still present to at least ont tip. The columns of the output file will then be :
	1. Tree index (useful if several trees in the input tree file)
	2. Alignment site index
	5. Parent character
	6. Child character
	7. Number of emergence

Version: 

Usage:
  gotree compute mutations [flags]

Flags:
  -a, --align string    Alignment input file (default "stdin")
      --eems            If true, extracts mutations that goes to tips, with their number of emergence (see https://doi.org/10.1101/2021.06.30.450558)
  -h, --help            help for mutations
  -i, --input string    Input tree (default "stdin")
      --input-strict    Strict phylip input format (only used with -p)
  -o, --output string   Output file (default "stdout")
  -p, --phylip          Alignment is in phylip? default : false (Fasta)

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_compute_roccurve

### Tool Description
Computes true positives and false positives at different thresholds

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Computes true positives and false positives at different thresholds

At a given threshold t, the true positives (TP) are the branches that have a support >= t
and that are found in the true tree

At a given threshold t, the false positives (FP) are the branches that have a support >= t
and that are not found in the true tree

You need to provide:
-i           : Input tree, the tree to test
-r           : Reference tree, the true tree
-m           : min threshold 
-M           : max threshold
-s           : step
--length-leq : keep only branches with length <= value
--length-geq : keep only branches with length >= value

As output, a tab delimited file with columns:
1) threshold
2) number of TP
3) number of FP
4) number of TP with branch length filter
5) number of FP with branch length filter

Version: 

Usage:
  gotree compute roccurve [flags]

Flags:
  -h, --help               help for roccurve
  -i, --intree string      Input tree file (default "stdin")
      --length-geq float   Keep only branches that are >= value (-1=No filter)  (default -1)
      --length-leq float   Keep only branches that are <= value (-1=No filter)  (default -1)
  -M, --max float          Max threshold (default 1)
  -m, --min float          Min threshold
  -o, --out string         Output tree file, with supports (default "stdout")
  -p, --pvalue float       Keep only branches that have a pvalue <=  value (default 1)
  -s, --step float         Step between each threshold (default 0.1)
  -r, --truetree string    True tree file (default "none")

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_compute_support_fbp

### Tool Description
Compute classical FBP Support

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Compute classical FBP Support

	For more information, See:
	Lemoine, F. and Domelevo Entfellner, J.-B. and Wilkinson, E. and Correia, D. and Dávila Felipe, M. and De Oliveira, T. and Gascuel, O.
	Renewing Felsenstein’s phylogenetic bootstrap in the era of big data. Nature, 556:452–456

Version: 

Usage:
  gotree compute support fbp [flags]

Flags:
  -h, --help   help for fbp

Global Flags:
  -b, --bootstrap string   Bootstrap trees input file (default "none")
      --format string      Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -l, --log-file string    Output log file (default "stderr")
  -o, --out string         Output tree file, with supports (default "stdout")
  -i, --reftree string     Reference tree input file (default "stdin")
      --seed int           Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
      --silent             If true, progress messages will not be printed to stderr
  -t, --threads int        Number of threads (Max=20) (default 1)
```

## gotree_compute_support_tbe

### Tool Description
Compute BOOtstrap Support by TransfER

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Compute BOOtstrap Support by TransfER

	For more information, See:
	Lemoine, F. and Domelevo Entfellner, J.-B. and Wilkinson, E. and Correia, D. and Dávila Felipe, M. and De Oliveira, T. and Gascuel, O.
	Renewing Felsenstein’s phylogenetic bootstrap in the era of big data. Nature, 556:452–456

Version: 

Usage:
  gotree compute support tbe [flags]

Flags:
      --dist-cutoff float   If --moved-taxa, then this is the distance cutoff to consider a branch for moving taxa computation. It is the normalized distance to the current bootstrap tree (e.g. 0.05). Must be between 0 and 1, otherwise set to 0 (default 0.3)
  -h, --help                help for tbe
      --moved-taxa          If true, will print in log file (-l) taxa that move the most around branches
  -r, --out-raw string      If given, then prints the same tree with non normalized supports (average transfer distance) as branch names, in the form branch_id|avg_distance|branch_depth (default "none")
      --per-branches        If true, will print in log file (-l) average taxa transfers for all taxa per banches of the reference tree

Global Flags:
  -b, --bootstrap string   Bootstrap trees input file (default "none")
      --format string      Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -l, --log-file string    Output log file (default "stderr")
  -o, --out string         Output tree file, with supports (default "stdout")
  -i, --reftree string     Reference tree input file (default "stdin")
      --seed int           Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
      --silent             If true, progress messages will not be printed to stderr
  -t, --threads int        Number of threads (Max=20) (default 1)
```

## gotree_cut_date

### Tool Description
Cut the input tree by keeping only parts in date window.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Cut the input tree by keeping only parts in date window.

This command will extract part of the tree corresponding to >= min-date and <= max-date.

If min-date falls on an internal branch, it will create a new root node and will extract a tree starting at this node.
If max-date is specified (>0) : It additionally removes all tips that are > maxdate

This command considers the input tree as rooted

Version: 

Usage:
  gotree cut date [flags]

Flags:
  -h, --help             help for date
  -i, --input string     Input tree(s) file (default "stdin")
      --max-date float   Maximum date to cut the tree (0=no max date)
      --min-date float   Minimum date to cut the tree
  -o, --output string    Forest output file (default "stdout")

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_divide

### Tool Description
Divide an input tree file into several tree files

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Divide an input tree file into several tree files

If the input file contains several trees, lets say 10, then 10 output files 
will be created, each containing 1 tree.

Example:

gotree divide -i trees.nw -o prefix_

Version: 

Usage:
  gotree divide [flags]

Flags:
  -h, --help            help for divide
  -i, --input string    Input tree(s) file (default "stdin")
  -o, --output string   Divided trees output file prefix (default "prefix")

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_download_itol

### Tool Description
Download a tree image/file from iTOL

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Download a tree image/file from iTOL

Option -c allows to give a configuration file having tab separated key value pairs, 
as defined here:
https://itol.embl.de/help.cgi#bExOpt

Output format (--format) can be:

pdf (default),
png, 
eps, 
svg, 
newick, 
nexus and
phyloxml

Version: 

Usage:
  gotree download itol [flags]

Flags:
  -c, --config string    Itol image config file
  -h, --help             help for itol
  -o, --output string    Tree output file (default "stdout")
  -i, --tree-id string   Tree id to download

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_download_ncbitax

### Tool Description
Downloads the full ncbi taxonomy in newick format

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Downloads the full ncbi taxonomy in newick format

Version: 

Usage:
  gotree download ncbitax [flags]

Flags:
  -h, --help            help for ncbitax
      --map string      Output mapping file between taxid and species name (tab separated) (default "none")
      --nodes-taxid     Keeps tax id as internal nodes identifiers
  -o, --output string   NCBI newick output file (default "stdout")
      --tips-taxid      Keeps tax id as tip names

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_download_panther

### Tool Description
Downloads a panther family tree from panther (http://pantherdb.org/)

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Downloads a panther family tree from panther (http://pantherdb.org/)

Version: 

Usage:
  gotree download panther [flags]

Flags:
  -f, --family-id string   Panther Family ID to download (default "none")
  -h, --help               help for panther
  -o, --output string      Panther family newick output file (default "stdout")

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_draw_cyjs

### Tool Description
Draw trees in html file using cytoscape js.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Draw trees in html file using cytoscape js.

Version: 

Usage:
  gotree draw cyjs [flags]

Flags:
  -h, --help   help for cyjs

Global Flags:
  -f, --annotation-file string   Annotation file to add colored circles to tip nodes (svg & png)
                                 Tab separated, with <tip-name  Red  Green  Blue> or
                                 <tip-name hex-value> on each line
      --format string            Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string             Input tree (default "stdin")
      --no-branch-lengths        Draw the tree without branch lengths (all the same length)
      --no-tip-labels            Draw the tree without tip labels
  -o, --output string            Output file (default "stdout")
      --seed int                 Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
      --support-cutoff float     Cutoff for highlithing supported branches (default 0.7)
  -t, --threads int              Number of threads (Max=20) (default 1)
      --with-branch-support      Highlight highly supported branches
      --with-node-comments       Draw the tree with internal node comments (if --with-node-labels is not set)
      --with-node-labels         Draw the tree with internal node labels
      --with-node-symbols        Draw the tree with internal node symbols
```

## gotree_draw_png

### Tool Description
Draw trees in png files.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Draw trees in png files.

Version: 

Usage:
  gotree draw png [flags]

Flags:
  -c, --circular          Circular/Polar layout (default : normal)
      --fill-background   If true, then background is white, otherwise transparent
  -H, --height int        Height of png image in pixels (default 200)
  -h, --help              help for png
  -r, --radial            Radial layout (default : normal)
  -w, --width int         Width of png image in pixels (default 200)

Global Flags:
  -f, --annotation-file string   Annotation file to add colored circles to tip nodes (svg & png)
                                 Tab separated, with <tip-name  Red  Green  Blue> or
                                 <tip-name hex-value> on each line
      --format string            Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string             Input tree (default "stdin")
      --no-branch-lengths        Draw the tree without branch lengths (all the same length)
      --no-tip-labels            Draw the tree without tip labels
  -o, --output string            Output file (default "stdout")
      --seed int                 Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
      --support-cutoff float     Cutoff for highlithing supported branches (default 0.7)
  -t, --threads int              Number of threads (Max=20) (default 1)
      --with-branch-support      Highlight highly supported branches
      --with-node-comments       Draw the tree with internal node comments (if --with-node-labels is not set)
      --with-node-labels         Draw the tree with internal node labels
      --with-node-symbols        Draw the tree with internal node symbols
```

## gotree_draw_svg

### Tool Description
Draw trees in svg files.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Draw trees in svg files.

Version: 

Usage:
  gotree draw svg [flags]

Flags:
  -c, --circular     Circular/Polar layout (default : normal)
  -H, --height int   Height of svg image in pixels (default 200)
  -h, --help         help for svg
  -r, --radial       Radial layout (default : normal)
  -w, --width int    Width of svg image in pixels (default 200)

Global Flags:
  -f, --annotation-file string   Annotation file to add colored circles to tip nodes (svg & png)
                                 Tab separated, with <tip-name  Red  Green  Blue> or
                                 <tip-name hex-value> on each line
      --format string            Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string             Input tree (default "stdin")
      --no-branch-lengths        Draw the tree without branch lengths (all the same length)
      --no-tip-labels            Draw the tree without tip labels
  -o, --output string            Output file (default "stdout")
      --seed int                 Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
      --support-cutoff float     Cutoff for highlithing supported branches (default 0.7)
  -t, --threads int              Number of threads (Max=20) (default 1)
      --with-branch-support      Highlight highly supported branches
      --with-node-comments       Draw the tree with internal node comments (if --with-node-labels is not set)
      --with-node-labels         Draw the tree with internal node labels
      --with-node-symbols        Draw the tree with internal node symbols
```

## gotree_draw_text

### Tool Description
Print trees in ASCII.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Print trees in ASCII.

Version: 

Usage:
  gotree draw text [flags]

Flags:
  -h, --help        help for text
  -w, --width int   Width of tree/terminal (in characters) (default 200)

Global Flags:
  -f, --annotation-file string   Annotation file to add colored circles to tip nodes (svg & png)
                                 Tab separated, with <tip-name  Red  Green  Blue> or
                                 <tip-name hex-value> on each line
      --format string            Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string             Input tree (default "stdin")
      --no-branch-lengths        Draw the tree without branch lengths (all the same length)
      --no-tip-labels            Draw the tree without tip labels
  -o, --output string            Output file (default "stdout")
      --seed int                 Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
      --support-cutoff float     Cutoff for highlithing supported branches (default 0.7)
  -t, --threads int              Number of threads (Max=20) (default 1)
      --with-branch-support      Highlight highly supported branches
      --with-node-comments       Draw the tree with internal node comments (if --with-node-labels is not set)
      --with-node-labels         Draw the tree with internal node labels
      --with-node-symbols        Draw the tree with internal node symbols
```

## gotree_generate_balancedtree

### Tool Description
Generates a random balanced binary tree

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Generates a random balanced binary tree

Version: 

Usage:
  gotree generate balancedtree [flags]

Flags:
  -d, --depth int   Depth of the balanced binary tree (default 3)
  -h, --help        help for balancedtree

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -n, --nbtrees int     Number of trees to generate (default 1)
  -o, --output string   Tree output file (default "stdout")
  -r, --rooted          Generate rooted trees
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_generate_caterpillartree

### Tool Description
Generates a random caterpilar binary tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Generates a random caterpilar binary tree.

Version: 

Usage:
  gotree generate caterpillartree [flags]

Flags:
  -h, --help         help for caterpillartree
  -l, --nbtips int   Number of tips/leaves of the tree to generate (default 10)

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -n, --nbtrees int     Number of trees to generate (default 1)
  -o, --output string   Tree output file (default "stdout")
  -r, --rooted          Generate rooted trees
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_generate_startree

### Tool Description
Generates a star tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Generates a star tree.

--rooted option is not functional here.

Version: 

Usage:
  gotree generate startree [flags]

Flags:
  -h, --help         help for startree
  -l, --nbtips int   Number of tips/leaves of the tree to generate (default 10)

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -n, --nbtrees int     Number of trees to generate (default 1)
  -o, --output string   Tree output file (default "stdout")
  -r, --rooted          Generate rooted trees
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_generate_topologies

### Tool Description
Generates all possible tree topologies.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Generates all possible tree topologies.

Version: 

Usage:
  gotree generate topologies [flags]

Flags:
  -h, --help           help for topologies
  -i, --input string   Input Tree: Tip names of generate trees are taken from it (default "none")
  -l, --nbtips int     Number of tips/leaves of the trees to generate (default 10)

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -n, --nbtrees int     Number of trees to generate (default 1)
  -o, --output string   Tree output file (default "stdout")
  -r, --rooted          Generate rooted trees
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_generate_uniformtree

### Tool Description
Generates a random uniform binary tree

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Generates a random uniform binary tree

Version: 

Usage:
  gotree generate uniformtree [flags]

Flags:
  -h, --help         help for uniformtree
  -l, --nbtips int   Number of tips/leaves of the tree to generate (default 10)

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -n, --nbtrees int     Number of trees to generate (default 1)
  -o, --output string   Tree output file (default "stdout")
  -r, --rooted          Generate rooted trees
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_generate_yuletree

### Tool Description
Generates a random yule binary tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Generates a random yule binary tree.

Version: 

Usage:
  gotree generate yuletree [flags]

Flags:
  -h, --help         help for yuletree
  -l, --nbtips int   Number of tips/leaves of the tree to generate (default 10)

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -n, --nbtrees int     Number of trees to generate (default 1)
  -o, --output string   Tree output file (default "stdout")
  -r, --rooted          Generate rooted trees
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_graft

### Tool Description
Graft a tree t2 on a tree t1, at the position of a given tip.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Graft a tree t2 on a tree t1, at the position of a given tip.

	The root of t2 will replace the given tip of t2.

	Example: grafting t2 on t1, at tip l1

	t1:      t2:
	/--- l1  /---l4
	|----l2  |---l5
	\---l3   \---l6

	result:
	     /---l4
	/--- |---l5
	|    \---l6
	|---l2
	\---l3

Version: 

Usage:
  gotree graft [flags]

Flags:
  -c, --graft string     Tree to graft (default "none")
  -h, --help             help for graft
  -o, --output string    Output tree (default "stdout")
  -i, --reftree string   Reference tree input file (default "stdin")
  -l, --tip string       Name of the tip to graft the second tree at (default "none")

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_labels

### Tool Description
Lists labels of all tree tips

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Lists labels of all tree tips

Example of usage:

gotree labels -i t.mw

If several trees are given in the input file, labels of all trees are listed.

Version: 

Usage:
  gotree labels [flags]

Flags:
  -h, --help           help for labels
  -i, --input string   Input tree (default "stdin")
      --internal       Internal node labels are listed
      --tips           Tip labels are listed (--tips=false to cancel) (default true)

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_ltt

### Tool Description
Compute Lineage Through Time data.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Compute Lineage Through Time data.

1) Will output data visualizable in statistical packages (R, python, etc.).
Set of x,y coordinates pairs: x: time (or mutations) and y: number of lineages.
2) If --image <image file> is specified, then a ltt plot is drawn in the given output file.
the format of the image depends on the extension (.png, .svg, .pdf, etc. 
	see https://github.com/gonum/plot/blob/342a5cee2153b051d94ae813861f9436c5584de2/plot.go#L525C17-L525C17).
Image width and height can be specified (in inch) with --image-width and --image-height.

Version: 

Usage:
  gotree ltt [flags]

Flags:
  -h, --help               help for ltt
      --image string       LTT plot image image output file (default "none")
      --image-height int   LTT plot image output heigh (default 4)
      --image-width int    LTT plot image image output width (default 4)
  -i, --input string       Input tree(s) file (default "stdin")
  -o, --output string      LTT output file (default "stdout")

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_matrix

### Tool Description
Prints distance matrix associated to the input tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Prints distance matrix associated to the input tree.
	
	The distance matrix can be computed in several ways, depending on the "metric" option:
	* --metric brlen : distances correspond to the sum of branch lengths between the tips (patristic distance). If there is no length for a given branch, 0.0 is the default.
	* --metric boot : distances correspond to the sum of supports of the internal branches separating the tips. If there is no support for a given branch (e.g. for a tip), 1.0 is the default. If branch supports range from 0 to 100, you may consider to use gotree support scale -f 0.01 first.
	* --metric none : distances correspond to the sum of the branches separating the tips, but each individual branch is counted as having a length of 1 (topological distance)

Version: 

Usage:
  gotree matrix [flags]

Flags:
      --avg             Average the distance matrices of all input trees
  -h, --help            help for matrix
  -i, --input string    Input tree (default "stdin")
  -m, --metric string   Distance metric (brlen|boot|none) (default "brlen")
  -o, --output string   Matrix output file (default "stdout")

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_merge

### Tool Description
Merges two rooted trees by adding a new root connecting two former roots.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Merges two rooted trees by adding a new root connecting two former roots.

If one of the tree is not rooted, returns an error
Tip names must be different between the two trees, otherwise returns an error

Edges connecting new root with old roots have length of 1.0.

Version: 

Usage:
  gotree merge [flags]

Flags:
  -c, --compared string   Compared tree input file (default "stdin")
  -h, --help              help for merge
  -o, --output string     Merged tree output file (default "stdout")
  -i, --reftree string    Reference tree input file (default "stdin")

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_nni

### Tool Description
Generates all NNI neighbors from a given tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Generates all NNI neighbors from a given tree.

Version: 

Usage:
  gotree nni [flags]

Flags:
  -h, --help            help for nni
  -i, --input string    Input Tree (default "stdin")
  -o, --output string   NNI output tree file (default "stdout")

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_prune

### Tool Description
This tool removes tips of the input reference tree that :

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
This tool removes tips of the input reference tree that :

1) Are not present in the compared tree (--comp <other tree>) if any or
2) Are present in the given tip file (--tipfile <file>) if any or 
3) Are randomly sampled (--random <num tips>), accounting for diversity (--diversity) or not, or
4) Are given on the command line

If several trees are present in the file given by -i, they are all analyzed and 
written in the output.

If -c and -f are not given, this command will take taxa names on command line, for example:
gotree prune -i reftree.nw -o outtree.nw t1 t2 t3 

By order of priority:
1) -f --tipfile <tip file>
2) -c --comp <other tree>
3) --random <number of tips to randomly sample>  (with or without --diversity)
4) tips given on commandline
5) Nothing is done

If -r is given, behavior is reversed, it keep given tips instead of removing them.

If --random and --diversity are given: Tips to be removed are selected in order to keep the highest diversity in the tree.
To do so, until the desired number of tips is reached, the closest tips pairs are selected, and one of the tip is chosen 
(randomly) to be deleted. In case of equality, one random pair is selected. The process stops when
the number of desired number of tips to remove is reached (--random <int>). If revert is true (-r --revert), then --random <i> indicates 
the number of tips to keep (as opposed to the number of tips to remove).

Version: 

Usage:
  gotree prune [flags]

Flags:
  -c, --comp string      Input compared tree  (default "none")
      --diversity        If the random pruning takes into account diversity (only with --random)
  -h, --help             help for prune
  -o, --output string    Output tree (default "stdout")
      --random int       Number of tips to randomly sample
  -i, --ref string       Input reference tree (default "stdin")
  -r, --revert           If true, then revert the behavior: will keep only species given in the command line, or keep only the species that are specific to the input tree, or keep only randomly selected taxa
  -f, --tipfile string   Tip file (default "none")

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_reformat_newick

### Tool Description
Reformats an input tree file into Newick format.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Reformats an input tree file into Newick format.

- Input formats: Newick, Nexus,
- Output format: Newick.

Version: 

Usage:
  gotree reformat newick [flags]

Flags:
  -h, --help   help for newick

Global Flags:
      --format string         Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string          Input tree (default "stdin")
  -f, --input-format string   Input tree format (newick, nexus, phyloxml, or nextstrain), alias to --format (default "newick")
  -o, --output string         Output file (default "stdout")
      --seed int              Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int           Number of threads (Max=20) (default 1)
```

## gotree_reformat_nexus

### Tool Description
Reformats an input tree file into Nexus format.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Reformats an input tree file into Nexus format.

- Input formats: Newick, Nexus,
- Output format: Nexus.

Version: 

Usage:
  gotree reformat nexus [flags]

Flags:
  -h, --help        help for nexus
      --translate   Renames tip names with indices and add a translate table to the Nexus format

Global Flags:
      --format string         Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string          Input tree (default "stdin")
  -f, --input-format string   Input tree format (newick, nexus, phyloxml, or nextstrain), alias to --format (default "newick")
  -o, --output string         Output file (default "stdout")
      --seed int              Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int           Number of threads (Max=20) (default 1)
```

## gotree_reformat_phyloxml

### Tool Description
Reformats an input tree file into PhyloXML format.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Reformats an input tree file into PhyloXML format.

- Input formats: Newick, Nexus, PhyloXML
- Output format: PhyloXML.

Note that only toplogical information, node names, branch lengths and 
branch supports are kept.

Version: 

Usage:
  gotree reformat phyloxml [flags]

Flags:
  -h, --help   help for phyloxml

Global Flags:
      --format string         Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string          Input tree (default "stdin")
  -f, --input-format string   Input tree format (newick, nexus, phyloxml, or nextstrain), alias to --format (default "newick")
  -o, --output string         Output file (default "stdout")
      --seed int              Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int           Number of threads (Max=20) (default 1)
```

## gotree_rename

### Tool Description
Rename nodes/tips of the input tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Rename nodes/tips of the input tree.

* In default mode, only tips are renamed (--tips=true by default), 
  and a map file must be given (-m), and must be tab separated with columns:
   1) Current name of the tip
   2) Desired new name of the tip
   (if --revert then it is the other way)

   If a tip name does not appear in the map file, it will not be renamed. 
   If a name that does not exist appears in the map file, it will not throw an error.

   Example :

   MapFile :
   A   A2
   B   B2
   C   C2

   gotree rename -m MapFile -i t.nw

             ------C                   ------C2
       x     |z	     	        x      |z	    
   A---------*ROOT    =>    A2---------*ROOT  
             |t	     	               |t	    
             ------B 	               ------B2



* If -a is given, then tips/nodes are renamed using automatically generated identifiers 
  of length 10 Correspondance between old names and new names is written in the map file 
  given with -m. 
  In this mode, --revert has no effect.
  --length  allows to customize length of generated id. It is min 5.
  If several trees in input has different tip names, it does not matter, a new identifier is still
  generated for each new tip name, and same names are reused if needed.

* If -e (--regexp) and -b (--replace) is given, then  will replace matching strings in tip/node 
  names by string given by -b, ex:
  gotree rename -i tree.nh --regexp 'Tip(\d+)' --replace 'Leaf$1' -m map.txt
  this will replace all matches of 'Tip(\d+)' with 'Leaf$1', with $1 being the matched string 
  inside ().

* If --add-quotes is specified, then output names will be surrounded by ''

* If --rm-quotes is specified, starting or ending quotes are removed.

Warning: If after this rename, several tips/nodes have the same name, subsequent commands may 
fail.


If --internal is specified, then internal nodes are renamed;
--tips is true by default. To inactivate it, you must specify --tips=false .

Version: 

Usage:
  gotree rename [flags]

Flags:
      --add-quotes       Add quotes arround tip/node names
  -a, --auto             Renames automatically tips with auto generated id of length 10.
  -h, --help             help for rename
  -i, --input string     Input tree (default "stdin")
      --internal         Internal nodes are taken into account
  -l, --length int       Length of automatically generated id. Only with --auto (default 10)
  -m, --map string       Tip name map file (default "none")
  -o, --output string    Renamed tree output file (default "stdout")
  -e, --regexp string    Regexp to get matching tip/node names (default "none")
  -b, --replace string   String replacement to the given regexp (default "none")
  -r, --revert           Revert orientation of map file
      --rm-quotes        Remove quotes arround tip/node names (priority over --rm-quotes)
      --tips             Tips are taken into account (--tips=false to cancel) (default true)

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_repopulate

### Tool Description
Re populate the tree with tips that have the same sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Re populate the tree with tips that have the same sequences.

When a tree is inferred, some tools first remove identical sequences.

However, it may be useful to keep them in the tree. To do so, this command takes:

1. A input tree
2. A file containing a list of tips that are identical, in the following format:
    Tip1,Tip2
    Tip3,Tip4
    Meaning that Tip1 is identical to Tip2, and Tip3 is identical to Tip4.

"repopulate" command then adds Tip2 next to Tip1 if Tip1 is present in the tree, or 
Tip1 next to Tip2 if Tip2 is present in the tree. To do so, it adds two 0.0 length
 branches. 

Example with Tip1,Tip2 :

 Before     |   After (if l>0.0)  |  After (if l=0.0)
------------+---------------------+-------------------
            |         *Tip1       |     *Tip1
    l       |    l   /.0          |    /0.0
 *----*Tip1 |   ----*	          |   *
            |        \.0          |    \0.0
            |         *Tip2       |     *Tip2

Each identical group must contain exactly 1 already present tip, otherwise it returns
 an error.

If a new tip is present in several groups, then returns and error.

The tree after "repopulate" command may contain polytomies.

Version: 

Usage:
  gotree repopulate [flags]

Flags:
  -h, --help               help for repopulate
  -g, --id-groups string   File with groups of identical tips (default "none")
  -i, --input string       Input tree (default "stdin")
  -o, --output string      Renamed tree output file (default "stdout")

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_reroot_midpoint

### Tool Description
Reroot tree at midpoint.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Reroot tree at midpoint.

Example:

gotree reroot midpoint  -i tree.nw > reroot.nw

Version: 

Usage:
  gotree reroot midpoint [flags]

Flags:
  -h, --help   help for midpoint

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input Tree (default "stdin")
  -o, --output string   Rerooted output tree file (default "stdout")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_reroot_outgroup

### Tool Description
Reroot the tree using an outgroup given in argument or in stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Reroot the tree using an outgroup given in argument or in stdin.

Example:

Reroot on 1 tip named "Tip10" using stdin:
echo "Tip10" | gotree reroot outgroup -i tree.nw -l - > reroot.nw

Reroot using an outgroup defined by 3 tips using stdin:
echo "Tip1,Tip2,Tip10" | gotree reroot outgroup -i tree.nw -l - > reroot.nw

Reroot using an outgroup defined by 3 tips using command args:

gotree reroot outgroup -i tree.nw Tip1 Tip2 Tip3 > reroot.nw

If the outgroup includes a tip that is not present in the tree,
this tip will not be taken into account for the reroot. A warning
will be issued.

By default (--strict=false), if the outgroup is not monophyletic it will
take all the descendant of the LCA to reroot and print a warning.If the
outgroup is not monophyletic and if --strict is given, it exits with an 
error.

If the option -r|--remove-outgroup is given, then the outgroup is
removed after reroot.

Version: 

Usage:
  gotree reroot outgroup [flags]

Flags:
  -h, --help              help for outgroup
  -r, --remove-outgroup   Removes the outgroup after reroot
      --strict            Enforce the outgroup to be monophyletic (else throw an error)
  -l, --tip-file string   File containing names of tips of the outgroup (default "none")

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input Tree (default "stdin")
  -o, --output string   Rerooted output tree file (default "stdout")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_resolve

### Tool Description
Resolve multifurcations by adding 0 length branches.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Resolve multifurcations by adding 0 length branches.

* If any node has more than 3 neighbors :
   Resolve neighbors randomly by adding 0 length 
   branches until it has 3 neighbors

Version: 

Usage:
  gotree resolve [flags]
  gotree resolve [command]

Available Commands:
  named       Resolve named internal nodes into tip + 0 length branches

Flags:
  -h, --help            help for resolve
  -i, --input string    Input tree(s) file (default "stdin")
  -o, --output string   Resolved tree(s) output file (default "stdout")
      --rooted          Considers the tree as rooted (will randomly resolve the root also if needed)

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)

Use "gotree resolve [command] --help" for more information about a command.
```

## gotree_resolve_named

### Tool Description
Resolve named internal nodes into tip + 0 length branches

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Resolve named internal nodes into tip + 0 length branches

	Example:

	-------T1      -------T1
	|              |
	*N1        =>  *---N1      
	|              |
	-------T2      -------T2

Version: 

Usage:
  gotree resolve named [flags]

Flags:
  -h, --help   help for named

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input tree(s) file (default "stdin")
  -o, --output string   Resolved tree(s) output file (default "stdout")
      --rooted          Considers the tree as rooted (will randomly resolve the root also if needed)
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_rotate_rand

### Tool Description
Randomly rotates children of internal nodes.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Randomly rotates children of internal nodes.

It does not change the topology, but just the order of neighbors 
of all node and thus the newick representation.

             ------C                    ------A
       x     |z	   	          x     |z	    
   A---------*ROOT     =>     B---------*ROOT  
             |t	   	                |t	    	 
             ------B 	                ------C

Example of usage:

gotree rotate rand -i t.nw

Version: 

Usage:
  gotree rotate rand [flags]

Flags:
  -h, --help   help for rand

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input tree (default "stdin")
  -o, --output string   Rotated tree output file (default "stdout")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_rotate_sort

### Tool Description
Sorts children of internal nodes by number of tips.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Sorts children of internal nodes by number of tips.

It does not change the topology, but just the order of neighbors 
of all node and thus the newick representation.

             ------C                    ------A
       x     |z	   	          x     |z	    
   A---------*ROOT     =>     B---------*ROOT  
             |t	   	                |t	    	 
             ------B 	                ------C

Example of usage:

gotree rotate sort -i t.nw

Version: 

Usage:
  gotree rotate sort [flags]

Flags:
  -h, --help   help for sort

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input tree (default "stdin")
  -o, --output string   Rotated tree output file (default "stdout")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_rtt

### Tool Description
Compute Root To Tip regression.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Compute Root To Tip regression.

It considers input tree as rooted.

Version: 

Usage:
  gotree rtt [flags]

Flags:
  -h, --help                  help for rtt
      --image string          RTT plot image image output file (default "none")
      --image-height int      RTT plot image output heigh (default 4)
      --image-width int       RTT plot image image output width (default 4)
  -i, --input string          Input tree(s) file (default "stdin")
      --internal-nodes        include internal nodes
      --max-rate float        Mutation rate higher bound (default -1)
      --max-root-date float   Root date (default -1)
      --min-rate float        Mutation rate lower bound (default -1)
      --min-root-date float   Root date (default -1)
  -o, --output string         RTT output file (default "stdout")
      --rate float            Mutation rate to display on the figure (default -1)
      --root-date float       Root date (default -1)

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_sample

### Tool Description
Takes a subsample of the set of trees from the input file.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Takes a subsample of the set of trees from the input file.

It can be with or without replacement depending on the presence of the --replace option

If the number of desired trees is > number of input trees: 
  - with --replace: Will take -n trees
  - without --replace: Will take all trees.

Version: 

Usage:
  gotree sample [flags]

Flags:
  -h, --help            help for sample
  -i, --input string    Input reference trees (default "stdin")
  -n, --nbtrees int     Number of trees to sample from input file (default 1)
  -o, --output string   Output trees (default "stdout")
      --replace         If given, samples with replacement

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_shuffletips

### Tool Description
Shuffle tip names of an input tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Shuffle tip names of an input tree.


             ------C                    ------A
       x     |z	   	          x     |z	    
   A---------*ROOT     =>     B---------*ROOT  
             |t	   	                |t	    	 
             ------B 	                ------C

Example of usage:

gotree shuffletips -i t.nw

Version: 

Usage:
  gotree shuffletips [flags]

Flags:
  -h, --help            help for shuffletips
  -i, --input string    Input tree (default "stdin")
  -o, --output string   Shuffled tree output file (default "stdout")

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_stats

### Tool Description
Print statistics about the tree

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Print statistics about the tree

For example:
- Edge informations
- Node informations
- Tips informations

Version: 

Usage:
  gotree stats [flags]
  gotree stats [command]

Available Commands:
  edges        Displays statistics on edges of input tree
  monophyletic Tells wether input tips form a monophyletic group in each of the input trees
  nodes        Displays statistics on nodes of input tree
  rooted       Tells wether the tree is rooted or unrooted
  splits       Prints all the splits from an input tree
  tips         Displays statistics on tips of input tree

Flags:
  -h, --help            help for stats
  -i, --input string    Input tree (default "stdin")
  -o, --output string   Output file (default "stdout")

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)

Use "gotree stats [command] --help" for more information about a command.
```

## gotree_stats_edges

### Tool Description
Displays statistics on edges of input tree

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Displays statistics on edges of input tree

Statistics are displayed in text format (tab separated):
 0 - Tree id
 1 - Edge id
 2 - Length
 3 - Support
 4 - Terminal (true/false)
 5 - Depth (Shortest path to a tip)
 6 - Topo depth (Number of tips on the lightest side)
 7 - Name of the Right node
 8 - Comment of the edge if any
 9 - name of left node if any
10 - comment of right node if any
11 - comment of left node if any

Example of usage:

gotree stats edges -i t.nw

Version: 

Usage:
  gotree stats edges [flags]

Flags:
  -h, --help   help for edges

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input tree (default "stdin")
  -o, --output string   Output file (default "stdout")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_stats_monophyletic

### Tool Description
Tells wether input tips form a monophyletic group in each of the input trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Tells wether input tips form a monophyletic group in each of the input trees.

Returns true for each tree in which the given tips form a monophyletic group (form a clade containing no other tips).

Version: 

Usage:
  gotree stats monophyletic [flags]

Flags:
  -h, --help              help for monophyletic
  -l, --tip-file string   File containing names of tips of the outgroup (default "none")

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input tree (default "stdin")
  -o, --output string   Output file (default "stdout")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_stats_nodes

### Tool Description
Displays statistics on nodes of input tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Displays statistics on nodes of input tree.

Statistics are displayed in text format (tab separated):
1 - Id of node
2 - Nb neighbors
3 - Name of node
4 - depth of node (shortest path to a tip)

Example of usage:

gotree stats nodes -i t.nw

Version: 

Usage:
  gotree stats nodes [flags]

Flags:
  -h, --help   help for nodes

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input tree (default "stdin")
  -o, --output string   Output file (default "stdout")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_stats_rooted

### Tool Description
Tells wether the tree is rooted or unrooted

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Tells wether the tree is rooted or unrooted

Example of usage:

gotree stats rooted -i t.nw

Version: 

Usage:
  gotree stats rooted [flags]

Flags:
  -h, --help   help for rooted

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input tree (default "stdin")
  -o, --output string   Output file (default "stdout")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_stats_splits

### Tool Description
Prints all the splits from an input tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Prints all the splits from an input tree.

First line : List of taxa
Then: One line per branch, and 0/1

Version: 

Usage:
  gotree stats splits [flags]

Flags:
  -h, --help   help for splits

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input tree (default "stdin")
  -o, --output string   Output file (default "stdout")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_stats_tips

### Tool Description
Displays statistics on tips of input tree

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Displays statistics on tips of input tree

Statistics are displayed in text format (tab separated):
1 - Id of tip
2 - Nb neighbors
3 - Tip Name

Example of usage:

gotree stats tips -i t.mw

Version: 

Usage:
  gotree stats tips [flags]

Flags:
  -h, --help   help for tips

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input tree (default "stdin")
  -o, --output string   Output file (default "stdout")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_subtree

### Tool Description
Select a subtree from the input tree whose root has the given name.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Select a subtree from the input tree whose root has the given name.

The name may be a regexp, for example :
gotree subtree -i tree.nhx -n "^Mammal.*"

If several nodes match the given name/regexp, do nothing, and print the name of matching nodes.

The only matching node must be an internal node, otherwise, it will do nothing and print the tip.

Version: 

Usage:
  gotree subtree [flags]

Flags:
  -h, --help            help for subtree
  -i, --input string    Input tree (default "stdin")
  -n, --name string     Name of the node to select as the root of the subtree (maybe a regex) (default "none")
  -o, --output string   Output tree file (default "stdout")

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_support_clear

### Tool Description
Clear supports from input trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Clear supports from input trees.

Version: 

Usage:
  gotree support clear [flags]

Flags:
  -h, --help   help for clear

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input tree (default "stdin")
  -o, --output string   Cleared tree output file (default "stdout")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_support_round

### Tool Description
Rounds supports of input trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Rounds supports of input trees.

The precision is given by -p|--precision option, and is expressed in 1/10^precision

if -p 5 is given, precision of 10⁻5 is considered.


Does not do anything if precision is <=0;
Takes precision=15 if precision>15.

Version: 

Usage:
  gotree support round [flags]

Flags:
  -h, --help            help for round
  -p, --precision int   Rounding support precision (x means 10^-x) (default 3)

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input tree (default "stdin")
  -o, --output string   Cleared tree output file (default "stdout")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_support_scale

### Tool Description
Scale branch supports from input trees by a given factor.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Scale branch supports from input trees by a given factor.

Version: 

Usage:
  gotree support scale [flags]

Flags:
  -f, --factor float   Branch support scaling factor (default 1)
  -h, --help           help for scale

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input tree (default "stdin")
  -o, --output string   Cleared tree output file (default "stdout")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_support_setrand

### Tool Description
Assign a random support to edges of input trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Assign a random support to edges of input trees.

Support follows a uniform distribution in [0,1].

Version: 

Usage:
  gotree support setrand [flags]

Flags:
  -h, --help   help for setrand

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input tree (default "stdin")
  -o, --output string   Cleared tree output file (default "stdout")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_unroot

### Tool Description
Unroot input tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Unroot input tree.

If the tree is already unrooted does nothing
Otherwise places the root on a trifurcated node and removes
old root.
br length : Take the sum
br support: Take the max

             ------C         
             |z	         
    ---------*	                       ------C 
    |x       |t	                 x+y   |z	   
ROOT*        ------B   =>    A---------*ROOT   
    |y		                       |t	   		 
    ---*A                              ------B 

Example of usage:

gotree unroot -i tree.nw -o tree_u.nw

Version: 

Usage:
  gotree unroot [flags]

Flags:
  -h, --help            help for unroot
  -i, --input string    Input tree (default "stdin")
  -o, --output string   Collapsed tree output file (default "stdout")

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## gotree_upload_itol

### Tool Description
Upload a tree to iTOL and display the access url.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Upload a tree to iTOL and display the access url.

If --id is given, it uploads the tree to the itol account corresponding to the user upload ID.
The upload id is accessible by enabling "Batch upload" option in iTOL user settings. 

If --id is not given, it uploads the tree without account, and will be automatically deleted after 30 days.

If several trees are included in the input file, it will upload all of them, waiting 1 second between each upload

It is possible to give itol annotation files to the uploader:
gotree upload itol -i tree.tree --name tree --user-id uploadkey --project project annotation*.txt

Urls are written on stdout
Server responses are written on stderr

So:
gotree upload itol -i tree.tree --name tree --user-id uploadkey --project project annotation*.txt > urls

Will store only urls in the output file

Version: 

Usage:
  gotree upload itol [flags]

Flags:
  -h, --help             help for itol
      --name string      iTOL tree name prefix (default "tree")
      --project string   iTOL project to upload the tree
      --user-id string   iTOL User upload id

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
  -i, --input string    Input tree (default "stdin")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)
```

## Metadata
- **Skill**: generated
