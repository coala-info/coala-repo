# hlama CWL Generation Report

## hlama

### Tool Description
HLA-typing based HTS sample matching

### Metadata
- **Docker Image**: quay.io/biocontainers/hlama:3.0.1--py35_0
- **Homepage**: https://github.com/bihealth/hlama
- **Package**: https://anaconda.org/channels/bioconda/packages/hlama/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hlama/overview
- **Total Downloads**: 17.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/hlama
- **Stars**: N/A
### Original Help Text
```text
usage: hlama [-h] (--tumor-normal TUMOR_NORMAL | --pedigree PEDIGREE)
             [--config CONFIG] [--work-dir WORK_DIR]
             [--reads-base-dir READS_BASE_DIRS] [--dont-run-snakemake]
             [--disable-checks] [--num-threads NUM_THREADS]

HLA-typing based HTS sample matching

optional arguments:
  -h, --help            show this help message and exit
  --tumor-normal TUMOR_NORMAL
                        Path to tumor/normal TSV file, starts tumor/normal
                        mode
  --pedigree PEDIGREE   Path to pedigree file, starts pedigree mode
  --config CONFIG       Optional explicit path to configuration file, by
                        default ~/.hlama.cfg is searched for
  --work-dir WORK_DIR   Directory to create the Snakefile in
  --reads-base-dir READS_BASE_DIRS
                        Base directory for reads, give multiple times for
                        multiple places to search
  --dont-run-snakemake  Only create Snakefile but do not run Snakemake yet
  --disable-checks      Disable input checks
  --num-threads NUM_THREADS
                        Number of threads to use for read mapping, defaults to
                        1
```

