# ucsc-pslhisto CWL Generation Report

## ucsc-pslhisto_pslHisto

### Tool Description
Collect counts on PSL alignments for making histograms.

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-pslhisto:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-pslhisto/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-pslhisto/overview
- **Total Downloads**: 33.0K
- **Last updated**: 2025-06-28
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
pslHisto - Collect counts on PSL alignments for making histograms.
usage:
    pslHisto [options] what inPsl outHisto

Collect counts on PSL alignments for making histograms. These
then be analyzed with R, textHistogram, etc.

The 'what' argument determines what data to collect, the following
are currently supported:

  o alignsPerQuery - number of alignments per query. Output is one
    line per query with the number of alignments.

  o coverSpread - difference between the highest and lowest coverage
    for alignments of a query.  Output line per query, with the difference.
    Only includes queries with multiple alignments

  o idSpread - difference between the highest and lowest fraction identity
    for alignments of a query.  Output line per query, with the difference.

Options:
   -multiOnly - omit queries with only one alignment from output.
   -nonZero - omit queries with zero values.
```

