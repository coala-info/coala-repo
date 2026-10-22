# scnic CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| scnic_between | PASS |  |
| scnic_modules | PASS |  |
| scnic_within | PASS |  |

## scnic_within

### Tool Description
Find pairwise correlations within a table

### Metadata
- **Docker Image**: quay.io/biocontainers/scnic:0.6.6--pyhdfd78af_0
- **Homepage**: https://github.com/lozuponelab/SCNIC
- **Package**: https://anaconda.org/channels/bioconda/packages/scnic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SCNIC_analysis.py within [-h] -i INPUT_LOC [-o OUTPUT_LOC]
                                [-m CORREL_METHOD] [-a P_ADJUST]
                                [-s MIN_SAMPLE] [--procs PROCS]
                                [--sparcc_filter] [--sparcc_p SPARCC_P]
                                [--verbose]

options:
  -h, --help            show this help message and exit
  -i INPUT_LOC, --input_loc INPUT_LOC
                        location of input biom file (default: None)
  -o OUTPUT_LOC, --output_loc OUTPUT_LOC
                        output directory (default: None)
  -m CORREL_METHOD, --correl_method CORREL_METHOD
                        correlation method (default: sparcc)
  -a P_ADJUST, --p_adjust P_ADJUST
                        p-value adjustment (default: fdr_bh)
  -s MIN_SAMPLE, --min_sample MIN_SAMPLE
                        minimum number of samples present in (default: None)
  --procs PROCS         number of processors to use (default: 1)
  --sparcc_filter       filter as described in SparCC paper (default: False)
  --sparcc_p SPARCC_P   Calculate p-value for sparCC R value, give number of
                        bootstraps (default: None)
  --verbose             give verbose messages to STDOUT (default: False)
```

## scnic_modules

### Tool Description
Make modules on a network

### Metadata
- **Docker Image**: quay.io/biocontainers/scnic:0.6.6--pyhdfd78af_0
- **Homepage**: https://github.com/lozuponelab/SCNIC
- **Package**: https://anaconda.org/channels/bioconda/packages/scnic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SCNIC_analysis.py modules [-h] -i INPUT_LOC [-o OUTPUT_LOC]
                                 [--max_p MAX_P] [--min_r MIN_R]
                                 [--method METHOD] [-k K_SIZE] [-g GAMMA]
                                 [--table_loc TABLE_LOC] [--prefix PREFIX]
                                 [-v]

options:
  -h, --help            show this help message and exit
  -i INPUT_LOC, --input_loc INPUT_LOC
                        location of output from SCNIC_analysis.py within
                        (default: None)
  -o OUTPUT_LOC, --output_loc OUTPUT_LOC
                        output directory (default: None)
  --max_p MAX_P         maximum p-value to determine edges, p must have been
                        calculated (default: None)
  --min_r MIN_R         minimum correlation value to determine edges (default:
                        None)
  --method METHOD       method to be used for determining modules, pick from:
                        naive, k_cliques or louvain (default: naive)
  -k K_SIZE, --k_size K_SIZE
                        k value for use with the k-clique communities
                        algorithm (default: 3)
  -g GAMMA, --gamma GAMMA
                        gamma value for use with louvain modularity
                        maximization, between 0 and 1 where 0 makes small
                        modules and 1 large modules (default: 0.1)
  --table_loc TABLE_LOC
                        biom table used to make network to be collapsed
                        (default: None)
  --prefix PREFIX       prefix for module names in collapsed file (default:
                        module)
  -v, --verbose         give verbose messages to STDOUT (default: False)
```

## scnic_between

### Tool Description
Find correlations between two tables

### Metadata
- **Docker Image**: quay.io/biocontainers/scnic:0.6.6--pyhdfd78af_0
- **Homepage**: https://github.com/lozuponelab/SCNIC
- **Package**: https://anaconda.org/channels/bioconda/packages/scnic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SCNIC_analysis.py between [-h] -1 TABLE1 -2 TABLE2 [-o OUTPUT_LOC]
                                 [-m CORREL_METHOD] [-a P_ADJUST]
                                 [-s MIN_SAMPLE] [--max_p MAX_P]
                                 [--min_r MIN_R] [--sparcc_filter]
                                 [--procs PROCS] [-f]

options:
  -h, --help            show this help message and exit
  -1 TABLE1, --table1 TABLE1
                        table to be correlated (default: None)
  -2 TABLE2, --table2 TABLE2
                        second table to be correlated (default: None)
  -o OUTPUT_LOC, --output_loc OUTPUT_LOC
                        output file location (default: None)
  -m CORREL_METHOD, --correl_method CORREL_METHOD
                        correlation method (default: spearman)
  -a P_ADJUST, --p_adjust P_ADJUST
                        p-value adjustment (default: fdr_bh)
  -s MIN_SAMPLE, --min_sample MIN_SAMPLE
                        minimum number of samples present in (default: None)
  --max_p MAX_P         max p-value to determine edges (default: None)
  --min_r MIN_R         minimum R to determine edges (default: None)
  --sparcc_filter       filter using parameters from SparCC publication
                        (default: False)
  --procs PROCS         number of processors to use (default: 1)
  -f, --force           force overwrite output folder if it already exists
                        (default: False)
```

