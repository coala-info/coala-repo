# tree-qmc CWL Generation Report

## tree-qmc

### Tool Description
A tool for species tree estimation from gene trees or character data using weighted quartet-based methods.

### Metadata
- **Docker Image**: quay.io/biocontainers/tree-qmc:3.0.4--hee07fbb_0
- **Homepage**: https://github.com/molloy-lab/TREE-QMC
- **Package**: https://anaconda.org/channels/bioconda/packages/tree-qmc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tree-qmc/overview
- **Total Downloads**: 3.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/molloy-lab/TREE-QMC
- **Stars**: N/A
### Original Help Text
```text
TREE-QMC version 3.0.4
COMMAND: /usr/local/bin/tree-qmc --help 
=================================== TREE-QMC ===================================
BASIC USAGE:
tree-qmc (-i|--input) <input file>

**If the directory containing the tree-qmc binary is not part of $PATH, replace
eplace tree-qmc with <path to tree-qmc binary>/tree-qmc in the command above**

Help Options:
[-h|--help]
        Prints this help message.

Input Options:
(-i|--input) <input file>
        File with gene trees in newick format (required)
[(--chars)]
        Input are characters rather than trees
        Missing states are N, -, and ?
[(--bp)]
        Input are binary characters i.e. bipartitions
        Missing states are N, -, and ?
[(-a|-mapping) <mapping file>]
        File with individual/leaf names (1st col) mapped to species (2nd col)
[(--root) <list of species separated by commas>]
        Root species tree at given species if possible
[(--rootonly) <species tree file>]
        Root species tree in file and then exit
[(--supportonly) <species tree file>]
        Compute quartet support for species tree in file and then exit

[(--pcsonly) <species tree file>]
        Compute partitioned coalescent support (PCS) for specified branch in
        species tree in file (anotate branch with PCS) and then exit

Output Options:
[(-o|--output) <output file>]
        File for writing output species tree (default: stdout)
[(--support)]
        Compute quartet support for output species tree
[(--writetable) <table file>]
        Write branch and quartet support information to CSV
[(--char2tree)]
        Write character matrix as trees (newick strings) to output and exit

Algorithm Options:
[(--hybrid)]
        Use hybrid weighting scheme (-w h)
[(--fast)]
        Use fast algorithm that does not support weights or polytomies (-w f)
[(-B|--bayes)]
       Use presets for bayesian support (-n 0.333 -x 1.0 -d 0.333)
[(-L|--lrt)]
       Use presets for likelihood support (-n 0.0 -x 1.0 -d 0.0)
[(-S|--bootstrap)]
       Use presets for boostrap support (-n 0 -x 100 -d 0)
[(-c|--contract) <float>]
       Contract internal branches with support less than specified threshold
       after mapping suport to the interval 0 to 1

Advanced Options:
[(-w|--weight) <character>]
        Weighting scheme for quartets; see paper for details
        -w n: none (default)
        -w h: hybrid of support and length (recommended)
        -w s: support only
        -w l: length only
        -w f: none fast
              Refines polytomies arbitrarily so faster algorithm can be used
[(-n|--min) <float>]
        Minimum value of input branch support
[(-x|--max) <float>]
        Maximum value of input branch support
[(-d|--default) <float>]
        Default branch support to use if branch input tree is missing support
        Default branch length is 0.0
[(--norm_atax) <integer>]
        Normalization scheme for artificial taxa; see paper for details
        --norm_atax 0: none
        --norm_atax 1: uniform
        --norm_atax 2: non-uniform (default)
[(-e|--execution) <execution mode>]
        -e 0: run efficient algorithm (default)
        -e 1: run brute force algorithm for testing
        -e 2: compute weighted quartets, then exit
        -e 3: compute good and bad edges, then exit
[(-v|--verbose) <verbose mode>]
        -v 0: write no subproblem information (default)
        -v 1: write CSV with subproblem information (subproblem ID, parent
              problem ID, depth of recursion, total # of taxa, # of artifical
              taxa, species names)
        -v 2: write CSV with subproblem information (info from v1 plus # of
              of elements in f, # of pruned elements in f, # of zeroes in f)
[(--polyseed) <integer>]
        Seeds random number generator with prior to arbitrarily resolving
        polytomies. If seed is set to -1, system time is used;
        otherwise, seed should be positive (default: 12345).
[(--maxcutseed) <integer>]
        Seeds random number generator prior to calling the max cut heuristic
        but after the preprocessing phase. If seed is set to -1, system time
        is used; otherwise, seed should be positive (default: 1).
[--shared <use shared taxon data structure to normalize quartet weights>]
        Do NOT use unless there are NO missing data!!!

Contact: Post issue to Github (https://github.com/molloy-lab/TREE-QMC/)
        or email Yunheng Han (yhhan@umd.edu) & Erin Molloy (ekmolloy@umd.edu)

If you use TREE-QMC in your work, please cite:
  Han and Molloy, 2024, https://github.com/molloy-lab/weighted-TREE-QMC.

  and

  Han and Molloy, 2023, Improving quartet graph construction for scalable
  and accurate species tree estimation from gene trees, Genome Research,
  http:doi.org/10.1101/gr.277629.122.
================================================================================
```


## Metadata
- **Skill**: generated
