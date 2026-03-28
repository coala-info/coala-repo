# sanitizeme CWL Generation Report

## sanitizeme_SanitizeMe_CLI.py

### Tool Description
SanitizeMe CLI tool for processing sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/sanitizeme:1.1--hdfd78af_2
- **Homepage**: https://github.com/jiangweiyao/SanitizeMe
- **Package**: https://anaconda.org/channels/bioconda/packages/sanitizeme/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sanitizeme/overview
- **Total Downloads**: 6.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jiangweiyao/SanitizeMe
- **Stars**: N/A
### Original Help Text
```text
usage: SanitizeMe_CLI.py [-h] -i INPUTFOLDER -r REFERENCE [-o OUTPUTFOLDER]
                         [--LargeReference] [-t THREADS]
                         [--Nanopore | --PacBio | --PacBioCCS | --ShortRead]

optional arguments:
  -h, --help            show this help message and exit
  -i INPUTFOLDER, --InputFolder INPUTFOLDER
                        Folder containing fastq files. Only files ending in
                        .fq, .fg.gz, .fastq, and .fastq.gz will be processed
  -r REFERENCE, --Reference REFERENCE
                        Host Reference fasta or fasta.gz file
  -o OUTPUTFOLDER, --OutputFolder OUTPUTFOLDER
                        Output Folder. Default is
                        ~/dehost_output/dehost_2026-02-25
  --LargeReference      Use this option if your reference file is greater than
                        4 Gigabases
  -t THREADS, --threads THREADS
                        Number of threads. Default is 4. More is faster if
                        your computer supports it
  --Nanopore            Select if you used Nanopore Sequencing
  --PacBio              Select if you used PacBio Genonmic Reads
  --PacBioCCS           Select if you used PacBio CCS Genomic Reads
  --ShortRead           Select if you have single end short reads (Illumina)
```


## sanitizeme_SanitizeMePaired_CLI.py

### Tool Description
Sanitizes paired-end sequencing data by removing host sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/sanitizeme:1.1--hdfd78af_2
- **Homepage**: https://github.com/jiangweiyao/SanitizeMe
- **Package**: https://anaconda.org/channels/bioconda/packages/sanitizeme/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SanitizeMePaired_CLI.py [-h] -i INPUTFOLDER -r REFERENCE
                               [-o OUTPUTFOLDER] [--LargeReference]
                               [-t THREADS]

optional arguments:
  -h, --help            show this help message and exit
  -i INPUTFOLDER, --InputFolder INPUTFOLDER
                        Folder containing paired fq, fq.gz, fastq, and
                        fastq.gz files. Program will recursively find paired
                        reads
  -r REFERENCE, --Reference REFERENCE
                        Host Reference fasta or fasta.gz file
  -o OUTPUTFOLDER, --OutputFolder OUTPUTFOLDER
                        Output Folder. Default is
                        ~/dehost_output/dehost_2026-02-25
  --LargeReference      Use this option if your reference file is greater than
                        4 Gigabases
  -t THREADS, --threads THREADS
                        Number of threads. More is faster if your computer
                        supports it
```


## Metadata
- **Skill**: generated
