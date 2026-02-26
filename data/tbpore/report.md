# tbpore CWL Generation Report

## tbpore_cluster

### Tool Description
Cluster consensus sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/tbpore:0.7.1--pyhdfd78af_0
- **Homepage**: https://github.com/mbhall88/tbpore/
- **Package**: https://anaconda.org/channels/bioconda/packages/tbpore/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tbpore/overview
- **Total Downloads**: 21.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mbhall88/tbpore
- **Stars**: N/A
### Original Help Text
```text
Usage: tbpore cluster [OPTIONS] [INPUTS]...

  Cluster consensus sequences

  Preferably input consensus sequences previously generated with tbpore
  process.

  INPUTS: Two or more consensus fasta sequences. Use glob patterns to input
  several easily (e.g. output/sample_*/*.consensus.fa).

Options:
  -h, --help                      Show this message and exit.
  -T, --threshold INTEGER         Clustering threshold  [default: 6]
  -o, --outdir DIRECTORY          Directory to place output files  [default:
                                  .]
  --tmp DIRECTORY                 Specify where to write all (tbpore)
                                  temporary files. [default: <outdir>/.tbpore]
  -t, --threads INTEGER           Number of threads to use in multithreaded
                                  tools  [default: 1]
  -d, --cleanup / -D, --no-cleanup
                                  Remove all temporary files on *successful*
                                  completion  [default: no-cleanup]
  --cache DIRECTORY               Path to use for the cache  [default:
                                  /root/.cache]
```


## tbpore_download

### Tool Description
Downloads and validates the decontamination database for TBpore.

### Metadata
- **Docker Image**: quay.io/biocontainers/tbpore:0.7.1--pyhdfd78af_0
- **Homepage**: https://github.com/mbhall88/tbpore/
- **Package**: https://anaconda.org/channels/bioconda/packages/tbpore/overview
- **Validation**: PASS

### Original Help Text
```text
[2026-02-25 21:24:33] INFO     | Welcome to TBpore version 0.7.1
[2026-02-25 21:24:33] INFO     | Downloading decontamination database to /root/.tbpore/decontamination_db/remove_contam.map-ont.mmi. This may take a while...
[2026-02-25 21:24:34] INFO     | Validating the decontamination database...
[2026-02-25 21:24:34] ERROR    | The sha256 hash for the compressed decontamination database did not match the expected hash
```


## tbpore_process

### Tool Description
Single-sample TB genomic analysis from Nanopore sequencing data

### Metadata
- **Docker Image**: quay.io/biocontainers/tbpore:0.7.1--pyhdfd78af_0
- **Homepage**: https://github.com/mbhall88/tbpore/
- **Package**: https://anaconda.org/channels/bioconda/packages/tbpore/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: tbpore process [OPTIONS] [INPUTS]...

  Single-sample TB genomic analysis from Nanopore sequencing data

  INPUTS: Fastq file(s) and/or a directory containing fastq files. All files
  will be joined into a single fastq file, so ensure they're all part of the
  same sample/isolate.

Options:
  -h, --help                      Show this message and exit.
  -r, --recursive                 Recursively search INPUTS for fastq files
  -S, --name TEXT                 Name of the sample. By default, will use the
                                  first INPUT file with fastq extensions
                                  removed
  -A, --report_all_mykrobe_calls  Report all mykrobe calls (turn on flag -A,
                                  --report_all_calls when calling mykrobe)
  --db PATH                       Path to the decontaminaton database
                                  [default: /root/.tbpore/decontamination_db/r
                                  emove_contam.map-ont.mmi]
  -m, --metadata PATH             Path to the decontaminaton database metadata
                                  file  [default:
                                  /usr/local/lib/python3.8/site-packages/data/
                                  decontamination_db/remove_contam.tsv.gz]
  -c, --coverage INTEGER          Depth of coverage to subsample to. Use 0 to
                                  disable
  -o, --outdir DIRECTORY          Directory to place output files  [default:
                                  .]
  --tmp DIRECTORY                 Specify where to write all (tbpore)
                                  temporary files. [default: <outdir>/.tbpore]
  -t, --threads INTEGER           Number of threads to use in multithreaded
                                  tools  [default: 1]
  -d, --cleanup / -D, --no-cleanup
                                  Remove all temporary files on *successful*
                                  completion  [default: no-cleanup]
  --cache DIRECTORY               Path to use for the cache  [default:
                                  /root/.cache]
```

