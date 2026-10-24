# ucsc-bedpileups CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ucsc-bedpileups | PASS |  |

## ucsc-bedpileups

### Tool Description
Create a pileup of BED files, showing the number of features covering each base in the genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-bedpileups:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-bedpileups/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-bedpileups/overview
- **Total Downloads**: 28.6K
- **Last updated**: 2025-06-28
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
bedPileUps - Find (exact) overlaps if any in bed input
usage:
   bedPileUps in.bed
Where in.bed is in one of the ascii bed formats.
The in.bed file must be sorted by chromosome,start,
  to sort a bed file, use the unix sort command:
     sort -k1,1 -k2,2n unsorted.bed > sorted.bed

Options:
  -name - include BED name field 4 when evaluating uniqueness
  -tab  - use tabs to parse fields
  -verbose=2 - show the location and size of each pileUp
```


## Metadata
- **Skill**: generated
