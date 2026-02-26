# rustynuc CWL Generation Report

## rustynuc

### Tool Description
Investigate alignments for possible 8-oxoG damage

### Metadata
- **Docker Image**: quay.io/biocontainers/rustynuc:0.3.1--h577a1d6_3
- **Homepage**: https://github.com/bjohnnyd/rustynuc
- **Package**: https://anaconda.org/channels/bioconda/packages/rustynuc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rustynuc/overview
- **Total Downloads**: 11.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bjohnnyd/rustynuc
- **Stars**: N/A
### Original Help Text
```text
rustynuc 0.3.1

USAGE:
    rustynuc [FLAGS] [OPTIONS] <bam>

FLAGS:
    -a, --all                Whether to process and print information for every position in the BAM file
    -h, --help               Prints help information
        --no-overlapping     Do not count overlapping mates when calculating total depth
    -n, --no-qval            Skip calculating qvalue
    -p, --pseudocount        Whether to use pseudocounts (increments all counts by 1) when calculating statistics
        --skip-fishers       Skip applying Fisher's Exact Filter on VCF
    -V, --version            Prints version information
    -v, --verbosity          Determines verbosity of the processing, can be specified multiple times -vvv
    -w, --with-track-line    Include track line (for correct visualization with IGV)

OPTIONS:
        --af-both-pass <af-both-pass>        AF on both the ff and fr at which point a call in the VCF will excluded
                                             from the OxoAF filter [default: 0.1]
        --af-either-pass <af-either-pass>    AF above this cutoff in EITHER read orientation will be excluded from OxoAF
                                             filter [default: 0.25]
        --alpha <alpha>                      FDR threshold [default: 0.2]
    -b, --bcf <bcf>                          BCF/VCF for variants called on the supplied alignment file
        --bed <bed>                          A BED file to restrict analysis to specific regions
        --fishers-sig <fishers-sig>          Significance threshold for Fisher's test [default: 0.05]
        --max-depth <max-depth>              Maximum pileup depth to use [default: 1000]
    -m, --min-reads <min-reads>              Minimum number of aligned reads in ff or fr orientation for a position to
                                             be considered [default: 4]
    -q, --quality <quality>                  Minimum base quality to consider [default: 20]
    -r, --reference <reference>              Optional reference which will be used to determine sequence context and
                                             type of change
    -t, --threads <threads>                  Number of threads [default: 4]

ARGS:
    <bam>    Alignments to investigate for possible 8-oxoG damage
```

