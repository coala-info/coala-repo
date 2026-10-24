# ucsc-hgfakeagp CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ucsc-hgfakeagp_hgFakeAgp | PASS | Real human chr22 slices with N gaps (nf-core GRCh37 chr22): AGP gap and contig coordinates match an independent N-run calculation, including -minContigGap, -minScaffoldGap and -singleContigs |

## ucsc-hgfakeagp_hgFakeAgp

### Tool Description
Create fake AGP file by looking at N's

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-hgfakeagp:482--h0b57e2e_0
- **Homepage**: http://hgdownload.cse.ucsc.edu/admin/exe/
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-hgfakeagp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-hgfakeagp/overview
- **Total Downloads**: 15.9K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
hgFakeAgp - Create fake AGP file by looking at N's
usage:
   hgFakeAgp input.fa output.agp
options:
   -minContigGap=N Minimum size for a gap between contigs.  Default 25
   -minScaffoldGap=N Min size for a gap between scaffolds. Default 50000
   -singleContigs - when a full sequence has no gaps, maintain contig
	name without adding index extension.
```

