# umitools CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| umitools_mark_duplicates | PASS |  |
| umitools_reformat_fastq | PASS |  |
| umitools_reformat_sra_fastq | PASS |  |
| umitools_simulator | PASS |  |

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


## umitools_simulator

### Tool Description
A simple in silico PCR simulator for UMI duplicates.

### Metadata
- **Docker Image**: quay.io/biocontainers/umitools:0.3.4--py36_0
- **Homepage**: https://github.com/weng-lab/umitools
- **Package**: https://anaconda.org/channels/bioconda/packages/umitools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: umi_simulator [-h] [-p PCR_CYCLE] [-l UMI_LENGTH] [-s POOL_SIZE]
                     [-o OUTPUT_SIZE] [-a AMPLIFICATION_RATE]
                     [--pcr-error PCR_ERROR]
                     [--sequencing-error SEQUENCING_ERROR] [--task TASK]
                     [--task-rep TASK_REP] [--cpu CPU] [--seed SEED]

A simple in silico PCR simulator. It creates an initial set of molecules for
one locus, simulates PCR and sequencing and outputs the stats. It is necessary
to specify the seed, since by default, this simulator uses 0 as the seed

optional arguments:
  -h, --help            show this help message and exit
  -p PCR_CYCLE, --pcr-cycle PCR_CYCLE
                        number of PCR cycles (default: 10)
  -l UMI_LENGTH, --umi-length UMI_LENGTH
                        length of UMI (default: 18)
  -s POOL_SIZE, --pool-size POOL_SIZE
                        initial pool size (number of molecules before PCR)
                        (default: 100)
  -o OUTPUT_SIZE, --output-size OUTPUT_SIZE
                        final pool size (sequencing depth, i.e. number of
                        reads sampled from the PCR amplified pool) (default:
                        100)
  -a AMPLIFICATION_RATE, --amplification-rate AMPLIFICATION_RATE
                        successful rate of PCR amplification. The actual
                        amplification rate is uniformally distributed between
                        this number and 1 (default: 0.8)
  --pcr-error PCR_ERROR
                        error rate of PCR amplification (default: 3e-05)
  --sequencing-error SEQUENCING_ERROR
                        error rate of sequencing (default: 0.001)
  --task TASK           tasks to simulate multiple conditions. Other PCR-
                        related arguments are ignored when this option is used
                        (default: None)
  --task-rep TASK_REP   number of replicates when doing tasks (default: 100)
  --cpu CPU             Tasks supporting multiprocessing. (default: 16)
  --seed SEED           starting seed (default: 0)
```

## Metadata
- **Skill**: generated
