# clust CWL Generation Report

## clust

### Tool Description
Optimised consensus clustering of multiple heterogeneous datasets

### Metadata
- **Docker Image**: quay.io/biocontainers/clust:1.18.0--pyh086e186_0
- **Homepage**: https://github.com/baselabujamous/clust
- **Package**: https://anaconda.org/channels/bioconda/packages/clust/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/clust/overview
- **Total Downloads**: 39.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/baselabujamous/clust
- **Stars**: N/A
### Original Help Text
```text
usage: clust [-h] [-n <file or int> [<file or int> ...]] [-r <file>]
             [-m <file>] [-o <directory>] [-t <real number>]
             [-basemethods <string> [<string> ...]]
             [-K <integer> [<integer> ...]] [-s <real number>] [-d <integer>]
             [-fil-v <real number>] [-fil-c <integer>] [-fil-d <integer>]
             [--fil-abs] [--fil-perc] [--fil-flat] [--no-fil-flat]
             [-cs <integer>] [-q3s <real number>] [--no-optimisation]
             [--deterministic] [-np <integer>]
             datapath

/===========================================================================\
|                                   Clust                                   |
|     Optimised consensus clustering of multiple heterogeneous datasets     |
|                              Version v1.18.0                              |
|                                                                           |
|                          By Dr Basel Abu-Jamous                           |
|                                 while at                                  |
|                       Department of Plant Sciences                        |
|                         The University of Oxford                          |
|                         baselabujamous@gmail.com                          |
+---------------------------------------------------------------------------+
|                                 Citation                                  |
|                                 ~~~~~~~~                                  |
| When publishing work that uses Clust, please cite:                        |
| Basel Abu-Jamous and Steven Kelly (2018) Clust: automatic extraction of   |
| optimal co-expressed gene clusters from gene expression data. Genome      |
| Biology 19:172; doi: https://doi.org/10.1186/s13059-018-1536-8.           |
+---------------------------------------------------------------------------+
| Full description of usage can be found at:                                |
| https://github.com/BaselAbujamous/clust                                   |
\===========================================================================/

positional arguments:
  datapath              Data file path or directory with data file(s).

options:
  -h, --help            show this help message and exit
  -n <file or int> [<file or int> ...]
                        Normalisation file or list of codes (default: 1000)
  -r <file>             Replicates structure file
  -m <file>             OrthoGroups (OGs) mapping file
  -o <directory>        Output directory
  -t <real number>      Cluster tightness (default: 1.0).
  -basemethods <string> [<string> ...]
                        One or more base clustering methods (default: k-means)
  -K <integer> [<integer> ...]
                        K values, e.g. 2 4 6 10 ... (default: 4 to 20 (step=4))
  -s <real number>      Outlier standard deviations (default: 3.0)
  -d <integer>          Min datasets in which a gene must exist (default: 1)
  -fil-v <real number>  Filtering: gene expression threshold (default: -inf)
  -fil-c <integer>      Filtering: number of conditions (default: 0)
  -fil-d <integer>      Filtering: number of datasets (default: 0)
  --fil-abs             Filter using absolute values of expression
  --fil-perc            -fil-v is a percentile of genes rather than raw value
  --fil-flat            Filter out genes with flat expression profiles (default)
  --no-fil-flat         Cancels the default --fil-flat option
  -cs <integer>         Smallest cluster size (default: 11)
  -q3s <real number>    Q3s defining outliers (default: 2.0)
  --no-optimisation     Skip cluster optimsation & completion
  --deterministic       Obsolete. All steps are already deterministic (v1.7.4+)
  -np <integer>         Obsolete. Number of parallel processes (default: 1)
```

