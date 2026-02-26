# mpboot CWL Generation Report

## mpboot

### Tool Description
MPBoot version 1.1.1 for Linux 64-bit built Apr 15 2025
Copyright (c) 2016 Diep Thi Hoang, Le Sy Vinh, Tomas Flouri, Alexandros Stamatakis, Arndt von Haeseler and Bui Quang Minh.

### Metadata
- **Docker Image**: quay.io/biocontainers/mpboot:1.2--h503566f_0
- **Homepage**: https://github.com/diepthihoang/mpboot
- **Package**: https://anaconda.org/channels/bioconda/packages/mpboot/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mpboot/overview
- **Total Downloads**: 377
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/diepthihoang/mpboot
- **Stars**: N/A
### Original Help Text
```text
MPBoot version 1.1.1 for Linux 64-bit built Apr 15 2025
Copyright (c) 2016 Diep Thi Hoang, Le Sy Vinh, Tomas Flouri, Alexandros Stamatakis, Arndt von Haeseler and Bui Quang Minh.

Usage: mpboot -s <alignment> [OPTIONS] [<treefile>] 

GENERAL OPTIONS:
  -?                   Printing this help dialog
  -s <alignment>       Input alignment (REQUIRED) in PHYLIP/FASTA/NEXUS format
  -st <data_type>      BIN, DNA, AA, CODON, or MORPH (default: auto-detect)
  <treefile>           Initial tree for tree reconstruction (default: MP)
  -pre <PREFIX>        Using <PREFIX> for output files (default: alignment name)
  -seed <number>       Random seed number, normally used for debugging purpose
  -v, -vv, -vvv        Verbose mode, printing more messages to screen

MPBOOT - MAXIMUM PARSIMONY BOOTSTRAP APPROXIMATION:
  -mulhits                  Store multiple equally parsimonious trees per bootstrap replicate
  -ratchet_iter <number>    Number of non-ratchet iterations before each ratchet iteration (default: 1)
  -ratchet_wgt <number>     Weight to add to each site selected for perturbation during ratchet (default: 1)
  -ratchet_percent <number> Percentage of informative sites selected for perturbation during ratchet (default: 50)
  -ratchet_off              Turn of ratchet, i.e. Only use tree perturbation
  -spr_rad <number>         Maximum radius of SPR (default: 3)
  -cand_cutoff <#s>         Use top #s percentile as cutoff for selecting bootstrap candidates (default: 10)
  -opt_btree_off            Turn off refinement step on the final bootstrap tree set
  -nni_pars                 Hill-climb by NNI instead of SPR
  -cost <file>              Read <file> for the matrix of transition cost between character states
                            Replace <file> by letter e for uniform cost.

NEW STOCHASTIC TREE SEARCH ALGORITHM:
  -numpars <number>    Number of initial parsimony trees (default: 100)
  -toppars <number>    Number of best parsimony trees (default: 20)
  -numcand <number>    Size of the candidate tree set (defaut: 5)
  -pers <perturbation> Perturbation strength for randomized NNI (default: 0.5)
  -numstop <number>    Number of unsuccessful iterations to stop (default: 100)
  -n <#iterations>     Fix number of iterations to <#iterations> (default: auto)
  -iqp                 Use the IQP tree perturbation (default: randomized NNI)
  -iqpnni              Switch back to the old IQPNNI tree search algorithm

ULTRAFAST BOOTSTRAP:
  -bb <#replicates>    Ultrafast bootstrap (>=1000)
  -nm <#iterations>    Maximum number of iterations (default: 1000)
  -nstep <#iterations> #Iterations for UFBoot stopping rule (default: 100)
  -bcor <min_corr>     Minimum correlation coefficient (default: 0.99)
  -beps <epsilon>      RELL epsilon to break tie (default: 0.5)

CONSENSUS RECONSTRUCTION:
  <tree_file>          Set of input trees for consensus reconstruction
  -t <threshold>       Min split support in range [0,1]. 0.5 for majority-rule
                       consensus (default: 0, i.e. extended consensus)
  -bi <burnin>         Discarding <burnin> trees at beginning of <treefile>
  -con                 Computing consensus tree to .contree file
  -net                 Computing consensus network to .nex file
  -sup <target_tree>   Assigning support values for <target_tree> to .suptree

ROBINSON-FOULDS DISTANCE:
  -rf_all              Computing all-to-all RF distances of trees in <treefile>
  -rf <treefile2>      Computing all RF distances between two sets of trees
                       stored in <treefile> and <treefile2>
  -rf_adj              Computing RF distances of adjacent trees in <treefile>

GENERATING RANDOM TREES:
  -r <num_taxa>        Create a random tree under Yule-Harding model.
  -ru <num_taxa>       Create a random tree under Uniform model.
  -rcat <num_taxa>     Create a random caterpillar tree.
  -rbal <num_taxa>     Create a random balanced tree.
  -rcsg <num_taxa>     Create a random circular split network.
  -rlen <min_len> <mean_len> <max_len>  
                       min, mean, and max branch lengths of random trees.

PRINTING SITE PARSIMONY SCORES:
  -wspars              When using together with parsimony tree inference, print site parsimony scores of the best tree found.
  -wspars-user-tree <treefile> Print site parsimony scores of the user tree in <treefile>
```

