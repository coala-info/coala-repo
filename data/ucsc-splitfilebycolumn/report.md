# ucsc-splitfilebycolumn CWL Generation Report

## ucsc-splitfilebycolumn_splitFileByColumn

### Tool Description
Split text input into files named by column value

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-splitfilebycolumn:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-splitfilebycolumn/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-splitfilebycolumn/overview
- **Total Downloads**: 30.7K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
splitFileByColumn - Split text input into files named by column value
usage:
   splitFileByColumn source outDir
options:
   -col=N      - Use the Nth column value (default: N=1, first column)
   -head=file  - Put head in front of each output
   -tail=file  - Put tail at end of each output
   -chromDirs  - Split into subdirs of outDir that are distilled from chrom
                 names, e.g. chr3_random -> outDir/3/chr3_random.XXX .
   -ending=XXX - Use XXX as the dot-suffix of split files (default: taken
                 from source).
   -tab        - Split by tab characters instead of whitespace.
Split source into multiple files in outDir, with each filename determined
by values from a column of whitespace-separated input in source.
If source begins with a header, you should pipe "tail +N source" to this
program where N is number of header lines plus 1, or use some similar
method to strip the header from the input.
```

