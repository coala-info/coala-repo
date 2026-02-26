# madre CWL Generation Report

## madre

### Tool Description
MADRe

### Metadata
- **Docker Image**: quay.io/biocontainers/madre:0.0.5--pyhdfd78af_0
- **Homepage**: https://github.com/lbcb-sci/MADRe
- **Package**: https://anaconda.org/channels/bioconda/packages/madre/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/madre/overview
- **Total Downloads**: 306
- **Last updated**: 2025-10-29
- **GitHub**: https://github.com/lbcb-sci/MADRe
- **Stars**: N/A
### Original Help Text
```text
usage: madre [-h] [--version] --out-folder OUT_FOLDER --reads READS
             [--reads_flag {pacbio,hifi,ont}] [--threads THREADS] [-F]
             [--config CONFIG] [--strictness {less-strict,strict,very-strict}]
             [--collapsed_strains_overhead COLLAPSED_STRAINS_OVERHEAD]
             [--min_contig_len MIN_CONTIG_LEN] [--use-myloasm USE_MYLOASM]

MADRe

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --out-folder OUT_FOLDER
                        Path to the output folder.
  --reads READS         Path to the reads file (fastq/fq can be gzipped).
  --reads_flag {pacbio,hifi,ont}
                        Reads technology. (default=ont)
  --threads THREADS     Number of threads (default=32).
  -F, --force           Force rerun all steps.
  --config CONFIG       Path to the configuration file. (default=./config.ini)
  --strictness {less-strict,strict,very-strict}
                        Database reduction strictness level. (default=very-
                        strict)
  --collapsed_strains_overhead COLLAPSED_STRAINS_OVERHEAD
                        Overhead for collapsed strains during database
                        reduction. (default=2)
  --min_contig_len MIN_CONTIG_LEN
                        Minimum contig length for database reduction.
                        (default=1000)
  --use-myloasm USE_MYLOASM
                        Use Myloasm assembler tool instead of
                        metaFlye/metaMDBG. (default=False)
```

