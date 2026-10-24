# ucsc-bedweedoverlapping CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ucsc-bedweedoverlapping | PASS |  |

## ucsc-bedweedoverlapping

### Tool Description
Filter out beds that overlap a 'weed.bed' file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-bedweedoverlapping:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-bedweedoverlapping/overview
- **Validation**: PASS

### Original Help Text
```text
bedWeedOverlapping - Filter out beds that overlap a 'weed.bed' file.
usage:
   bedWeedOverlapping weeds.bed input.bed output.bed
options:
   -maxOverlap=0.N - maximum overlapping ratio, default 0 (any overlap)
   -invert - keep the overlapping and get rid of everything else
```

## Metadata
- **Skill**: generated

