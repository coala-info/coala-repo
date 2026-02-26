# atol-qc-raw-ont CWL Generation Report

## atol-qc-raw-ont

### Tool Description
Performs QC on raw Oxford Nanopore reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/atol-qc-raw-ont:0.1.12--pyhdfd78af_0
- **Homepage**: https://github.com/TomHarrop/atol-qc-raw-ont
- **Package**: https://anaconda.org/channels/bioconda/packages/atol-qc-raw-ont/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/atol-qc-raw-ont/overview
- **Total Downloads**: 578
- **Last updated**: 2025-11-28
- **GitHub**: https://github.com/TomHarrop/atol-qc-raw-ont
- **Stars**: N/A
### Original Help Text
```text
usage: atol-qc-raw-ont [-h] [--min-length MIN_LENGTH] [-t THREADS] [-m MEM_GB]
                       [-n]
                       (--tarfile READS_TARFILE | --fastqfiles READS [READS ...])
                       --out READS_OUT --stats STATS [--logs LOGS_DIRECTORY]

options:
  -h, --help            show this help message and exit
  --min-length MIN_LENGTH
                        Minimum length read to output. Default is 1, i.e. keep
                        all reads.
  -t THREADS, --threads THREADS
  -m MEM_GB, --mem MEM_GB
                        Intended maximum RAM in GB. NOTE: some steps (e.g.
                        filtlong) don't allow memory usage to be specified by
                        the user.
  -n                    Dry run

Input:
  --tarfile READS_TARFILE
                        Reads in a single tarfile. Will be searched for
                        filenames ending in fastq.gz.
  --fastqfiles READS [READS ...]
                        Reads in fastq.gz. Multiple files are accepted.

Output:
  --out READS_OUT       Combined output in fastq.gz
  --stats STATS         Stats output (json)
  --logs LOGS_DIRECTORY
                        Log output directory. Default: logs are discarded.
```

