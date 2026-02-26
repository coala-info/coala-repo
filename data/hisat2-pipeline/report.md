# hisat2-pipeline CWL Generation Report

## hisat2-pipeline

### Tool Description
A pipeline for processing RNA-Seq data with HISAT2 and Stringtie.

### Metadata
- **Docker Image**: quay.io/biocontainers/hisat2-pipeline:1.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/mcamagna/HISAT2-pipeline
- **Package**: https://anaconda.org/channels/bioconda/packages/hisat2-pipeline/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hisat2-pipeline/overview
- **Total Downloads**: 3.3K
- **Last updated**: 2025-08-19
- **GitHub**: https://github.com/mcamagna/HISAT2-pipeline
- **Stars**: N/A
### Original Help Text
```text
usage: hisat2-pipeline [-h] [--reads_folder READS_FOLDER]
                       [--genome_folder GENOME_FOLDER] [--outfolder OUTFOLDER]
                       [--skip_mapping] [--threads THREADS]
                       [--hisat_options HISAT_OPTIONS]
                       [--stringtie_options STRINGTIE_OPTIONS] [--yes]
                       [--version]

options:
  -h, --help            show this help message and exit
  --reads_folder READS_FOLDER
                        The folder where the reads are located (default=
                        ./reads)
  --genome_folder GENOME_FOLDER
                        The folder where the genome fasta and gff file is
                        located (default= ./genome)
  --outfolder OUTFOLDER
                        The folder where the results will be written to
                        (default=./)
  --skip_mapping        Skip mapping to genome
  --threads THREADS     The number of threads used (default=20)
  --hisat_options HISAT_OPTIONS
                        May be used to pass additional options to HISAT2.
                        Provided parameters must be surrounded by quotation
                        marks, e.g. --hisat_options "--very-sensitive --no-
                        spliced-alignment"
  --stringtie_options STRINGTIE_OPTIONS
                        May be used to pass additional options to Stringtie.
                        Provided parameters must be surrounded by quotation
                        marks, e.g. --stringtie_options "-m 150 -t"
  --yes                 Answer all questions with 'yes'
  --version             Prints the current version'
```

