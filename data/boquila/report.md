# boquila CWL Generation Report

## boquila

### Tool Description
Generate NGS reads with same nucleotide distribution as input file. Generated reads will be written to stdout. By default input and output format is FASTQ.

### Metadata
- **Docker Image**: quay.io/biocontainers/boquila:0.6.1--hdfd78af_0
- **Homepage**: https://github.com/CompGenomeLab/boquila
- **Package**: https://anaconda.org/channels/bioconda/packages/boquila/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/boquila/overview
- **Total Downloads**: 3.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/CompGenomeLab/boquila
- **Stars**: N/A
### Original Help Text
```text
boquila 0.6.1
Generate NGS reads with same nucleotide distribution as input file
Generated reads will be written to stdout
By default input and output format is FASTQ

USAGE:
    boquila [OPTIONS] <src>

ARGS:
    <src>    Model file

OPTIONS:
        --bed <FILE>        File name in which the simulated reads will be saved in BED format
        --fasta             Change input and output format to FASTA
    -h, --help              Print help information
        --inseq <FILE>      Input sequencing reads to be used instead of reference genome
        --inseqFasta        Change the input sequencing format to FASTA
        --kmer <INT>        Kmer size to be used while calculating frequency [default: 1]
        --qual <QUAL>       Quality score to be applied to to each position for all reads.
                            'setQual' flag should be present in order it to work
                            Has no effect if input reads are not in FASTQ format. [default: I]
        --ref <FILE>        Reference FASTA
        --regions <FILE>    RON formatted file containing genomic regions that generated reads will
                            be selected from
        --seed <INT>        Random number seed. If not provided system's default source of entropy
                            will be used instead.
        --sens <INT>        Sensitivity of selected reads.
                            If some positions are predominated by specific nucleotides, increasing
                            this value can make simulated reads more similar to input reads.
                            However runtime will also increase linearly.
                            [possible values: 10-100] [default: 20]
        --setQual           Use given Quality score with parameter 'qual' for all simulated reads.
    -V, --version           Print version information
```


## Metadata
- **Skill**: generated
