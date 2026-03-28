# humanfilt CWL Generation Report

## humanfilt_setup

### Tool Description
Setup humanfilt references.

### Metadata
- **Docker Image**: quay.io/biocontainers/humanfilt:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/jprehn-lab/humanfilt
- **Package**: https://anaconda.org/channels/bioconda/packages/humanfilt/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/humanfilt/overview
- **Total Downloads**: 111
- **Last updated**: 2025-10-08
- **GitHub**: https://github.com/jprehn-lab/humanfilt
- **Stars**: N/A
### Original Help Text
```text
usage: humanfilt setup [-h] [--data-dir DATA_DIR] [--threads THREADS]
                       [--force]

options:
  -h, --help           show this help message and exit
  --data-dir DATA_DIR  Destination directory for references (default: user
                       cache)
  --threads THREADS
  --force
```


## humanfilt_run

### Tool Description
Run humanfilt

### Metadata
- **Docker Image**: quay.io/biocontainers/humanfilt:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/jprehn-lab/humanfilt
- **Package**: https://anaconda.org/channels/bioconda/packages/humanfilt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: humanfilt run [-h] --mode {wgs,rna-seq} --input INPUT --output OUTPUT
                     --report REPORT [--threads THREADS]
                     [--trim-quality TRIM_QUALITY] [--trim-length TRIM_LENGTH]
                     [--data-dir DATA_DIR] [--kraken2-db KRAKEN2_DB]
                     [--no-auto-setup] [--keep-temp]

options:
  -h, --help            show this help message and exit
  --mode {wgs,rna-seq}
  --input INPUT
  --output OUTPUT
  --report REPORT
  --threads THREADS
  --trim-quality TRIM_QUALITY
  --trim-length TRIM_LENGTH
  --data-dir DATA_DIR
  --kraken2-db KRAKEN2_DB
  --no-auto-setup
  --keep-temp           Keep per-sample temp dirs for debugging
```


## Metadata
- **Skill**: generated
