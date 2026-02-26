# desman CWL Generation Report

## desman

### Tool Description
DESMAN (Diploid Evolutionary Signature Model ANalysis) is a tool for inferring haplotype frequencies from SNP data.

### Metadata
- **Docker Image**: quay.io/biocontainers/desman:2.1--py39h4747326_10
- **Homepage**: https://github.com/chrisquince/DESMAN
- **Package**: https://anaconda.org/channels/bioconda/packages/desman/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/desman/overview
- **Total Downloads**: 13.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/chrisquince/DESMAN
- **Stars**: N/A
### Original Help Text
```text
usage: desman [-h] -g GENOMES [-f [FILTER_VARIANTS]] [-r [RANDOM_SELECT]]
              [-e ETA_FILE] [-a ASSIGN_FILE] [-o OUTPUT_DIR] [-p OPTIMISEP]
              [-i [NO_ITER]] [-m MIN_COVERAGE] [-q MAX_QVALUE]
              [-s RANDOM_SEED] [-v [MIN_VARIANT_FREQ]]
              variant_file

positional arguments:
  variant_file          input SNP frequencies

optional arguments:
  -h, --help            show this help message and exit
  -g GENOMES, --genomes GENOMES
                        specify the haplotype number
  -f [FILTER_VARIANTS], --filter_variants [FILTER_VARIANTS]
                        filters variants by negative binomial loge likelihood
                        defaults to 3.84
  -r [RANDOM_SELECT], --random_select [RANDOM_SELECT]
                        selects subset of variants passing filter to build
                        model and assigns others
  -e ETA_FILE, --eta_file ETA_FILE
                        reads initial eta matrix from file
  -a ASSIGN_FILE, --assign_file ASSIGN_FILE
                        calculates haplotype profiles for these SNPs using
                        fitted gamma, eta values
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        string specifying output directory and file stubs
  -p OPTIMISEP, --optimiseP OPTIMISEP
                        optimise proportions in likelihood ratio test
  -i [NO_ITER], --no_iter [NO_ITER]
                        Number of iterations of Gibbs sampler
  -m MIN_COVERAGE, --min_coverage MIN_COVERAGE
                        minimum coverage for sample to be included
  -q MAX_QVALUE, --max_qvalue MAX_QVALUE
                        specifies q value cut-off for variant detection
                        defaults 1.0e-3
  -s RANDOM_SEED, --random_seed RANDOM_SEED
                        specifies seed for numpy random number generator
                        defaults to 23724839 applied after random filtering
  -v [MIN_VARIANT_FREQ], --min_variant_freq [MIN_VARIANT_FREQ]
                        specifies minimum variant frequency defaults 0.01
```

