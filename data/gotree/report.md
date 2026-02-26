# gotree CWL Generation Report

## gotree_acr

### Tool Description
Reconstructs most parsimonious ancestral characters.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Total Downloads**: 29.4K
- **Last updated**: 2025-12-15
- **GitHub**: https://github.com/fredericlemoine/gotree
- **Stars**: N/A
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


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
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


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
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


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
```


## gotree_brlen

### Tool Description
Set a minimum branch length, or set random branch lengths, or multiply branch lengths by a factor.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Commands to modify lengths of branches:
Set a minimum branch length, or set random branch lengths, or multiply branch lengths by a factor.

Version: 

Usage:
  gotree brlen [command]

Available Commands:
  add         Add the given length to all branches of the tree.
  clear       Clear lengths from input trees
  cut         Cut branches whose length is greater than or equal to the given length 
  round       Rounds branch lengths of input trees
  scale       Scale lengths from input trees by a given factor
  set         Set the given branch length to all branches
  setmin      Set a min branch length to all branches with length < cutoff
  setrand     Assign a random length to edges of input trees

Flags:
      --external       Applies to external branches (default true)
  -h, --help           help for brlen
  -i, --input string   Input tree (default "stdin")
      --internal       Applies to internal branches (default true)

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)

Use "gotree brlen [command] --help" for more information about a command.


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
```


## gotree_collapse

### Tool Description
Collapse branches of input trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Collapse branches of input trees.

Version: 

Usage:
  gotree collapse [command]

Available Commands:
  clade       Collaps the clade defined by the given tip names
  depth       Collapse branches having a given depth
  length      Collapse short branches of the input tree
  name        Collapse branches having given name or ID
  single      Collapse branches that connect single nodes
  support     Collapse lowly supported branches of the input tree

Flags:
  -h, --help            help for collapse
  -i, --input string    Input tree (default "stdin")
  -o, --output string   Collapsed tree output file (default "stdout")

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)

Use "gotree collapse [command] --help" for more information about a command.


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
```


## gotree_comment

### Tool Description
Modify branch/node comments

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Modify branch/node comments

Version: 

Usage:
  gotree comment [command]

Available Commands:
  clear       Removes node/tip comments
  transfer    Transfers node names to comments

Flags:
  -h, --help            help for comment
  -i, --input string    Input tree (default "stdin")
  -o, --output string   Cleared tree output file (default "stdout")

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)

Use "gotree comment [command] --help" for more information about a command.


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
```


## gotree_compare

### Tool Description
Compare full trees, edges, or tips.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Compare full trees, edges, or tips.

Version: 

Usage:
  gotree compare [command]

Available Commands:
  edges       Compare edges of a reference tree with another tree
  tips        Print diff between tip names of two trees or between a tree and a list of tips
  trees       Compare a reference tree with a set of trees

Flags:
  -c, --compared string   Compared trees input file (default "none")
  -h, --help              help for compare
  -i, --reftree string    Reference tree input file (default "stdin")

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)

Use "gotree compare [command] --help" for more information about a command.


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
```


## gotree_completion

### Tool Description
Generate the autocompletion script for gotree for the specified shell.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Generate the autocompletion script for gotree for the specified shell.
See each sub-command's help for details on how to use the generated script.

Version: 

Usage:
  gotree completion [command]

Available Commands:
  bash        Generate the autocompletion script for bash
  fish        Generate the autocompletion script for fish
  powershell  Generate the autocompletion script for powershell
  zsh         Generate the autocompletion script for zsh

Flags:
  -h, --help   help for completion

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)

Use "gotree completion [command] --help" for more information about a command.


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
```


## gotree_compute

### Tool Description
Computations such as consensus and supports.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Computations such as consensus and supports.

Version: 

Usage:
  gotree compute [command]

Available Commands:
  bipartitiontree Builds a tree with only one branch/bipartition
  consensus       Computes the consensus of a set of trees
  edgetrees       For each edge of the input tree, builds a tree with only this edge
  mutations       Extract the list of mutations along the branches of the phylogeny.
  roccurve        Computes true positives and false positives at different thresholds
  support         Computes different kind of branch supports

Flags:
  -h, --help   help for compute

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)

Use "gotree compute [command] --help" for more information about a command.


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
```


## gotree_cut

### Tool Description
Cut the tree

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Cut the tree

Version: 

Usage:
  gotree cut [flags]
  gotree cut [command]

Available Commands:
  date        Cut the input tree by keeping only parts in date window

Flags:
  -h, --help   help for cut

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)

Use "gotree cut [command] --help" for more information about a command.


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
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


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
```


## gotree_download

### Tool Description
Download trees or images from different servers (itol, ncbi taxonomy)

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Download trees or images from different servers (itol, ncbi taxonomy)

Version: 

Usage:
  gotree download [command]

Available Commands:
  itol        Download a tree image/file from iTOL
  ncbitax     Downloads the full ncbi taxonomy in newick format
  panther     Downloads a panther family tree from panther (http://pantherdb.org/)

Flags:
  -h, --help   help for download

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)

Use "gotree download [command] --help" for more information about a command.


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
```


## gotree_draw

### Tool Description
Draw trees

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Draw trees

Version: 

Usage:
  gotree draw [command]

Available Commands:
  cyjs        Draw trees in html file using cytoscape js
  png         Draw trees in png files
  svg         Draw trees in svg files
  text        Print trees in ASCII

Flags:
  -f, --annotation-file string   Annotation file to add colored circles to tip nodes (svg & png)
                                 Tab separated, with <tip-name  Red  Green  Blue> or
                                 <tip-name hex-value> on each line
  -h, --help                     help for draw
  -i, --input string             Input tree (default "stdin")
      --no-branch-lengths        Draw the tree without branch lengths (all the same length)
      --no-tip-labels            Draw the tree without tip labels
  -o, --output string            Output file (default "stdout")
      --support-cutoff float     Cutoff for highlithing supported branches (default 0.7)
      --with-branch-support      Highlight highly supported branches
      --with-node-comments       Draw the tree with internal node comments (if --with-node-labels is not set)
      --with-node-labels         Draw the tree with internal node labels
      --with-node-symbols        Draw the tree with internal node symbols

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)

Use "gotree draw [command] --help" for more information about a command.


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
```


## gotree_generate

### Tool Description
Generate random trees

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Generate random trees

Version: 

Usage:
  gotree generate [command]

Available Commands:
  balancedtree    Generates a random balanced binary tree
  caterpillartree Generates a random caterpilar binary tree
  startree        Generates a star tree
  topologies      Generates all possible tree topologies
  uniformtree     Generates a random uniform binary tree
  yuletree        Generates a random yule binary tree

Flags:
  -h, --help            help for generate
  -n, --nbtrees int     Number of trees to generate (default 1)
  -o, --output string   Tree output file (default "stdout")
  -r, --rooted          Generate rooted trees

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)

Use "gotree generate [command] --help" for more information about a command.


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
```


## gotree_graft

### Tool Description
Graft a tree t2 on a tree t1, at the position of a given tip.
The root of t2 will replace the given tip of t2.

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


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
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


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
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


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
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


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
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


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
```


## gotree_nni

### Tool Description
Perform Nearest Neighbor Interchange (NNI) rearrangement on a tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
panic: runtime error: invalid memory address or nil pointer dereference
[signal SIGSEGV: segmentation violation code=0x1 addr=0x0 pc=0x62f16ed06bec]

goroutine 1 [running]:
github.com/evolbioinfo/gotree/tree.(*Tree).Root(...)
	github.com/evolbioinfo/gotree/tree/tree.go:114
github.com/evolbioinfo/gotree/tree.(*Tree).Edges(0x0)
	github.com/evolbioinfo/gotree/tree/tree.go:126 +0x4c
github.com/evolbioinfo/gotree/tree.(*NNIRearranger).Rearrange(0x62f16f14302a?, 0x0, 0xc00009fd08)
	github.com/evolbioinfo/gotree/tree/rearrange.go:23 +0x25
github.com/evolbioinfo/gotree/cmd.init.func42(0xc0001f0600?, {0x62f16f1419ae?, 0x4?, 0x62f16f1419b2?})
	github.com/evolbioinfo/gotree/cmd/nni.go:39 +0x227
github.com/spf13/cobra.(*Command).execute(0x62f16fe013c0, {0x62f16fe48260, 0x0, 0x0})
	github.com/spf13/cobra@v1.5.0/command.go:872 +0x6c2
github.com/spf13/cobra.(*Command).ExecuteC(0x62f16fe07f40)
	github.com/spf13/cobra@v1.5.0/command.go:990 +0x38e
github.com/spf13/cobra.(*Command).Execute(...)
	github.com/spf13/cobra@v1.5.0/command.go:918
github.com/evolbioinfo/gotree/cmd.Execute()
	github.com/evolbioinfo/gotree/cmd/root.go:107 +0x1a
main.main()
	github.com/evolbioinfo/gotree/main.go:21 +0xf
```


## gotree_prune

### Tool Description
This tool removes tips of the input reference tree that : 

1) Are not present in the compared tree (--comp <other tree>) if any or
2) Are present in the given tip file (--tipfile <file>) if any or 
3) Are randomly sampled (--random <num tips>), accounting for diversity (--diversity) or not, or
4) Are given on the command line

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


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
```


## gotree_reformat

### Tool Description
Reformats an input tree file into different formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Reformats an input tree file into different formats.

So far, it can be :
- Input formats: Newick, Nexus
- Output formats: Newick, Nexus.

Version: 

Usage:
  gotree reformat [command]

Available Commands:
  newick      Reformats an input tree file into Newick format
  nexus       Reformats an input tree file into Nexus format
  phyloxml    Reformats an input tree file into PhyloXML format

Flags:
  -h, --help                  help for reformat
  -i, --input string          Input tree (default "stdin")
  -f, --input-format string   Input tree format (newick, nexus, phyloxml, or nextstrain), alias to --format (default "newick")
  -o, --output string         Output file (default "stdout")

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)

Use "gotree reformat [command] --help" for more information about a command.


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
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


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
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


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
```


## gotree_reroot

### Tool Description
Reroot trees using an outgroup or at midpoint.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Reroot trees using an outgroup or at midpoint.

Version: 

Usage:
  gotree reroot [command]

Available Commands:
  midpoint    Reroot trees at midpoint
  outgroup    Reroot trees using an outgroup

Flags:
  -h, --help            help for reroot
  -i, --input string    Input Tree (default "stdin")
  -o, --output string   Rerooted output tree file (default "stdout")

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)

Use "gotree reroot [command] --help" for more information about a command.


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
```


## gotree_resolve

### Tool Description
Resolve multifurcations by adding 0 length branches.

* If any node has more than 3 neighbors :
   Resolve neighbors randomly by adding 0 length 
   branches until it has 3 neighbors

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


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
```


## gotree_rotate

### Tool Description
Rotates children of internal nodes by different means.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Rotates children of internal nodes by different means.

Either randomly with "rand" subcommand, either sorting by number of tips
with "sort" subcommand.

It does not change the topology, but just the order of neighbors 
of all node and thus the newick representation.

             ------C                    ------A
       x     |z	   	          x     |z	    
   A---------*ROOT     =>     B---------*ROOT  
             |t	   	                |t	    	 
             ------B 	                ------C

Example of usage:

gotree rotate rand -i t.nw
gotree rotate sort -i t.nw

Version: 

Usage:
  gotree rotate [command]

Available Commands:
  rand        Randomly rotates children of internal nodes
  sort        Sorts children of internal nodes by number of tips

Flags:
  -h, --help            help for rotate
  -i, --input string    Input tree (default "stdin")
  -o, --output string   Rotated tree output file (default "stdout")

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)

Use "gotree rotate [command] --help" for more information about a command.


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
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


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
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


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
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


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
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


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
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


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
```


## gotree_support

### Tool Description
Modify supports of branches from input trees

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Modify supports of branches from input trees

Version: 

Usage:
  gotree support [command]

Available Commands:
  clear       Clear supports from input trees
  round       Rounds supports of input trees
  scale       Scale branch supports from input trees by a given factor
  setrand     Assign a random support to edges of input trees

Flags:
  -h, --help            help for support
  -i, --input string    Input tree (default "stdin")
  -o, --output string   Cleared tree output file (default "stdout")

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)

Use "gotree support [command] --help" for more information about a command.


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
```


## gotree_unroot

### Tool Description
Unroot input tree.

If the tree is already unrooted does nothing
Otherwise places the root on a trifurcated node and removes
old root.
br length : Take the sum
br support: Take the max

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


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
```


## gotree_upload

### Tool Description
Upload a tree to a given server

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Upload a tree to a given server

Version: 

Usage:
  gotree upload [command]

Available Commands:
  itol        Upload a tree to iTOL and display the access url

Flags:
  -h, --help           help for upload
  -i, --input string   Input tree (default "stdin")

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)

Use "gotree upload [command] --help" for more information about a command.


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
```


## gotree_version

### Tool Description
Displays version of gotree.

### Metadata
- **Docker Image**: quay.io/biocontainers/gotree:0.5.1--he881be0_0
- **Homepage**: https://github.com/fredericlemoine/gotree
- **Package**: https://anaconda.org/channels/bioconda/packages/gotree/overview
- **Validation**: PASS

### Original Help Text
```text
Displays version of gotree.

Version: 

Usage:
  gotree version [flags]

Flags:
  -h, --help   help for version

Global Flags:
      --format string   Input tree format (newick, nexus, phyloxml, or nextstrain) (default "newick")
      --seed int        Random Seed: -1 = nano seconds since 1970/01/01 00:00:00 (default -1)
  -t, --threads int     Number of threads (Max=20) (default 1)


If you use the Gotree/Goalign toolkit, please cite:
Lemoine F, Gascuel O.
Gotree/Goalign: toolkit and Go API to facilitate the development of phylogenetic workflows.
NAR Genom Bioinform. 2021 Aug 11;3(3):lqab075.
doi: 10.1093/nargab/lqab075. PMID: 34396097; PMCID: PMC8356961.
```

