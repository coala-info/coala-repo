# pneumocat CWL Generation Report

## pneumocat_PneumoCaT.py

### Tool Description
PneumoCaT.py

### Metadata
- **Docker Image**: quay.io/biocontainers/pneumocat:1.2.1--0
- **Homepage**: https://github.com/phe-bioinformatics/pneumocat/archive/v1.1.tar.gz
- **Package**: https://anaconda.org/channels/bioconda/packages/pneumocat/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pneumocat/overview
- **Total Downloads**: 15.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/phe-bioinformatics/pneumocat
- **Stars**: N/A
### Original Help Text
```text
usage: python PneumoCaT.py [-h] [--input_directory INPUT_DIRECTORY]
                                [--fastq_1 FASTQ_1] [--fastq_2 FASTQ_2]
                                [--variant_database VARIANT_DATABASE]
                                [--output_dir OUTPUT_DIR] [--threads THREADS]
                                [--bowtie BOWTIE] [--samtools SAMTOOLS] [--cleanup]
          

PneumoCaT.py

optional arguments:
  -h, --help            show this help message and exit
  --input_directory INPUT_DIRECTORY, -i INPUT_DIRECTORY
                        please provide the path to the directory contains the
                        fastq files [REQUIRED - OPTION 1]
  --fastq_1 FASTQ_1, -1 FASTQ_1
                        Fastq file pair 1 [REQUIRED - OPTION 2]
  --fastq_2 FASTQ_2, -2 FASTQ_2
                        Fastq file pair 2 [REQUIRED - OPTION 2]
  --variant_database VARIANT_DATABASE, -d VARIANT_DATABASE
                        variant database [OPTIONAL]; defaults to
                        streptococcus-pneumoniae-ctvdb in the github directory
  --output_dir OUTPUT_DIR, -o OUTPUT_DIR
                        please provide an output directory [OPTIONAL]; if none
                        provided a pneumo_capsular_typing folder will be
                        created in the directory containing the fastq files
  --threads THREADS, -t THREADS
                        number of threads to use [OPTIONAL]; default=4
  --bowtie BOWTIE, -b BOWTIE
                        please provide the path for bowtie2 [OPTIONAL];
                        defaults to bowtie2
  --samtools SAMTOOLS, -s SAMTOOLS
                        please provide the path for samtools [OPTIONAL];
                        defaults to samtools
  --cleanup, -c         if used, all bam files generated will be removed upon
                        completion
```

