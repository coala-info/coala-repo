# ucsc-chainbridge CWL Generation Report

## ucsc-chainbridge_chainBridge

### Tool Description
Attempt to extend alignments through double-sided gaps of similar size

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-chainbridge:377--h199ee4e_0
- **Homepage**: http://hgdownload.cse.ucsc.edu/admin/exe/
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-chainbridge/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-chainbridge/overview
- **Total Downloads**: 5.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
chainBridge - Attempt to extend alignments through double-sided gaps of similar size
usage:
   chainBridge in.chain target.2bit query.2bit out.chain
options:
   -maxGap=N  Maximum size of double-sided gap to try to bridge (default: 6000)
              Note: there is no size limit for exact sequence matches
   -scoreScheme=fileName Read the scoring matrix from a blastz-format file
   -linearGap=<medium|loose|filename> Specify type of linearGap to use.
              loose is chicken/human linear gap costs.
              medium is mouse/human linear gap costs.
              Or specify a piecewise linearGap tab delimited file.
              (default: loose)
```

