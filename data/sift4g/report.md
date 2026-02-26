# sift4g CWL Generation Report

## sift4g

### Tool Description
SIFT4G: a fast and accurate tool for predicting the functional impact of protein sequence variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/sift4g:2.0.0--h503566f_8
- **Homepage**: http://sift.bii.a-star.edu.sg/sift4g/
- **Package**: https://anaconda.org/channels/bioconda/packages/sift4g/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sift4g/overview
- **Total Downloads**: 8.7K
- **Last updated**: 2025-10-08
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: sift4g -q <query file> -d <database file> [arguments ...]

arguments:
    -q, --query <file>
        (required)
        input fasta query file
    -d, --database <file>
        (required)
        input fasta database file
    -g, --gap-open <int>
        default: 10
        gap opening penalty, must be given as a positive integer 
    -e, --gap-extend <int>
        default: 1
        gap extension penalty, must be given as a positive integer and
        must be less or equal to gap opening penalty
    --matrix <string>
        default: BLOSUM_62
        similarity matrix, can be one of the following:
            BLOSUM_45
            BLOSUM_50
            BLOSUM_62
            BLOSUM_80
            BLOSUM_90
            BLOSUM_30
            BLOSUM_70
            BLOSUM_250
    --evalue <float>
        default: 0.0001
        evalue threshold, alignments with higher evalue are filtered,
        must be given as a positive float
    --max-aligns <int>
        default: 400
        maximum number of alignments to be outputted
    --algorithm <string>
        default: SW
        algorithm used for alignment, must be one of the following: 
            SW - Smith-Waterman local alignment
            NW - Needleman-Wunsch global alignment
            HW - semiglobal alignment
            OV - overlap alignment
    --cards <ints>
        default: all available CUDA cards
        list of cards should be given as an array of card indexes delimited with
        nothing, for example usage of first two cards is given as --cards 01
    --out <string>
        default: current directory
        output directory for SIFT predictions
    --sub-results
        prints sub results (alignment file and a file per query containing
        its selected alignments forp rediction) to same directory defined
        with --out
    --outfmt <string>
        default: bm9
        out format for the alignment file, must be one of the following:
            bm0      - blast m0 output format
            bm8      - blast m8 tabular output format
            bm9      - blast m9 commented tabular output format
            light    - score-name tabbed output
    --kmer-length <int>
        default: 5
        length of kmers used for database search
        possible values: 3, 4, 5
    --max-candidates <int>
        default: 5000
        number of database sequences passed on to the Smith-Waterman part
    --median-threshold <float>
        default: 2.75
        represents alignment diversity, used to output only a set of alignments
    --subst <string>
        default: current directory
        directory containing substitution files for each query (extension .subst)
        files must have the same name as their corresponding query in FASTA file
    --seq-id <int>
        default: 100
    -t, --threads <int>
        default: 8
        number of threads used in thread pool
    -h, -help
        prints out the help
```

