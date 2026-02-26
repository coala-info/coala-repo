# divvier CWL Generation Report

## divvier

### Tool Description
a program for MSA processing

### Metadata
- **Docker Image**: quay.io/biocontainers/divvier:1.01--h5ca1c30_5
- **Homepage**: https://github.com/simonwhelan/Divvier
- **Package**: https://anaconda.org/channels/bioconda/packages/divvier/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/divvier/overview
- **Total Downloads**: 10.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/simonwhelan/Divvier
- **Stars**: N/A
### Original Help Text
```text
========================================================================
    Divvier (1.01 (release)): a program for MSA processing by Simon Whelan
========================================================================

./divvier [options] input_file 

Clustering options:
	-divvy       : do standard divvying (DEFAULT)
	-partial     : do partial filtering by testing removal of individual characters
	-thresh X    : set the threshold for divvying to X (DEFAULT divvying = 0.801; partial = 0.774)

Approximation options: 
	-approx X    : minimum number of characters tested in a split during divvying (DEFAULT X = 10)
	-checksplits : go through sequence and ensure there's a pair for every split. Can be slow
	-HMMapprox   : Do the pairHMM bounding approximation (DEFAULT)
	-HMMexact    : Do the full pairHMM and ignore bounding

Output options: 
	-mincol X    : Minimum number of characters in a column to output when divvying/filtering (DEFAULT X = 2)
	-divvygap    : Output a gap instead of the static * character so divvied MSAs can be used in phylogeny program
```

