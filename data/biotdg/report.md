# biotdg CWL Generation Report

## biotdg

### Tool Description
Bioinformatics Test Data Generator

### Metadata
- **Docker Image**: quay.io/biocontainers/biotdg:0.1.0--py_0
- **Homepage**: https://github.com/biowdl/biotdg
- **Package**: https://anaconda.org/channels/bioconda/packages/biotdg/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biotdg/overview
- **Total Downloads**: 2.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/biowdl/biotdg
- **Stars**: N/A
### Original Help Text
```text
usage: biotdg [-h] [--version] -r REFERENCE --vcf VCF -p PLOIDY_TABLE -s
              SAMPLE_NAME [-z RANDOM_SEED] [-l READ_LENGTH] [-C COVERAGE]
              [-e READ1_ERROR_RATE] [-E READ2_ERROR_RATE]
              [-n MAXIMUM_N_NUMBER] [-o OUTPUT_DIR]

Bioinformatics Test Data Generator

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -r REFERENCE, --reference REFERENCE
                        Reference genome for the sample.
  --vcf VCF             VCF file with mutations.
  -p PLOIDY_TABLE, --ploidy-table PLOIDY_TABLE
                        Tab-delimited file with two columns specifying the
                        chromosome name and its ploidy. By default all
                        chromosomes have a ploidy of 2.
  -s SAMPLE_NAME, --sample-name SAMPLE_NAME
                        Name of the sample to generate. The sample must be in
                        the VCF file.
  -z RANDOM_SEED, --random-seed RANDOM_SEED
                        Random seed for dwgsim (default: 1).
  -l READ_LENGTH, --read-length READ_LENGTH
                        Read length to be used by dwgsim.
  -C COVERAGE, --coverage COVERAGE
                        Average coverage for the generated reads. NOTE: This
                        is multiplied by the ploidy of the chromosome.
  -e READ1_ERROR_RATE, --read1-error-rate READ1_ERROR_RATE
                        Same as -e flag in dwgsim. per base/color/flow error
                        rate of the first read.
  -E READ2_ERROR_RATE, --read2-error-rate READ2_ERROR_RATE
                        Same as -E flag in dwgsim. per base/color/flow error
                        rate of the second read.
  -n MAXIMUM_N_NUMBER, --maximum-n-number MAXIMUM_N_NUMBER
                        Maximum number of Ns allowed in a given read.
  -o OUTPUT_DIR, --output-dir OUTPUT_DIR
```


## Metadata
- **Skill**: generated
