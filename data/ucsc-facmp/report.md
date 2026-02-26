# ucsc-facmp CWL Generation Report

## ucsc-facmp_faCmp

### Tool Description
Compare two .fa files

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-facmp:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-facmp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-facmp/overview
- **Total Downloads**: 24.0K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
faCmp - Compare two .fa files
usage:
   faCmp [options] a.fa b.fa
options:
    -softMask - use the soft masking information during the compare
                Differences will be noted if the masking is different.
    -sortName - sort input files by name before comparing
    -peptide - read as peptide sequences
default:
    no masking information is used during compare.  It is as if both
    sequences were not masked.

Exit codes:
   - 0 if files are the same
   - 1 if files differ
   - 255 on an error
```

