# ucsc-farc CWL Generation Report

## ucsc-farc_faRc

### Tool Description
Reverse complement a FA file

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-farc:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-farc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-farc/overview
- **Total Downloads**: 29.0K
- **Last updated**: 2025-06-30
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
faRc - Reverse complement a FA file
usage:
   faRc in.fa out.fa
In.fa and out.fa may be the same file.
options:
   -keepName - keep name identical (don't prepend RC)
   -keepCase - works well for ACGTUN in either case. bizarre for other letters.
               without it bases are turned to lower, all else to n's
   -justReverse - prepends R unless asked to keep name
   -justComplement - prepends C unless asked to keep name
                     (cannot appear together with -justReverse)
```

