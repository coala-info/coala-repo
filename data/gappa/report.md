# gappa CWL Generation Report

## gappa_analyze

### Tool Description
Commands for analyzing and comparing placement data, that is, finding differences and patterns.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Total Downloads**: 90.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/lczech/gappa
- **Stars**: N/A
### Original Help Text
```text
Commands for analyzing and comparing placement data, that is, finding differences and patterns.
Usage: gappa analyze [OPTIONS] SUBCOMMAND

Options:
  --help FLAG                 Print this help message and exit.

Subcommands:
  correlation                 Calculate the Edge Correlation of samples and metadata features.
  dispersion                  Calculate the Edge Dispersion between samples.
  edgepca                     Perform Edge PCA (Principal Component Analysis) for a set of samples.
  imbalance-kmeans            Run Imbalance k-means clustering on a set of samples.
  krd                         Calculate the pairwise Kantorovich-Rubinstein (KR) distance matrix between samples.
  phylogenetic-kmeans         Run Phylogenetic k-means clustering on a set of samples.
  placement-factorization     Perform Placement-Factorization on a set of samples.
  squash                      Perform Squash Clustering for a set of samples.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```


## gappa_edit

### Tool Description
Commands for editing and manipulating files like jplace, fasta or newick.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Commands for editing and manipulating files like jplace, fasta or newick.
Usage: gappa edit [OPTIONS] SUBCOMMAND

Options:
  --help FLAG                 Print this help message and exit.

Subcommands:
  accumulate                  Accumulate the masses of each query in jplace files into basal branches so that they exceed a given mass threshold.
  extract                     Extract placements from clades of the tree and write per-clade jplace files.
  filter                      Filter jplace files according to some criteria, that is, remove all queries and/or placement locations that do not pass the provided filter(s).
  merge                       Merge jplace files by combining their pqueries into one file.
  multiplicity                Edit the multiplicities of queries in jplace files.
  split                       Split the queries in jplace files into multiple files, for example, according to an OTU table.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```


## gappa_examine

### Tool Description
Commands for examining, visualizing, and tabulating information in placement data.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Commands for examining, visualizing, and tabulating information in placement data.
Usage: gappa examine [OPTIONS] SUBCOMMAND

Options:
  --help FLAG                 Print this help message and exit.

Subcommands:
  assign                      Taxonomically assign placed query sequences and output tabulated summarization.
  edpl                        Calcualte the Expected Distance between Placement Locations (EDPL) for all pqueries.
  graft                       Make a tree with each of the query sequences represented as a pendant edge.
  heat-tree                   Make a tree with edges colored according to the placement mass of the samples.
  info                        Print basic information about placement files.
  lwr-distribution            Print a summary table that represents the distribution of the likelihood weight ratios (LWRs) of all pqueries.
  lwr-histogram               Print a table with histograms of the likelihood weight ratios (LWRs) of all pqueries.
  lwr-list                    Print a list of all pqueries with their likelihood weight ratios (LWRs).

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```


## gappa_prepare

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Commands for preparing and preprocessing of phylogenetic and placement data.
Usage: gappa prepare [OPTIONS] SUBCOMMAND

Options:
  --help FLAG                 Print this help message and exit.

Subcommands:
  chunkify                    Chunkify a set of fasta files and create abundance maps.
  clean-tree                  Clean a tree in Newick format by removing parts that other parsers have difficulties with.
  phat                        Generate consensus sequences from a sequence database according to the PhAT method.
  taxonomy-tree               Turn a taxonomy into a tree that can be used as a constraint for tree inference.
  unchunkify                  Unchunkify a set of jplace files using abundance map files and create per-sample jplace files.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```


## gappa_simulate

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Commands for random generation of phylogenetic and placement data.
Usage: gappa simulate [OPTIONS] SUBCOMMAND

Options:
  --help FLAG                 Print this help message and exit.

Subcommands:
  random-alignment            Create a random alignment with a given numer of sequences of a given length.
  random-placements           Create a set of random phylogenetic placements on a given reference tree.
  random-tree                 Create a random tree with a given numer of leaf nodes.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```


## gappa_tools

### Tool Description
Auxiliary commands of gappa.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Auxiliary commands of gappa.
Usage: gappa tools [OPTIONS] SUBCOMMAND

Options:
  --help FLAG                 Print this help message and exit.

Subcommands:
  citation                    Print references to be cited when using gappa.
  license                     Show the license of gappa.
  version                     Extended version information about gappa.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```


## Metadata
- **Skill**: generated
