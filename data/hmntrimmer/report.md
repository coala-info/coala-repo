# hmntrimmer CWL Generation Report

## hmntrimmer_HmnTrimmer

### Tool Description
HmnTrimmer, a trimmer of NGS reads

### Metadata
- **Docker Image**: quay.io/biocontainers/hmntrimmer:0.6.5--he93f0d0_1
- **Homepage**: https://github.com/guillaume-gricourt/HmnTrimmer
- **Package**: https://anaconda.org/channels/bioconda/packages/hmntrimmer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hmntrimmer/overview
- **Total Downloads**: 2.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/guillaume-gricourt/HmnTrimmer
- **Stars**: N/A
### Original Help Text
```text
HmnTrimmer - HmnTrimmer, a trimmer of NGS reads
===============================================

SYNOPSIS
    HmnTrimmer HmnTrimmer [OPTIONS] [TRIMMERS]

DESCRIPTION

OPTIONS
    -h, --help
          Display the help message.
    --version-check BOOL
          Turn this option off to disable version update notifications of the
          application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO.
          Default: 1.
    --version
          Display version information.

  Input/Output options:
    -iff, --input-fastq-forward INPUT_FILE
          File with read forward for apply trimmers. Valid filetypes are:
          .fq[.*] and .fastq[.*], where * is any of the following extensions:
          gz for transparent (de)compression.
    -ifr, --input-fastq-reverse INPUT_FILE
          File with read reverse for apply trimmers. Valid filetypes are:
          .fq[.*] and .fastq[.*], where * is any of the following extensions:
          gz for transparent (de)compression.
    -off, --output-fastq-forward OUTPUT_FILE
          File with write forward trimmed. Valid filetypes are: .fq[.*] and
          .fastq[.*], where * is any of the following extensions: gz for
          transparent (de)compression.
    -ofr, --output-fastq-reverse OUTPUT_FILE
          File with write reverse trimmed. Valid filetypes are: .fq[.*] and
          .fastq[.*], where * is any of the following extensions: gz for
          transparent (de)compression.
    -ifi, --input-fastq-interleaved INPUT_FILE
          File with read interleaved Valid filetypes are: .fq[.*] and
          .fastq[.*], where * is any of the following extensions: gz for
          transparent (de)compression.
    -ofi, --output-fastq-interleaved OUTPUT_FILE
          File with write reverse trimmed. Valid filetypes are: .fq[.*] and
          .fastq[.*], where * is any of the following extensions: gz for
          transparent (de)compression.
    -u, --output-fastq-discard OUTPUT_FILE
          File with discard sequences. Valid filetypes are: .fq[.*] and
          .fastq[.*], where * is any of the following extensions: gz for
          transparent (de)compression.

  Trimmers. Classified in severals categories : quality,    length and information:
    -qualtail, --quality-tail STRING
    -slidingwindow, --quality-sliding-window STRING
    -lenmin, --length-min INTEGER
    -infodust, --information-dust INTEGER
    -infon, --information-n INTEGER

  Performance/Other Options:
    -r, --output-report OUTPUT_FILE
          File output report Valid filetype is: .json.
    -t, --threads INTEGER
          Specify the number of threads to use. In range [1..8]. Default: 1.
    -rb, --reads-batch INTEGER
          Specify the number of reads to process in one batch. In range
          [100..50000000]. Default: 1000000.
    -ver, --verbose INTEGER
          Specify the log level to use In range [1..6]. Default: 4.

VERSION
    Last update: Jul. 2022
    HmnTrimmer version: 0.6.4
    SeqAn version: 2.4.0
HmnTrimmer - HmnTrimmer, a trimmer of NGS reads
===============================================

SYNOPSIS
    HmnTrimmer HmnTrimmer [OPTIONS] [TRIMMERS]

DESCRIPTION

OPTIONS
    -h, --help
          Display the help message.
    --version-check BOOL
          Turn this option off to disable version update notifications of the
          application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO.
          Default: 1.
    --version
          Display version information.

  Input/Output options:
    -iff, --input-fastq-forward INPUT_FILE
          File with read forward for apply trimmers. Valid filetypes are:
          .fq[.*] and .fastq[.*], where * is any of the following extensions:
          gz for transparent (de)compression.
    -ifr, --input-fastq-reverse INPUT_FILE
          File with read reverse for apply trimmers. Valid filetypes are:
          .fq[.*] and .fastq[.*], where * is any of the following extensions:
          gz for transparent (de)compression.
    -off, --output-fastq-forward OUTPUT_FILE
          File with write forward trimmed. Valid filetypes are: .fq[.*] and
          .fastq[.*], where * is any of the following extensions: gz for
          transparent (de)compression.
    -ofr, --output-fastq-reverse OUTPUT_FILE
          File with write reverse trimmed. Valid filetypes are: .fq[.*] and
          .fastq[.*], where * is any of the following extensions: gz for
          transparent (de)compression.
    -ifi, --input-fastq-interleaved INPUT_FILE
          File with read interleaved Valid filetypes are: .fq[.*] and
          .fastq[.*], where * is any of the following extensions: gz for
          transparent (de)compression.
    -ofi, --output-fastq-interleaved OUTPUT_FILE
          File with write reverse trimmed. Valid filetypes are: .fq[.*] and
          .fastq[.*], where * is any of the following extensions: gz for
          transparent (de)compression.
    -u, --output-fastq-discard OUTPUT_FILE
          File with discard sequences. Valid filetypes are: .fq[.*] and
          .fastq[.*], where * is any of the following extensions: gz for
          transparent (de)compression.

  Trimmers. Classified in severals categories : quality,    length and information:
    -qualtail, --quality-tail STRING
    -slidingwindow, --quality-sliding-window STRING
    -lenmin, --length-min INTEGER
    -infodust, --information-dust INTEGER
    -infon, --information-n INTEGER

  Performance/Other Options:
    -r, --output-report OUTPUT_FILE
          File output report Valid filetype is: .json.
    -t, --threads INTEGER
          Specify the number of threads to use. In range [1..8]. Default: 1.
    -rb, --reads-batch INTEGER
          Specify the number of reads to process in one batch. In range
          [100..50000000]. Default: 1000000.
    -ver, --verbose INTEGER
          Specify the log level to use In range [1..6]. Default: 4.

VERSION
    Last update: Jul. 2022
    HmnTrimmer version: 0.6.4
    SeqAn version: 2.4.0
```

