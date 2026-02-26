# clusty CWL Generation Report

## clusty

### Tool Description
Clustering tool for pairwise distances or similarities

### Metadata
- **Docker Image**: quay.io/biocontainers/clusty:1.2.2--h9ee0642_0
- **Homepage**: https://github.com/refresh-bio/clusty
- **Package**: https://anaconda.org/channels/bioconda/packages/clusty/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/clusty/overview
- **Total Downloads**: 3.6K
- **Last updated**: 2025-12-09
- **GitHub**: https://github.com/refresh-bio/clusty
- **Stars**: N/A
### Original Help Text
```text
Clusty
  version 1.2.2-b687638 (2025-05-22)

Usage:
clusty [options] <distances> <assignments>

Parameters:
  <distances> - input TSV/CSV table with pairwise distances
  <assignments> - output TSV/CSV table with assignments

Options:
  --objects-file <string> - optional TSV/CSV file with object names in the first column sorted decreasingly w.r.t. representativness
  --algo <single | complete | uclust | set-cover | cd-hit | leiden> - clustering algorithm:
    * single     - single linkage (connected component, MMseqs mode 1)
    * complete   - complete linkage
    * uclust     - UCLUST
    * set-cover  - greedy set cover (MMseqs mode 0)
    * cd-hit     - CD-HIT (greedy incremental; MMseqs mode 2)
    * leiden     - Leiden algorithm

  --id-cols <column-name1> <column-name2> - names of columns with sequence identifiers (default: two first columns)
  --distance-col <column-name> - name of the column with pairwise distances (or similarities; default: third column)
  --similarity - use similarity instead of distances (has to be in [0,1] interval; default: false)
  --percent-similarity - use percent similarity (has to be in [0,100] interval; default: false)
  --min <column-name> <real-threshold> - accept pairwise connections with values greater or equal given threshold in a specified column
  --max <column-name> <real-threshold> - accept pairwise connections with values lower or equal given threshold in a specified column
  --numeric-ids - use when sequences in the distances file are represented by numbers (can be mapped to string ids by the object file)
  --out-representatives - output a representative object for each cluster instead of a cluster numerical identifier (default: false)
  --out-csv - output a CSV table instead of a default TSV (default: false)
  --version - show Clusty version

  --leiden-resolution - resolution parameter for Leiden algorithm (default: 0.7)
  --leiden-beta - beta parameter for Leiden algorithm (default: 0.01)
  --leiden-iterations - number of interations for Leiden algorithm (default: 2)
```

