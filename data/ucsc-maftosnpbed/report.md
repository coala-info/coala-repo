# ucsc-maftosnpbed CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ucsc-maftosnpbed_mafToSnpBed | Failed | tool bug: on the real LAST MAF it reports matching soft-masked (lowercase vs uppercase) bases as SNPs; the same MAF in uppercase gives no SNPs and a planted SNP is found |

## ucsc-maftosnpbed_mafToSnpBed

### Tool Description
finds SNPs in MAF and builds a bed with their functional consequence

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-maftosnpbed:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-maftosnpbed/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-maftosnpbed/overview
- **Total Downloads**: 24.4K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
mafToSnpBed - finds SNPs in MAF and builds a bed with their functional consequence
usage:
   mafToSnpBed database input.maf input.gp output.bed
options:
   -xxx=XXX
```

