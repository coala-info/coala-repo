# apoc CWL Generation Report

## apoc

### Tool Description
Large-scale structural alignment and comparison of protein pockets

### Metadata
- **Docker Image**: quay.io/biocontainers/apoc:1b16--0
- **Homepage**: http://cssb.biology.gatech.edu/APoc
- **Package**: https://anaconda.org/channels/bioconda/packages/apoc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/apoc/overview
- **Total Downloads**: 7.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: apoc <options> pdbfile1 pdbfile2 

Options:
Input options
 -fa <num>
    Global structure alignment: 1 - enable (default), 0 - disable.
 -lt <file>
    Provide a list of templates to compare in a file.
 -lq <file>
    Provide a list of queries (targets) to compare in a file.
 -pt <str1,str2,...>
    Names of pockets in the first (template) structure for comparison.
 -pq <str1,str2,...>
    Names of pockets in the second (query) structure for comparison.
 -block <file>
    Load a block of concatenated pdb files.
 -pvol <num>
    Minimal pocket volume in grid points. Default 100
 -plen <num>
    Minimal number of pocket residues. Default 10

Alignment options
 -sod
    Restrict to sequence-order-dependent alignment. Default no restriction.
 -v
    Alignment printout: 0 - none, 1 - concise, 2 - detailed (default).

Scoring options
 -m <str>
    Similarity scoring metric:  tm (TM-score), ps (PS-score, default).
 -L <num>
    Normalize the score with a fixed length specified by num.
 -a
    Normalize the score by the average size of two structures.
 -b
    Normalize the score by the minimum size of two structures.
 -c
    Normalize the score by the maximum size of two structures.
```


## Metadata
- **Skill**: generated
