# ucsc-bedgeneparts CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ucsc-bedgeneparts | PASS |  |

## ucsc-bedgeneparts

### Tool Description
Extract parts of genes (promoters, exons, introns, etc.) from BED files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-bedgeneparts:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-bedgeneparts/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-bedgeneparts/overview
- **Total Downloads**: 26.7K
- **Last updated**: 2025-06-28
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
bedGeneParts - Given a bed, spit out promoter, first exon, or all introns.
usage:
   bedGeneParts part in.bed out.bed
Where part is either 'exons' or 'firstExon' or 'introns' or 'promoter' or 'firstCodingSplice'
or 'secondCodingSplice'
options:
   -proStart=NN - start of promoter relative to txStart, default -100
   -proEnd=NN - end of promoter relative to txStart, default 50
```


## Metadata
- **Skill**: generated
