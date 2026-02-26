# combined-pvalues CWL Generation Report

## combined-pvalues_comb-p

### Tool Description
Tools for viewing and adjusting p-values in BED files.

### Metadata
- **Docker Image**: quay.io/biocontainers/combined-pvalues:0.50.6--pyhdfd78af_0
- **Homepage**: https://github.com/brentp/combined-pvalues
- **Package**: https://anaconda.org/channels/bioconda/packages/combined-pvalues/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/combined-pvalues/overview
- **Total Downloads**: 22.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/brentp/combined-pvalues
- **Stars**: N/A
### Original Help Text
```text
Tools for viewing and adjusting p-values in BED files.

   Contact: Brent Pedersen - bpederse@gmail.com
   License: BSD

To run, indicate one of:

   acf       - calculate autocorrelation within BED file
   slk       - Stouffer-Liptak-Kechris correction of correlated p-values
   fdr       - Benjamini-Hochberg correction of p-values
   peaks     - find peaks in a BED file.
   region_p  - generate SLK p-values for a region (of p-values)
   filter    - filter region_p output on size and p and add coef/t
   hist      - plot a histogram of a column and check for uniformity.
   manhattan - a manhattan plot of values in a BED file.
   pipeline  - run acf, slk, fdr, peaks, region_p in succesion

NOTE: most of these assume *sorted* BED files.
SEE: https://github.com/brentp/combined-pvalues for documentation
```

