# phiercc CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| phiercc_HCCeval | Failed | tool bug: HCCeval aborts with double free or corruption in the pairwise distance step and then hangs (tried 60 and 400 STs from the example profile) |
| phiercc_pHierCC | PASS | Yersinia cgMLST example (2999 STs): HierCC table with HC0 to HC1553 levels written; --append run crashes inside the tool (could not broadcast input array), the main mode works |

## phiercc_pHierCC

### Tool Description
pHierCC takes a file containing allelic profiles (as in https://pubmlst.org/data/) and works out hierarchical clusters of the full dataset based on a minimum-spanning tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/phiercc:1.24--pyhdfd78af_0
- **Homepage**: https://github.com/zheminzhou/pHierCC
- **Package**: https://anaconda.org/channels/bioconda/packages/phiercc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phiercc/overview
- **Total Downloads**: 1.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/zheminzhou/pHierCC
- **Stars**: N/A
### Original Help Text
```text
Usage: pHierCC [OPTIONS]

  pHierCC takes a file containing allelic profiles (as in
  https://pubmlst.org/data/) and works out hierarchical clusters of the full
  dataset based on a minimum-spanning tree.

Options:
  -p, --profile TEXT           [INPUT] name of a profile file consisting of a
                               table of columns of the ST numbers and the
                               allelic numbers, separated by tabs. Can be
                               GZIPped.  [required]
  -o, --output TEXT            [OUTPUT] Prefix for the output files consisting
                               of a  NUMPY and a TEXT version of the
                               clustering result.   [required]
  -a, --append TEXT            [INPUT; optional] The NPZ output of a previous
                               pHierCC run (Default: None).
  -m, --allowed_missing FLOAT  [INPUT; optional] Allowed proportion of missing
                               genes in pairwise comparisons (Default: 0.03).
  -n, --n_proc INTEGER         [INPUT; optional] Number of processes (CPUs) to
                               use (Default: 4).
  --help                       Show this message and exit.
```

## phiercc_HCCeval

### Tool Description
evalHCC evaluates a HierCC scheme using varied statistic summaries.

### Metadata
- **Docker Image**: quay.io/biocontainers/phiercc:1.24--pyhdfd78af_0
- **Homepage**: https://github.com/zheminzhou/pHierCC
- **Package**: https://anaconda.org/channels/bioconda/packages/phiercc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: HCCeval [OPTIONS]

  evalHCC evaluates a HierCC scheme using varied statistic summaries.

Options:
  -p, --profile TEXT      [INPUT] Name of a profile file consisting of a table
                          of columns of the ST numbers and the allelic
                          numbers, separated by tabs. Can be GZIPped.
                          [required]
  -c, --cluster TEXT      [INPUT] Name of the pHierCC text output. Can be
                          GZIPped.  [required]
  -o, --output TEXT       [OUTPUT] Prefix for the two output files.
                          [required]
  -s, --stepwise INTEGER  [INPUT; optional] Evaluate every <stepwise> levels
                          (Default: 10).
  -n, --n_proc INTEGER    [INPUT; optional] Number of processes (CPUs) to use
                          (Default: 4).
  --help                  Show this message and exit.
```

