# fgwas CWL Generation Report

## fgwas

### Tool Description
fgwas v. 0.3.6
by Joe Pickrell (jkpickrell@nygenome.org)

### Metadata
- **Docker Image**: quay.io/biocontainers/fgwas:0.3.6--ha172671_9
- **Homepage**: https://github.com/joepickrell/fgwas
- **Package**: https://anaconda.org/channels/bioconda/packages/fgwas/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fgwas/overview
- **Total Downloads**: 7.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/joepickrell/fgwas
- **Stars**: N/A
### Original Help Text
```text
fgwas v. 0.3.6
by Joe Pickrell (jkpickrell@nygenome.org)

-i [file name] input file w/ Z-scores
-o [string] stem for names of output files
-w [string] which annotation(s) to use. Separate multiple annotations with plus signs
-dists [string:string] the name of the distance annotation(s) and the file(s) containing the distance model(s)
-k [integer] block size in number of SNPs (5000)
-bed [string] read block positions from a .bed file
-v [float] variance of prior on normalized effect size. To average priors, separate with commas (0.01,0.1,0.5)
-p [float] penalty on sum of squared lambdas, only relevant for -print (0.2)
-print print the per-SNP output
-xv do 10-fold cross-validation
-dens [string float float] model segment probability according to quantiles of an annotation
-cc this is a case-control study, which implies a different input file format
-fine this is a fine mapping study, which implies a different input file format
-onlyp only do optimization under penalized likelihood
-cond [string] estimate the effect size of an annotation conditional on the others in the model
```

