# heinz CWL Generation Report

## heinz

### Tool Description
heinz is a tool for graph analysis and optimization. It supports various formulations for network flow and cut problems, with options for enumeration, preprocessing, and verbosity control.

### Metadata
- **Docker Image**: quay.io/biocontainers/heinz:2.0.1--h503566f_5
- **Homepage**: https://github.com/ls-cwi/heinz
- **Package**: https://anaconda.org/channels/bioconda/packages/heinz/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/heinz/overview
- **Total Downloads**: 11.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ls-cwi/heinz
- **Stars**: N/A
### Original Help Text
```text
Usage:
  heinz [--help|-h|-help] [-FDR num] [-a num] [-e str] [-enum int] [-f int]
     [-lambda num] [-m int] [-maxCuts int] [-n str] [-o str] [-p] [-r str]
     [-s str] [-t int] [-v|--verbosity int] [-version]
Where:
  --help|-h|-help
     Print a short help message
  -FDR num
     Specifies fdr
  -a num
     Specifies a
  -e str
     Edge list file
  -enum int
     Enumeration mode:
     0 - No enumeration
     1 - No root
     2 - Fix root
     3 - No root per component (default)
  -f int
     Formulation of the problem:
     0 - Single Commodity Flow
     1 - Multi Commodity Flow
     2 - Cut formulation (Flow) 
     3 - Cut formulation (Flow-min)
     4 - Cut formulation (Node-separator)
     5 - Cut formulation (Node-separator, BK, default)
     6 - Tree DP
     7 - Tree DP heuristic (fixed_edge)
     8 - Tree DP heuristic (random_edge)
     9 - Tree DP heuristic (uniform_edge)
  -lambda num
     Specifies lambda
  -m int
     Specifies number of threads (default: 1)
  -maxCuts int
     Specifies the maximum number of cuts per step
     (only in conjuction with -f 2, optional, default: -1)
  -n str
     Node file
  -o str
     Output file
  -p
     Enable preprocessing
  -r str
     Specifies the root node (optional)
  -s str
     STP node file
  -t int
     Time limit (in seconds, default: -1)
  -v|--verbosity int
     Specifies the verbosity level:
     0 - No output
     1 - Only necessary output
     2 - More verbose output (default)
     3 - Debug output
  -version
     Show version number
```

