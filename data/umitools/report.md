# umitools CWL Generation Report

## umitools_reformat_fastq

### Tool Description
A script to reformat reads in a UMI fastq file so that the name of each record contains the UMI. This script is also known as umitools extract.

### Metadata
- **Docker Image**: quay.io/biocontainers/umitools:0.3.4--py36_0
- **Homepage**: https://github.com/weng-lab/umitools
- **Package**: https://anaconda.org/channels/bioconda/packages/umitools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/umitools/overview
- **Total Downloads**: 12.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/weng-lab/umitools
- **Stars**: N/A
### Original Help Text
```text
usage: umi_reformat_fastq [-h] -l LEFT -r RIGHT -L LEFT_OUT -R RIGHT_OUT [-v]
                          [--umi-locator UMI_LOCATOR]
                          [--umi-padding UMI_PADDING]
                          [--umi-pattern UMI_PATTERN] [-q QUALITY] [-D]

A script to reformat reads in a UMI fastq file so that the name of each record
contains the UMI. This script is also known as umitools extract.

optional arguments:
  -h, --help            show this help message and exit
  -l LEFT, --left LEFT  the input fastq file for r1. (default: None)
  -r RIGHT, --right RIGHT
                        the input fastq file for r2. (default: None)
  -L LEFT_OUT, --left-out LEFT_OUT
                        the output fastq file for r1 (default: None)
  -R RIGHT_OUT, --right-out RIGHT_OUT
                        the output fastq file for r2 (default: None)
  -v, --verbose         Also include detailed stats for UMI and padding usage
                        (default: False)
  --umi-locator UMI_LOCATOR
                        Set the UMI locators. If you have multiple, separate
                        them by comma. e.g. GGG,TCA,ATC (default: GGG,TCA,ATC)
  --umi-padding UMI_PADDING
                        Set the nucleotide (for preventing ligation bias)
                        after the UMI locators. If you have multiple, separate
                        them by comma. e.g. A,C,G,T. The quality for this nt
                        is sometimes low, so the default is all possible four
                        nucleotides (default: A,C,G,T,N)
  --umi-pattern UMI_PATTERN
                        Set the UMI patterns. (default: None)
  -q QUALITY, --quality QUALITY
                        Quality (phred quality score) cutoff for UMI.Default
                        is 13, that is UMI with qualities >= 13 willbe kept.
                        This program assumes the phred quality scoresin the
                        fastq file are using sanger format (default: 13)
  -D, --debug           Turn on debugging mode (default: False)
reformat_fastq
```


## umitools_mark_duplicates

### Tool Description
A pair of FASTQ files are first reformatted using reformat_umi_fastq.py and then is aligned to get the bam file. This script can parse the umi barcode in the name of each read to mark duplicates. This script is also known as umitools mark.

### Metadata
- **Docker Image**: quay.io/biocontainers/umitools:0.3.4--py36_0
- **Homepage**: https://github.com/weng-lab/umitools
- **Package**: https://anaconda.org/channels/bioconda/packages/umitools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: umi_mark_duplicates [-h] -f FILE [-p PROCESSES] [-d] [-c]

A pair of FASTQ files are first reformatted using reformat_umi_fastq.py and
then is aligned to get the bam file. This script can parse the umi barcode in
the name of each read to mark duplicates. This script is also known as
umitools mark.

optional arguments:
  -h, --help            show this help message and exit
  -f FILE, --file FILE  the input bam file
  -p PROCESSES, --processes PROCESSES
                        number of processes
  -d, --debug           turn on debug mode
  -c, --count           Count the number of raw reads for each locus
                        (determined by pairs)
mark_duplicates
```


## umitools_reformat_sra_fastq

### Tool Description
A script to process reads in from UMI small RNA-seq. This script can handle
gzipped files transparently. This script is also known as umitools
extract_small.

### Metadata
- **Docker Image**: quay.io/biocontainers/umitools:0.3.4--py36_0
- **Homepage**: https://github.com/weng-lab/umitools
- **Package**: https://anaconda.org/channels/bioconda/packages/umitools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: umi_reformat_sra_fastq [-h] -i INPUT -o OUTPUT -d PCR_DUPLICATE
                              [--reads-with-improper-umi READS_WITH_IMPROPER_UMI]
                              [-e ERRORS_ALLOWED] [-v] [-5 UMI_PATTERN_5]
                              [-3 UMI_PATTERN_3] [--debug]

A script to process reads in from UMI small RNA-seq. This script can handle
gzipped files transparently. This script is also known as umitools
extract_small.

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        the input fastq file. (default: None)
  -o OUTPUT, --output OUTPUT
                        the output fastq file containing reads that are not
                        duplicates (default: None)
  -d PCR_DUPLICATE, --pcr-duplicate PCR_DUPLICATE
                        The output fastq file containing PCR duplicates
                        (default: None)
  --reads-with-improper-umi READS_WITH_IMPROPER_UMI
                        The output fastq file containing reads with improper
                        UMIs. The default is to throw away these reads. This
                        is for debugging purposes (default: )
  -e ERRORS_ALLOWED, --errors-allowed ERRORS_ALLOWED
                        Setting it to >=1 allows errors in UMIs. Otherwise, no
                        errors are allowed in UMIs. (default: 0)
  -v, --verbose         Also include detailed run info (default: False)
  -5 UMI_PATTERN_5, --umi-pattern-5 UMI_PATTERN_5
                        Set the UMI pattern at the 5' end. Use ACGT for fixed
                        nt and N for variable nt in UMI. If there are multiple
                        patterns, separate them using comma (default:
                        NNNCGANNNTACNNN,NNNATCNNNAGTNNN)
  -3 UMI_PATTERN_3, --umi-pattern-3 UMI_PATTERN_3
                        Set the UMI pattern at the 3' end. Use ACGT for fixed
                        nt and N for variable nt in UMI. If there are multiple
                        patterns, separate them using comma (default:
                        NNNGTCNNNTAGNNN)
  --debug               More output for debugging (default: False)
reformat_sra_fastq
```


## umitools_simulate

### Tool Description
See https://github.com/weng-lab/umitools for more information.
              For UMI RNA-seq: First, use umitools reformat_fastq to identify
              UMIs in UMI RNA-seq. Then, use umitools mark_duplicates to mark
              PCR duplicates. For UMI small RNA-seq: Use umitools
              reformat_sra_fastq to identify UMIs and PCR duplicates. To
              simulate UMIs, use umitools simulate.

### Metadata
- **Docker Image**: quay.io/biocontainers/umitools:0.3.4--py36_0
- **Homepage**: https://github.com/weng-lab/umitools
- **Package**: https://anaconda.org/channels/bioconda/packages/umitools/overview
- **Validation**: PASS

### Original Help Text
```text
simulate
usage: umitools [-h] subcommand

positional arguments:
  subcommand  See https://github.com/weng-lab/umitools for more information.
              For UMI RNA-seq: First, use umitools reformat_fastq to identify
              UMIs in UMI RNA-seq. Then, use umitools mark_duplicates to mark
              PCR duplicates. For UMI small RNA-seq: Use umitools
              reformat_sra_fastq to identify UMIs and PCR duplicates. To
              simulate UMIs, use umitools simulate.

optional arguments:
  -h, --help  show this help message and exit
```

