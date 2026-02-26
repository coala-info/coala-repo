# cmaple CWL Generation Report

## cmaple

### Tool Description
CMAPLE: A tool for phylogenetic analysis and tree search, supporting various models and branch support assessments.

### Metadata
- **Docker Image**: quay.io/biocontainers/cmaple:1.1.0--h503566f_1
- **Homepage**: https://github.com/iqtree/cmaple
- **Package**: https://anaconda.org/channels/bioconda/packages/cmaple/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cmaple/overview
- **Total Downloads**: 1.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/iqtree/cmaple
- **Stars**: N/A
### Original Help Text
```text
CMAPLE version 1.1.0 for Linux 64-bit built Dec 12 2024
Developed by Nhan Ly-Trong, Chris Bielow, Nicola De Maio, Bui Quang Minh.

Usage: cmaple -aln <ALIGNMENT> [-m <MODEL>] [-t <TREE>] ...

GENERAL OPTIONS:
  -h, --help           Print help usages.
  -aln <ALIGNMENT>     Specify an input alignment file in PHYLIP, FASTA,
                       or MAPLE format.
  -m <MODEL>           Specify a model name.
  -st <SEQ_TYPE>       Specify a sequence type (DNA/AA).
  --format <FORMAT>    Set the alignment format (PHYLIP/FASTA/MAPLE).
  -t <TREE_FILE>       Specify a starting tree for tree search.
  --no-reroot          Do not reroot the input tree.
  --blfix              Keep branch lengths unchanged. 
  --ignore-annotation  Ignore annotations from the input tree. 
  --search <TYPE>      Set tree search type (FAST/NORMAL/EXHAUSTIVE).
  --shallow-search     Perform a shallow tree search
                       before a deeper tree search.
  --prefix <PREFIX>    Specify a prefix for all output files.
  --replace-intree     Allow CMAPLE to replace the input tree
                       when computing branch supports.
  --out-mul-tree       Output the tree in multifurcating format.
  --out-internal       Output IDs of internal nodes.
  --overwrite          Overwrite output files if existing.
  -ref <FILE>,<SEQ>    Specify the reference genome.
  --out-aln <FILE>     Write the input alignment to a file in 
                       MAPLE (default), PHYLIP, or FASTA format.
  --out-format <FORMAT> Specify the format (MAPLE/PHYLIP/FASTA) 
                       to output the alignment with `--out-aln`.
  --min-blength <NUM>  Set the minimum branch length.
  --thresh-prob <NUM>  Specify a parameter for approximations.
  --mut-update <NUM>   Set the period to update the substitution rates.
  --max-subs <NUM>     Specify the maximum #substitutions per site
                       that CMAPLE is effective. Default: 0.067.
  --mean-subs <NUM>    Specify the mean #substitutions per site
                       that CMAPLE is effective. Default: 0.02.
  --seed <NUM>         Set a seed number for random generators.
  -v <MODE>            Set the verbose mode (QUIET/MIN/MED/MAX/DEBUG).

ASSESSING SH-aLRT BRANCH SUPPORTS:
  --alrt               Compute branch supports (aLRT-SH).
  --replicates <NUM>   Set the number of replicates for computing
                       branch supports (aLRT-SH).
  --epsilon <NUM>      Set the epsilon value for computing
                       branch supports (aLRT-SH).
  -nt <NUM_THREADS>    Set the number of threads for computing
                       branch supports. Use `-nt AUTO` 
                       to employ all available CPU cores.

ASSESSING SPRTA BRANCH SUPPORTS:
  --sprta               Compute SPRTA supports.
  --thresh-opt-diff-fac <NUM> A relative factor to determine whether 
                        SPRs are close to the optimal one.
  --zero-branch-supp    Compute supports for zero-length branches.
  --out-alternative-spr Output alternative SPRs and their supports.
  --min-sup-alt <MIN>   The min support to be outputted as 
                        alternative SPRs.
```

