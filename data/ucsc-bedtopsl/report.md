# ucsc-bedtopsl CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ucsc-bedtopsl | Failed | tool bug: the main mode matches the tool's expected output, but with -keepQuery the PSL matches column is the chromosome size (40001) instead of the block total (617). |

## ucsc-bedtopsl

### Tool Description
Convert BED format to PSL format.

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-bedtopsl:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-bedtopsl/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-bedtopsl/overview
- **Total Downloads**: 29.7K
- **Last updated**: 2025-06-28
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
bedToPsl - convert bed format files to psl format
usage:
   bedToPsl [options] chromSizes bedFile pslFile

Convert a BED file to a PSL file. This the result is an alignment.
 It is intended to allow processing by tools that operate on PSL.
If the BED has at least 12 columns, then a PSL with blocks is created.
Otherwise single-exon PSLs are created.

Options:
-tabs        -  use tab as a separator
-keepQuery   -  instead of creating a fake query, create PSL with identical query and
                target specs. Useful if bed features are to be lifted with pslMap and one 
                wants to keep the source location in the lift result.
```

## Metadata
- **Skill**: generated

