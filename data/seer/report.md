# seer CWL Generation Report

## seer

### Tool Description
sequence element enrichment analysis

### Metadata
- **Docker Image**: biocontainers/seer:v1.1.4-2b2-deb_cv1
- **Homepage**: https://github.com/johnlees/seer
- **Package**: https://anaconda.org/channels/bioconda/packages/seer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/seer/overview
- **Total Downloads**: 5.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/johnlees/seer
- **Stars**: N/A
### Original Help Text
```text
seer: sequence element enrichment analysis

Required options:
  -k [ --kmers ] arg       dsm kmer output file
  -p [ --pheno ] arg       .pheno metadata

Covariate options:
  --struct arg             mds values from kmds
  --covar_file arg         file containing covariates
  --covar_list arg         list of columns covariates to use. Format is 1,2q,3 
                           (use q for quantitative)

Performance options:
  --threads arg (=1)       number of threads. Suggested: 20

Filtering options:
  --no_filtering           turn off all filtering and perform tests on all 
                           kmers input
  --max_length arg (=100)  maximum kmer length
  --maf arg (=0.01)        minimum kmer frequency
  --min_words arg          minimum kmer occurences. Overrides --maf
  --chisq arg (=10e-5)     p-value threshold for initial chi squared test. Set 
                           to 1 to show all
  --pval arg (=10e-8)      p-value threshold for final logistic test. Set to 1 
                           to show all

Other options:
  --print_samples          print lists of samples significant kmers were found 
                           in
  --version                prints version and exits
  -h [ --help ]            full help message
```


## Metadata
- **Skill**: generated
