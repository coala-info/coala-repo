# cram-archiver CWL Generation Report

## cram-archiver

### Tool Description
Archive BAM files to CRAM format recursively, with options for reference checking, age filtering, and cleanup.

### Metadata
- **Docker Image**: quay.io/biocontainers/cram-archiver:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/lumc/cram-archiver
- **Package**: https://anaconda.org/channels/bioconda/packages/cram-archiver/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cram-archiver/overview
- **Total Downloads**: 322
- **Last updated**: 2025-07-07
- **GitHub**: https://github.com/lumc/cram-archiver
- **Stars**: N/A
### Original Help Text
```text
usage: cram-archiver [-h] -r REFERENCE [-t THREADS] [-d MINIMUM_AGE_DAYS]
                     [--delete] [--cram-version CRAM_VERSION]
                     [--exclude EXCLUDE] [--exclude-list PATH]
                     [--dont-write-checksums] [--dont-write-index] [--dry-run]
                     [-v] [-q] [--version]
                     PATH

positional arguments:
  PATH                  Path to BAM file or directory to be recursively
                        searched.

options:
  -h, --help            show this help message and exit
  -r, --reference REFERENCE
                        Reference to be used for CRAM conversion. Can be used
                        multiple times. Reference will be checked with the BAM
                        file.
  -t, --threads THREADS
                        The number of threads used for conversion and
                        checksumming.Default: 1.
  -d, --minimum-age-days MINIMUM_AGE_DAYS
                        The minimum last modification of the BAM file in days
                        prior. This assumes the system clock timezone matches
                        that of the file while also assuming that every day
                        has 24x60x60 seconds. Default 0.
  --delete              Delete BAM files after successful conversion.
  --cram-version CRAM_VERSION
                        CRAM version to use for CRAM conversion. Default: 3.0.
  --exclude EXCLUDE     Exclude file or directory from conversion. Can be
                        supplied multiple times.
  --exclude-list PATH   Supply a newline-separated file with files and
                        directories to exclude.
  --dont-write-checksums
                        Do not store samtools checksum output on disk.
  --dont-write-index    Do not write index files for CRAM files.
  --dry-run             Print the paths of the to be archived BAM files.
                        Perform no actions.
  -v, --verbose         Display more logging information.
  -q, --quiet           Display less logging information.
  --version             show program's version number and exit
```


## Metadata
- **Skill**: generated
