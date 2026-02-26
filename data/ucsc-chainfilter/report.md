# ucsc-chainfilter CWL Generation Report

## ucsc-chainfilter_chainFilter

### Tool Description
Filter chain files. Output goes to standard out.

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-chainfilter:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-chainfilter/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-chainfilter/overview
- **Total Downloads**: 29.5K
- **Last updated**: 2025-06-28
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
chainFilter - Filter chain files.  Output goes to standard out.
usage:
   chainFilter file(s)
options:
   -q=chr1,chr2 - restrict query side sequence to those named
   -notQ=chr1,chr2 - restrict query side sequence to those not named
   -t=chr1,chr2 - restrict target side sequence to those named
   -notT=chr1,chr2 - restrict target side sequence to those not named
   -id=N - only get one with ID number matching N
   -minScore=N - restrict to those scoring at least N
   -maxScore=N - restrict to those scoring less than N
   -qStartMin=N - restrict to those with qStart at least N
   -qStartMax=N - restrict to those with qStart less than N
   -qEndMin=N - restrict to those with qEnd at least N
   -qEndMax=N - restrict to those with qEnd less than N
   -tStartMin=N - restrict to those with tStart at least N
   -tStartMax=N - restrict to those with tStart less than N
   -tEndMin=N - restrict to those with tEnd at least N
   -tEndMax=N - restrict to those with tEnd less than N
   -qOverlapStart=N - restrict to those where the query overlaps a region starting here
   -qOverlapEnd=N - restrict to those where the query overlaps a region ending here
   -tOverlapStart=N - restrict to those where the target overlaps a region starting here
   -tOverlapEnd=N - restrict to those where the target overlaps a region ending here
   -strand=?    -restrict strand (to + or -)
   -long        -output in long format
   -zeroGap     -get rid of gaps of length zero
   -minGapless=N - pass those with minimum gapless block of at least N
   -qMinGap=N     - pass those with minimum gap size of at least N
   -tMinGap=N     - pass those with minimum gap size of at least N
   -qMaxGap=N     - pass those with maximum gap size no larger than N
   -tMaxGap=N     - pass those with maximum gap size no larger than N
   -qMinSize=N    - minimum size of spanned query region
   -qMaxSize=N    - maximum size of spanned query region
   -tMinSize=N    - minimum size of spanned target region
   -tMaxSize=N    - maximum size of spanned target region
   -noRandom      - suppress chains involving '_random' chromosomes
   -noHap         - suppress chains involving '_hap|_alt' chromosomes
```

