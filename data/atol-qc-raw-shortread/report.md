# atol-qc-raw-shortread CWL Generation Report

## atol-qc-raw-shortread

### Tool Description
Performs quality control and trimming on raw short-read sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/atol-qc-raw-shortread:0.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/TomHarrop/atol-qc-raw-shortread
- **Package**: https://anaconda.org/channels/bioconda/packages/atol-qc-raw-shortread/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/atol-qc-raw-shortread/overview
- **Total Downloads**: 485
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/TomHarrop/atol-qc-raw-shortread
- **Stars**: N/A
### Original Help Text
```text
usage: atol-qc-raw-shortread [-h] [-t THREADS] [-n] [--qtrim | --no-qtrim]
                             [--trimq TRIMQ] [--dataset_id DATASET_ID]
                             [--hic_kit HIC_KIT] --in R1 --in2 R2
                             [-a ADAPTORS [ADAPTORS ...]]
                             (--cram CRAM_OUT | --out R1_OUT) [--out2 R2_OUT]
                             --stats STATS [--logs LOGS_DIRECTORY]

options:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
  -n                    Dry run
  --qtrim, --no-qtrim   Trim right end of reads to remove bases with quality
                        below trimq.
  --trimq TRIMQ         Regions with average quality BELOW this will be
                        trimmed, if qtrim is enabled
  --dataset_id DATASET_ID
                        Only for CRAM output. Will be added to the @RG header
                        line.
  --hic_kit HIC_KIT     Only for CRAM output. Will be added to the @RG header
                        line.

Input:
  --in R1               Read 1 input
  --in2 R2              Read 2 input
  -a ADAPTORS [ADAPTORS ...], --adaptors ADAPTORS [ADAPTORS ...]
                        FASTA file(s) of adaptors. Multiple adaptor files can
                        be used. Default ['/usr/local/opt/bbmap-38.95-
                        1/resources/adapters.fa'].

Output:
  --cram CRAM_OUT       CRAM output. For IO efficiency, you can output CRAM or
                        fastq, but not both. If you need both, convert the
                        output afterwards.
  --out R1_OUT          Read 1 output. For IO efficiency, you can output CRAM
                        or fastq, but not both. If you need both, convert the
                        output afterwards.
  --out2 R2_OUT         Read 2 output
  --stats STATS         Stats output (json)
  --logs LOGS_DIRECTORY
                        Log output directory. Default: logs are discarded.
```

