# ngmlr CWL Generation Report

## ngmlr

### Tool Description
ngmlr 0.2.7 (build: Jul  2 2018 10:32:15, start: 2026-02-26.16:20:07)

### Metadata
- **Docker Image**: quay.io/biocontainers/ngmlr:0.2.7--he941832_0
- **Homepage**: https://github.com/philres/ngmlr
- **Package**: https://anaconda.org/channels/bioconda/packages/ngmlr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ngmlr/overview
- **Total Downloads**: 157.7K
- **Last updated**: 2025-07-08
- **GitHub**: https://github.com/philres/ngmlr
- **Stars**: N/A
### Original Help Text
```text
ngmlr 0.2.7 (build: Jul  2 2018 10:32:15, start: 2026-02-26.16:20:07)
Contact: philipp.rescheneder@univie.ac.at

Usage: ngmlr [options] -r <reference> -q <reads> [-o <output>]

Input/Output:
    -r <file>,  --reference <file>
        (required)  Path to the reference genome (FASTA/Q, can be gzipped)
    -q <file>,  --query <file>
        Path to the read file (FASTA/Q) [/dev/stdin]
    -o <string>,  --output <string>
        Adds RG:Z:<string> to all alignments in SAM/BAM [none]
    --skip-write
        Don't write reference index to disk [false]
    --bam-fix
        Report reads with > 64k CIGAR operations as unmapped. Required to be compatibel to BAM format [false]
    --rg-id <string>
        Adds RG:Z:<string> to all alignments in SAM/BAM [none]
    --rg-sm <string>
        RG header: Sample [none]
    --rg-lb <string>
        RG header: Library [none]
    --rg-pl <string>
        RG header: Platform [none]
    --rg-ds <string>
        RG header: Description [none]
    --rg-dt <string>
        RG header: Date (format: YYYY-MM-DD) [none]
    --rg-pu <string>
        RG header: Platform unit [none]
    --rg-pi <string>
        RG header: Median insert size [none]
    --rg-pg <string>
        RG header: Programs [none]
    --rg-cn <string>
        RG header: sequencing center [none]
    --rg-fo <string>
        RG header: Flow order [none]
    --rg-ks <string>
        RG header: Key sequence [none]

General:
    -t <int>,  --threads <int>
        Number of threads [1]
    -x <pacbio, ont>,  --presets <pacbio, ont>
        Parameter presets for different sequencing technologies [pacbio]
    -i <0-1>,  --min-identity <0-1>
        Alignments with an identity lower than this threshold will be discarded [0.65]
    -R <int/float>,  --min-residues <int/float>
        Alignments containing less than <int> or (<float> * read length) residues will be discarded [0.25]
    --no-smallinv
        Don't detect small inversions [false]
    --no-lowqualitysplit
        Split alignments with poor quality [false]
    --verbose
        Debug output [false]
    --no-progress
        Don't print progress info while mapping [false]

Advanced:
    --match <float>
        Match score [2]
    --mismatch <float>
        Mismatch score [-5]
    --gap-open <float>
        Gap open score [-5]
    --gap-extend-max <float>
        Gap open extend max [-5]
    --gap-extend-min <float>
        Gap open extend min [-1]
    --gap-decay <float>
        Gap extend decay [0.15]
    -k <10-15>,  --kmer-length <10-15>
        K-mer length in bases [13]
    --kmer-skip <int>
        Number of k-mers to skip when building the lookup table from the reference [2]
    --bin-size <int>
        Sets the size of the grid used during candidate search [4]
    --max-segments <int>
        Max number of segments allowed for a read per kb [1]
    --subread-length <int>
        Length of fragments reads are split into [256]
    --subread-corridor <int>
        Length of corridor sub-reads are aligned with [40]
```

