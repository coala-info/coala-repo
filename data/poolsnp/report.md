# poolsnp CWL Generation Report

## poolsnp_PoolSNP.sh

### Tool Description
PoolSNP v. 1.05 - 13/11/2017

### Metadata
- **Docker Image**: quay.io/biocontainers/poolsnp:1.0.1--py312h7e72e81_0
- **Homepage**: https://github.com/capoony/PoolSNP
- **Package**: https://anaconda.org/channels/bioconda/packages/poolsnp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/poolsnp/overview
- **Total Downloads**: 1.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/capoony/PoolSNP
- **Stars**: N/A
### Original Help Text
```text
Test if GNU parallel installed
*********************

done


********************************
************ HELP **************
********************************


PoolSNP v. 1.05 - 13/11/2017

A typcial command line looks like this:

sh ~/PoolSNP.sh \
  mpileup=~/input.mpileup \       ## The input mpileup
output=~/output \               ## The output prefix
reference=~/reference.fa \      ## The reference FASTA file
names=sample1,sample2,sample3 \ ## A comma separated list of samples names according to the order in the mpileup file
min-cov=10 \                    ## sample-wise minimum coverage
max-cov=0.95 \                    ## Either the maximum coverage percentile to be computed or an input file
min-count=20 \                  ## minimum alternative allele count across all populations pooled
min-freq=0.001 \                ## minimum alternative allele frequency across all populations pooled
miss-frac=0.1 \                 ## maximum allowed fraction of samples not fullfilling all parameters
base-quality 15 \               ## minimum base quality for every nucleotide
jobs=10                         ## number of parallel jobs/cores used for the SNP calling

Please see below, which parameter is missing:
*******************************
\nmpileup=~/input.mpileup is missing: The full path to the input mpileup needs to be specified
```

