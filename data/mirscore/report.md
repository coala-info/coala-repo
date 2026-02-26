# mirscore CWL Generation Report

## mirscore_miRScore

### Tool Description
miRScore is a tool for scoring miRNA potential.

### Metadata
- **Docker Image**: quay.io/biocontainers/mirscore:0.3.4--hdfd78af_0
- **Homepage**: https://github.com/Aez35/miRScore
- **Package**: https://anaconda.org/channels/bioconda/packages/mirscore/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mirscore/overview
- **Total Downloads**: 1.7K
- **Last updated**: 2025-09-15
- **GitHub**: https://github.com/Aez35/miRScore
- **Stars**: N/A
### Original Help Text
```text
Checking required modules...
Requires package bowtie : /usr/local/bin/bowtie
Requires package samtools : /usr/local/bin/samtools
Requires package RNAfold : /usr/local/bin/RNAfold
Requires package cutadapt : /usr/local/bin/cutadapt
usage: miRScore [-h] -fastq [FASTQ ...] -mature MATURE -hairpin HAIRPIN
                [-mm [MM]] [-n N] [-nostrucvis [NOSTRUCVIS]]
                [-threads THREADS] -kingdom {plant,animal} [-out OUT]
                [-autotrim [AUTOTRIM]] [-trimkey TRIMKEY] [-rescue [RESCUE]]

options:
  -h, --help            show this help message and exit
  -fastq [FASTQ ...]    One or more fastq alignment files
  -mature MATURE        fasta file of mature miRNA sequence
  -hairpin HAIRPIN      fasta file of hairpin precursor sequence
  -mm [MM]              Allow up to 1 mismatch in miRNA reads
  -n N                  Results file name
  -nostrucvis [NOSTRUCVIS]
                        Do not include StrucVis output
  -threads THREADS      Specify number of threads for samtools
  -kingdom {plant,animal}
                        Specify animal or plant
  -out OUT              output directory
  -autotrim [AUTOTRIM]  Trim untrimmed fastq files
  -trimkey TRIMKEY      Abundant miRNA used to find adapters for trimming with
                        option -autotrim
  -rescue [RESCUE]      Reevaluate failed miRNAs and reannotate loci with
                        alternative miRNA duplex that meets all criteria
```

