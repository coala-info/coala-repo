# tcdemux CWL Generation Report

## tcdemux

### Tool Description
Demultiplexes sequencing reads based on sample information and adaptor sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/tcdemux:0.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/TomHarrop/tcdemux
- **Package**: https://anaconda.org/channels/bioconda/packages/tcdemux/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tcdemux/overview
- **Total Downloads**: 10.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/TomHarrop/tcdemux
- **Stars**: N/A
### Original Help Text
```text
usage: tcdemux [-h] [-n] [--threads int] [--mem_gb int]
               [--restart_times RESTART_TIMES] --sample_data SAMPLE_DATA_FILE
               --read_directory READ_DIRECTORY --adaptors ADAPTOR_FILES
               [ADAPTOR_FILES ...] --outdir OUTDIR
               [--keep_intermediate_files | --no-keep_intermediate_files]
               [--qtrim | --no-qtrim] [--trimq TRIMQ]

options:
  -h, --help            show this help message and exit
  -n                    Dry run
  --threads int         Number of threads. Default: 4
  --mem_gb int          Amount of RAM in GB. Default: 31
  --restart_times RESTART_TIMES
                        number of times to restart failing jobs (default 0)
  --sample_data SAMPLE_DATA_FILE
                        Sample csv (see README)
  --read_directory READ_DIRECTORY
                        Directory containing the read files
  --adaptors ADAPTOR_FILES [ADAPTOR_FILES ...]
                        FASTA file(s) of adaptors. Multiple adaptor files can
                        be used.
  --outdir OUTDIR       Output directory
  --keep_intermediate_files, --no-keep_intermediate_files
  --qtrim, --no-qtrim   Trim right end of reads to remove bases with quality
                        below trimq.
  --trimq TRIMQ         Regions with average quality BELOW this will be
                        trimmed, if qtrim is enabled
```

