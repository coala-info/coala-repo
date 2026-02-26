# ucsc-twobitmask CWL Generation Report

## ucsc-twobitmask_twoBitMask

### Tool Description
apply masking to a .2bit file, creating a new .2bit file

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-twobitmask:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-twobitmask/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-twobitmask/overview
- **Total Downloads**: 35.0K
- **Last updated**: 2025-06-27
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
twoBitMask - apply masking to a .2bit file, creating a new .2bit file
usage:
   twoBitMask input.2bit maskFile output.2bit
options:
   -add   Don't remove pre-existing masking before applying maskFile.
   -type=.XXX   Type of maskFile is XXX (bed or out).
maskFile can be a RepeatMasker .out file or a .bed file.  It must not
contain rows for sequences which are not in input.2bit.
```

