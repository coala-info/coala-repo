# ultraplex CWL Generation Report

## ultraplex

### Tool Description
Ultra-fast demultiplexing of fastq files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ultraplex:1.2.10--py39hbcbf7aa_0
- **Homepage**: https://github.com/ulelab/ultraplex.git
- **Package**: https://anaconda.org/channels/bioconda/packages/ultraplex/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ultraplex/overview
- **Total Downloads**: 33.0K
- **Last updated**: 2025-08-18
- **GitHub**: https://github.com/ulelab/ultraplex
- **Stars**: N/A
### Original Help Text
```text
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@   @@@@   .@@   @@@@@@@          @@         @@@@@@    (@@@@@        @@@    @@@@@@@         @@    @@@    @
@@@@   @@@@    @@   ,@@@@@@@@@    @@@@@    @@@   @@@@   (   @@@@   @@@   @@    @@@@@@@   @@@@@@@@@@   #   @@@@
@@@   &@@@    @@    @@@@@@@@@%   @@@@@         @@@@(   @    @@@         @@    @@@@@@@         @@@@@     @@@@@@
@@    @@@    @@    @@@@@@@@@@   @@@@@    @@    @@@          @@   .@@@@@@@*   @@@@@@@    @@@@@@@@.   @    @@@@@
@@@       @@@@.        @@@@@   @@@@@&   @@@.   &   &@@@@    @    @@@@@@@@         @          @    @@@@    @@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

usage: ultraplex [-h] [-v] -i INPUTFASTQ -b BARCODES [-d [DIRECTORY]]
                 [-m5 [FIVEPRIMEMISMATCHES]] [-m3 [THREEPRIMEMISMATCHES]]
                 [--three_prime_only] [--tso_seq TSO_SEQ] [-q [PHREDQUALITY]]
                 [-t [THREADS]] [-a [ADAPTER]] [-o [OUTPUTPREFIX]] [-sb] [-u]
                 [-ig] [-l [FINAL_MIN_LENGTH]] [-q5 [PHREDQUALITY_5_PRIME]]
                 [-i2 [INPUT_2]] [-a2 [ADAPTER2]] [-mt [MIN_TRIM]] [-inm]
                 [-dbr] [-kbc]

Ultra-fast demultiplexing of fastq files.

required arguments:
  -i INPUTFASTQ, --inputfastq INPUTFASTQ
                        fastq file to be demultiplexed
  -b BARCODES, --barcodes BARCODES
                        barcodes for demultiplexing in csv format

optional arguments:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -d [DIRECTORY], --directory [DIRECTORY]
                        optional output directory
  -m5 [FIVEPRIMEMISMATCHES], --fiveprimemismatches [FIVEPRIMEMISMATCHES]
                        number of mismatches allowed for 5prime barcode
                        [DEFAULT 0]
  -m3 [THREEPRIMEMISMATCHES], --threeprimemismatches [THREEPRIMEMISMATCHES]
                        number of mismatches allowed for 3prime barcode
                        [DEFAULT 0]
  --three_prime_only    Use this if only using 3 prime barcodes
  --tso_seq TSO_SEQ     Specify this if the read 1 has a TSO. Should be of
                        format NNNNIII or NNNNII where the N bases are moved
                        to the UMI and the I bases are ignored
  -q [PHREDQUALITY], --phredquality [PHREDQUALITY]
                        phred quality score for 3prime end trimming
  -t [THREADS], --threads [THREADS]
                        threads [DEFAULT 4]
  -a [ADAPTER], --adapter [ADAPTER]
                        sequencing adapter to trim [DEFAULT Illumina
                        AGATCGGAAGAGCACACGTCTGAA p7]. Specify 'p3' or
                        AGATCGGAAGAGCGGTTCAG to trim legacy p3 sequence
  -o [OUTPUTPREFIX], --outputprefix [OUTPUTPREFIX]
                        prefix for output sequences [DEFAULT demux]
  -sb, --sbatchcompression
                        whether to compress output fastq using SLURM sbatch
  -u, --ultra           whether to use ultra mode, which is faster but makes
                        very large temporary files
  -ig, --ignore_space_warning
                        whether to ignore warnings that there is not enough
                        free space
  -l [FINAL_MIN_LENGTH], --final_min_length [FINAL_MIN_LENGTH]
                        minimum length of the final outputted reads
  -q5 [PHREDQUALITY_5_PRIME], --phredquality_5_prime [PHREDQUALITY_5_PRIME]
                        quality trimming minimum score from 5' end - use with
                        caution!
  -i2 [INPUT_2], --input_2 [INPUT_2]
                        Optional second fastq.gz input for paired end data
  -a2 [ADAPTER2], --adapter2 [ADAPTER2]
                        sequencing adaptor to trim for the reverse read
                        [Default AGATCGGAAGAGCGTCGTG]
  -mt [MIN_TRIM], --min_trim [MIN_TRIM]
                        When using single end reads for 3' demultiplexing,
                        this is the minimum adapter trimming amount for a
                        3'barcode to be detected. Default = 3
  -inm, --ignore_no_match
                        Do not write reads for which there is no match.
  -dbr, --dont_build_reference
                        Skip the reference building step - for long barcodes
                        this will improve speed.
  -kbc, --keep_barcode  Do not remove barcodes/UMIs from the read (UMIs will
                        still be moved to the read header)
```

