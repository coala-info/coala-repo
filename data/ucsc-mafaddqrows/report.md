# ucsc-mafaddqrows CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ucsc-mafaddqrows_mafAddQRows | Not completed | Needs per-species .qac quality files with a .qdx index for the MAF species; no small real quality set matching a real MAF is available. CWL fixed: quality_files input added. |

## ucsc-mafaddqrows_mafAddQRows

### Tool Description
Add quality data to a maf

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-mafaddqrows:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-mafaddqrows/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-mafaddqrows/overview
- **Total Downloads**: 24.0K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
mafAddQRows - Add quality data to a maf
usage:
   mafAddQRows species.lst in.maf out.maf
where each species.lst line contains two fields
   1) species name
   2) directory where the .qac and .qdx files are located
options:
  -divisor=n is value to divide Q value by.  Default is 5.
```

