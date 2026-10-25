# ucsc-nettobed CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ucsc-nettobed | PASS | Rewrote CWL (output bed argument, -maxGap, -minFill); real net gives bed lines matching the net fill coordinates, and -maxGap breaks at the 150000 gap. |

## ucsc-nettobed

### Tool Description
Convert net file to bed file

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-nettobed:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-nettobed/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-nettobed/overview
- **Total Downloads**: 30.8K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
Unable to find image 'quay.io/biocontainers/ucsc-nettobed:482--h0b57e2e_0' locally
482--h0b57e2e_0: Pulling from biocontainers/ucsc-nettobed
0cacab098358: Already exists
bd9ddc54bea9: Already exists
b96050bd65a6: Pulling fs layer
b96050bd65a6: Waiting
docker: write /var/lib/docker/tmp/GetImageBlob1326894396: no space left on device

Run 'docker run --help' for more information
```

