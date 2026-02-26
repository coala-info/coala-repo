# prscs CWL Generation Report

## prscs_PRScs.py

### Tool Description
PRS-CS: a polygenic prediction method that infers posterior SNP effect sizes under continuous shrinkage (CS) priors using GWAS summary statistics and an external LD reference panel.

### Metadata
- **Docker Image**: quay.io/biocontainers/prscs:1.1.0--hdfd78af_0
- **Homepage**: https://github.com/getian107/PRScs
- **Package**: https://anaconda.org/channels/bioconda/packages/prscs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/prscs/overview
- **Total Downloads**: 3.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/getian107/PRScs
- **Stars**: N/A
### Original Help Text
```text
PRS-CS: a polygenic prediction method that infers posterior SNP effect sizes under continuous shrinkage (CS) priors
using GWAS summary statistics and an external LD reference panel.

Reference: T Ge, CY Chen, Y Ni, YCA Feng, JW Smoller. Polygenic Prediction via Bayesian Regression and Continuous Shrinkage Priors.
           Nature Communications, 10:1776, 2019.


Usage:
python PRScs.py --ref_dir=PATH_TO_REFERENCE --bim_prefix=VALIDATION_BIM_PREFIX --sst_file=SUM_STATS_FILE --n_gwas=GWAS_SAMPLE_SIZE --out_dir=OUTPUT_DIR
                [--a=PARAM_A --b=PARAM_B --phi=PARAM_PHI --n_iter=MCMC_ITERATIONS --n_burnin=MCMC_BURNIN --thin=MCMC_THINNING_FACTOR
                 --chrom=CHROM --write_psi=WRITE_PSI --seed=SEED]
```

