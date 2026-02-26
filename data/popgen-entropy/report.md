# popgen-entropy CWL Generation Report

## popgen-entropy_entropy

### Tool Description
Calculate population genetic entropy

### Metadata
- **Docker Image**: quay.io/biocontainers/popgen-entropy:2.0--h60038e2_5
- **Homepage**: https://bitbucket.org/buerklelab/mixedploidy-entropy/src/master/
- **Package**: https://anaconda.org/channels/bioconda/packages/popgen-entropy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/popgen-entropy/overview
- **Total Downloads**: 8.3K
- **Last updated**: 2025-11-07
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
entropy version 2.0 -- December 2018

Usage:   ./entropy -i infile.mpgl [options]

Required - 
-i Infile with genetic data for the population (.mpgl)
-n Ploidy level for individuals (1, 2, 3, 4, 6)
  (a single number indicating same ploidy for all individuals 
OR Infile with ploidy for each individual on a new line 
OR Infile with ploidy for each individual in a new line and each locus in a new column) 
-m BOOL infile is in genotype likelihood format [default = 1]
-l Number of MCMC steps for the analysis [default = 10000]
-b Discard the first n MCMC samples as a burn-in [default = 5000]
-t Thin MCMC samples by recording every nth value [default = 5]
-k Number of population clusters [default = 2]
-o HDF5 format outfile with .hdf5 suffix [default = mcmcout.hdf5]

Optional - 
-q File with expected starting values for admixture proportions
-Q BOOL estimate intra- and interspecific ancestry and marginal q [default = 0]
-w BOOL Output includes population allele frequencies [default = 0]
-e Probability of sequence error, set to '9' for locus-specific error rates [default = 0] (only required if infile is not in genotype likelihood format)
-s Scalar for Dirichlet init. of q, inversly prop. to variance [default = 1]
-p +/- proposal for ancestral allele frequency [default = 0.1]
-f +/- proposal for Fst [default = 0.01]
-y +/- proposal for gamma [default = 0.2]
-a +/- proposal for alpha [default = 0.1]
-r INT seed for random number generator [default = clock]
-D BOOL flag to calculate DIC or WAIC estimates [default = 0, DIC]
```

