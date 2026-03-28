# mcscanx CWL Generation Report

## mcscanx_MCScanX

### Tool Description
MCScanX prefix_fn [options]

### Metadata
- **Docker Image**: quay.io/biocontainers/mcscanx:1.0.0--h9948957_0
- **Homepage**: https://github.com/wyp1125/MCScanX
- **Package**: https://anaconda.org/channels/bioconda/packages/mcscanx/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mcscanx/overview
- **Total Downloads**: 2.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/wyp1125/MCScanX
- **Stars**: N/A
### Original Help Text
```text
[Usage] MCScanX prefix_fn [options]
 -k  MATCH_SCORE, final score=MATCH_SCORE+NUM_GAPS*GAP_PENALTY
     (default: 50)
 -g  GAP_PENALTY, gap penalty (default: -1)
 -s  MATCH_SIZE, number of genes required to call a collinear block
     (default: 5)
 -e  E_VALUE, alignment significance (default: 1e-05)
 -m  MAX_GAPS, maximum gaps allowed (default: 25)
 -w  OVERLAP_WINDOW, maximum distance (# of genes) to collapse BLAST matches (default: 5)
 -a  only builds the pairwise blocks (.collinearity file)
 -b  patterns of collinear blocks. 0:intra- and inter-species (default); 1:intra-species; 2:inter-species
 -h  print this help page
```


## mcscanx_MCScanX_h

### Tool Description
MCScanX_h prefix_fn [options]

### Metadata
- **Docker Image**: quay.io/biocontainers/mcscanx:1.0.0--h9948957_0
- **Homepage**: https://github.com/wyp1125/MCScanX
- **Package**: https://anaconda.org/channels/bioconda/packages/mcscanx/overview
- **Validation**: PASS

### Original Help Text
```text
[Usage] MCScanX_h prefix_fn [options]
 -k  MATCH_SCORE, final score=MATCH_SCORE+NUM_GAPS*GAP_PENALTY
     (default: 50)
 -g  GAP_PENALTY, gap penalty (default: -1)
 -s  MATCH_SIZE, number of genes required to call collinear blocks
     (default: 5)
 -e  E_VALUE, alignment significance (default: 1e-05)
 -m  MAX_GAPS, maximum gaps allowed (default: 25)
 -w  OVERLAP_WINDOW, maximum distance (# of genes) to collapse BLAST matches (default: 5)
 -a  only builds the pairwise blocks (.collinearity file)
 -b  patterns of collinear blocks. 0:intra- and inter-species (default); 1:intra-species; 2:inter-species
 -c  whether to consider homology scores. 0:not consider (default); 1: lower preferred; 2: higher preferred
 -h  print this help page
```


## Metadata
- **Skill**: generated
