# ucsc-maffrags CWL Generation Report

## ucsc-maffrags_mafFrags

### Tool Description
Collect MAFs from regions specified in a 6 column bed file

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-maffrags:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-maffrags/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-maffrags/overview
- **Total Downloads**: 21.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
mafFrags - Collect MAFs from regions specified in a 6 column bed file
usage:
   mafFrags database track in.bed out.maf
options:
   -orgs=org.txt - File with list of databases/organisms in order
   -bed12 - If set, in.bed is a bed 12 file, including exons
   -thickOnly - Only extract subset between thickStart/thickEnd
   -meFirst - Put native sequence first in maf
   -txStarts - Add MAF txstart region definitions ('r' lines) using BED name
    and output actual reference genome coordinates in MAF.
   -refCoords - output actual reference genome coordinates in MAF.
```

