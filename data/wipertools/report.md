# wipertools CWL Generation Report

## wipertools_fastqwiper

### Tool Description
Wipes quality scores from a FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/wipertools:1.1.5--pyhdfd78af_0
- **Homepage**: https://github.com/mazzalab/fastqwiper
- **Package**: https://anaconda.org/channels/bioconda/packages/wipertools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/wipertools/overview
- **Total Downloads**: 2.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mazzalab/fastqwiper
- **Stars**: N/A
### Original Help Text
```text
usage: wipertools fastqwiper [-h] -i FASTQ_IN -o FASTQ_OUT [-r [REPORT]]
                             [-f [LOG_FREQUENCY]] [-a [ALPHABET]] [-v]

options:
  -h, --help            show this help message and exit
  -i, --fastq_in FASTQ_IN
                        FASTQ file to be wiped
  -o, --fastq_out FASTQ_OUT
                        Wiped FASTQ file
  -r, --report [REPORT]
                        File name of the final quality report. Print on screen
                        if not specified
  -f, --log_frequency [LOG_FREQUENCY]
                        Number of reads you want to print a status message.
                        Default: 500000
  -a, --alphabet [ALPHABET]
                        Allowed characters set in the SEQ line. Default: ACGTN
  -v, --version         Prints the version and exists
```


## wipertools_fastqscatter

### Tool Description
Split a FASTQ file into multiple smaller files.

### Metadata
- **Docker Image**: quay.io/biocontainers/wipertools:1.1.5--pyhdfd78af_0
- **Homepage**: https://github.com/mazzalab/fastqwiper
- **Package**: https://anaconda.org/channels/bioconda/packages/wipertools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: wipertools fastqscatter [-h] -f FASTQ -n NUM_SPLITS -p PREFIX
                               [-s [SUFFIX]] [-e {fastq,fq,fastq.gz,fq.gz}]
                               [-o OUT_FOLDER] [-O {unix,cross_platform}] [-v]

options:
  -h, --help            show this help message and exit
  -f, --fastq FASTQ     The FASTQ file to be split
  -n, --num_splits NUM_SPLITS
                        Number of splits
  -p, --prefix PREFIX   The prefix of the names of the split files
  -s, --suffix [SUFFIX]
                        The suffix of the names of the split files
  -e, --ext {fastq,fq,fastq.gz,fq.gz}
                        The extension of the split files
  -o, --out_folder OUT_FOLDER
                        The folder name where to put the splits
  -O, --os {unix,cross_platform}
                        Underlying OS (Default: cross_platform)
  -v, --version         Print the version and exit
```


## wipertools_fastqgather

### Tool Description
Joins multiple FASTQ files into a single one.

### Metadata
- **Docker Image**: quay.io/biocontainers/wipertools:1.1.5--pyhdfd78af_0
- **Homepage**: https://github.com/mazzalab/fastqwiper
- **Package**: https://anaconda.org/channels/bioconda/packages/wipertools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: wipertools fastqgather [-h] -i IN_FASTQ [IN_FASTQ ...] -o OUT_FASTQ
                              [-p [PREFIX]] [-O {unix,cross_platform}] [-v]

options:
  -h, --help            show this help message and exit
  -i, --in_fastq IN_FASTQ [IN_FASTQ ...]
                        List of FASTQ files to be joined
  -o, --out_fastq OUT_FASTQ
                        Name of the resulting fastq file
  -p, --prefix [PREFIX]
                        Prefix common to the files to be joined
  -O, --os {unix,cross_platform}
                        Underlying OS (Default: cross_platform)
  -v, --version         Print the version and exits
```


## wipertools_reportgather

### Tool Description
Gathers multiple report files into a single final report.

### Metadata
- **Docker Image**: quay.io/biocontainers/wipertools:1.1.5--pyhdfd78af_0
- **Homepage**: https://github.com/mazzalab/fastqwiper
- **Package**: https://anaconda.org/channels/bioconda/packages/wipertools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: wipertools reportgather [-h] -r REPORTS [REPORTS ...] -f FINAL_REPORT
                               [-v]

options:
  -h, --help            show this help message and exit
  -r, --reports REPORTS [REPORTS ...]
                        List of report files
  -f, --final_report FINAL_REPORT
                        The final report file
  -v, --version         It prints the version and exists
```


## Metadata
- **Skill**: generated
