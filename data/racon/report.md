# racon CWL Generation Report

## racon

### Tool Description
Ultrafast consensus module for raw de novo genome assembly of long uncorrected reads

### Metadata
- **Docker Image**: quay.io/biocontainers/racon:1.5.0--h077b44d_8
- **Homepage**: https://github.com/lbcb-sci/racon
- **Package**: https://anaconda.org/channels/bioconda/packages/racon/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/racon/overview
- **Total Downloads**: 273.4K
- **Last updated**: 2025-11-19
- **GitHub**: https://github.com/lbcb-sci/racon
- **Stars**: N/A
### Original Help Text
```text
usage: racon [options ...] <sequences> <overlaps> <target sequences>

    #default output is stdout
    <sequences>
        input file in FASTA/FASTQ format (can be compressed with gzip)
        containing sequences used for correction
    <overlaps>
        input file in MHAP/PAF/SAM format (can be compressed with gzip)
        containing overlaps between sequences and target sequences
    <target sequences>
        input file in FASTA/FASTQ format (can be compressed with gzip)
        containing sequences which will be corrected

    options:
        -u, --include-unpolished
            output unpolished target sequences
        -f, --fragment-correction
            perform fragment correction instead of contig polishing
            (overlaps file should contain dual/self overlaps!)
        -w, --window-length <int>
            default: 500
            size of window on which POA is performed
        -q, --quality-threshold <float>
            default: 10.0
            threshold for average base quality of windows used in POA
        -e, --error-threshold <float>
            default: 0.3
            maximum allowed error rate used for filtering overlaps
        --no-trimming
            disables consensus trimming at window ends
        -m, --match <int>
            default: 3
            score for matching bases
        -x, --mismatch <int>
            default: -5
            score for mismatching bases
        -g, --gap <int>
            default: -4
            gap penalty (must be negative)
        -t, --threads <int>
            default: 1
            number of threads
        --version
            prints the version number
        -h, --help
            prints the usage
[racon::] error: missing input file(s)!
```
## Metadata
- **Skill**: generated

