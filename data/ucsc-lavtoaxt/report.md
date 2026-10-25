# ucsc-lavtoaxt CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ucsc-lavtoaxt | PASS |  |

## ucsc-lavtoaxt

### Tool Description
Convert lav format to axt format. targetDir and queryDir can be either a directory of .fa files or a single .2bit file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-lavtoaxt:482--h0b57e2e_0
- **Homepage**: http://hgdownload.cse.ucsc.edu/admin/exe/
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-lavtoaxt/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-lavtoaxt/overview
- **Total Downloads**: 18.3K
- **Last updated**: 2025-06-28
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
lavToAxt - Convert blastz lav file to an axt file (which includes sequence)
usage:
   lavToAxt in.lav tNibDir qNibDir out.axt
Where tNibDir/qNibDir are either directories full of nib files, or a single
twoBit file
options:
   -fa  qNibDir is interpreted as a fasta file of multiple dna seq instead of directory of nibs
   -tfa tNibDir is interpreted as a fasta file of multiple dna seq instead of directory of nibs
   -dropSelf  drops alignment blocks on the diagonal for self alignments
   -scoreScheme=fileName Read the scoring matrix from a blastz-format file.
                (only used in conjunction with -dropSelf, to rescore 
                alignments when blocks are dropped)
```

