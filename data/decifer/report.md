# decifer CWL Generation Report

## decifer

### Tool Description
DeCiFer.

### Metadata
- **Docker Image**: quay.io/biocontainers/decifer:2.1.4--py312hf731ba3_4
- **Homepage**: https://github.com/raphael-group/decifer
- **Package**: https://anaconda.org/channels/bioconda/packages/decifer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/decifer/overview
- **Total Downloads**: 59.9K
- **Last updated**: 2025-09-21
- **GitHub**: https://github.com/raphael-group/decifer
- **Stars**: N/A
### Original Help Text
```text
usage: decifer [-h] -p PURITYFILE [--betabinomial] [-i SNPFILE] [-s SEGFILE]
               [-v SENSITIVITY] [-R RESTARTS_BB] [-x SKIP] [--ccf] [-k MINK]
               [-K MAXK] [-r RESTARTS] [-t MAXIT] [-e ELBOW] [--binarysearch]
               [--record] [-j JOBS] [-o OUTPUT] [--statetrees STATETREES]
               [--seed SEED] [--debug] [--printallk] [--conservativeCIs]
               [--vafdevfilter VAFDEVFILTER] [--silhouette]
               INPUT

DeCiFer.

positional arguments:
  INPUT                 Input file in DeCiFer format.

options:
  -h, --help            show this help message and exit
  -p PURITYFILE, --purityfile PURITYFILE
                        File with purity of each sample (TSV file in two
                        columns`SAMPLE PURITY`)
  --betabinomial        Use betabinomial likelihood to cluster mutations
                        (default: binomial)
  -i SNPFILE, --snpfile SNPFILE
                        File with precisions for betabinomial fit (default:
                        binomial likelihood)
  -s SEGFILE, --segfile SEGFILE
                        File with precisions for betabinomial fit (default:
                        binomial likelihood)
  -v SENSITIVITY, --sensitivity SENSITIVITY
                        Sensitivity E to exclude SNPs with 0.5 - E <= BAF <
                        0.5, for estimating betabinomial parameters (default:
                        0.1)
  -R RESTARTS_BB, --restarts_bb RESTARTS_BB
                        Maximum size of brute-force search, when fitting
                        betabinomial parameters (default: 1e4)
  -x SKIP, --skip SKIP  Numbers to skip in the brute-force search, when
                        fitting betabinomial parameters (default: 10)
  --ccf                 Run with CCF instead of DCF (default: False)
  -k MINK, --mink MINK  Minimum number of clusters, which must be at least 2
                        (default: 2)
  -K MAXK, --maxk MAXK  Maximum number of clusters (default: 12)
  -r RESTARTS, --restarts RESTARTS
                        Number of restarts (default: 20)
  -t MAXIT, --maxit MAXIT
                        Maximum number of iterations per restart (default:
                        200)
  -e ELBOW, --elbow ELBOW
                        Elbow sensitivity, lower values increase sensitivity
                        (default: 0.06)
  --binarysearch        Use binary-search model selection (default: False,
                        iterative is used; use binary search when considering
                        large numbers of clusters
  --record              Record objectives (default: False)
  -j JOBS, --jobs JOBS  Number of parallele jobs to use (default: equal to
                        number of available processors)
  -o OUTPUT, --output OUTPUT
                        Output prefix (default: ./decifer)
  --statetrees STATETREES
                        Filename of state-trees file (default: use
                        state_trees.txt in the package)
  --seed SEED           Random-generator seed (default: None)
  --debug               single-threaded mode for development/debugging
  --printallk           Print all results for each value of K explored by
                        DeCiFer
  --conservativeCIs     Beta: compute CIs using DCF point values assigned to
                        cluster instead of cluster likelihood function
  --vafdevfilter VAFDEVFILTER
                        Filter poorly fit SNVs with VAFs that are more than
                        this number of standard deviations away from the
                        cluster center VAF (default 1.5)
  --silhouette          Beta: select the number of clusters using a silhouette
                        score
```

