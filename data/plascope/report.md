# plascope CWL Generation Report

## plascope_plaScope.sh

### Tool Description
PlaScope: A tool for plasmid detection and classification.

### Metadata
- **Docker Image**: quay.io/biocontainers/plascope:1.3.1--0
- **Homepage**: https://github.com/GuilhemRoyer/PlaScope
- **Package**: https://anaconda.org/channels/bioconda/packages/plascope/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/plascope/overview
- **Total Downloads**: 11.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/GuilhemRoyer/PlaScope
- **Stars**: N/A
### Original Help Text
```text
usage: plaScope.sh [OPTIONS] [ARGUMENTS]

General options:
  -h, --help		display this message and exit
  -v, --version		display version number and exit
  -n, --no-banner	don't print beautiful banners
  -t			number of threads[OPTIONAL] [default : 8]
  -o			output directory [OPTIONAL] [default : current directory]
  --sample		Sample name [MANDATORY]
  --db_dir		path to centrifuge database [MANDATORY]
  --db_name		centrifuge database name [MANDATORY]

Mode 1: SPAdes assembly + contig classification
  -1			forward paired-end reads [MANDATORY]
  -2			reverse paired-end reads [MANDATORY]


Mode 2: contig classification of a fasta file (only if you already have your SPAdes assembly!)
  --fasta		SPAdes assembly fasta file [MANDATORY]



Example mode 1:
plaScope.sh -1 my_reads_1.fastq.gz -2 my_reads_2.fastq.gz -o output_directory  --db_dir path/to/DB --db_name chromosome_plasmid_db --sample name_of_my_sample

Example mode 2:
plaScope.sh --fasta my_fastafile.fasta -o output_directory --db_dir path/to/DB --db_name chromosome_plasmid_db --sample name_of_my_sample



Github:
https://github.com/GuilhemRoyer/PlaScope
```

