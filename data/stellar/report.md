# stellar CWL Generation Report

## stellar

### Tool Description
STELLAR implements the SWIFT filter algorithm (Rasmussen et al., 2006) and a verification step for the SWIFT hits that applies local alignment, gapped X-drop extension, and extraction of the longest epsilon-match.

Input to STELLAR are two files, each containing one or more sequences in FASTA format. Each sequence from file 1 will be compared to each sequence in file 2. The sequences from file 1 are used as database, the sequences from file 2 as queries.

### Metadata
- **Docker Image**: quay.io/biocontainers/stellar:1.4.9--0
- **Homepage**: https://github.com/Stellarium/stellarium
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/stellar/overview
- **Total Downloads**: 6.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Stellarium/stellarium
- **Stars**: N/A
### Original Help Text
```text
stellar - the SwifT Exact LocaL AligneR
=======================================

SYNOPSIS
    stellar [OPTIONS] <FASTA FILE 1> <FASTA FILE 2>

DESCRIPTION
    STELLAR implements the SWIFT filter algorithm (Rasmussen et al., 2006) and
    a verification step for the SWIFT hits that applies local alignment,
    gapped X-drop extension, and extraction of the longest epsilon-match.

    Input to STELLAR are two files, each containing one or more sequences in
    FASTA format. Each sequence from file 1 will be compared to each sequence
    in file 2. The sequences from file 1 are used as database, the sequences
    from file 2 as queries.

    (c) 2010-2012 by Birte Kehr

REQUIRED ARGUMENTS
    FASTA_FILE_1 INPUT_FILE
          Valid filetypes are: .fasta and .fa.
    FASTA_FILE_2 INPUT_FILE
          Valid filetypes are: .fasta and .fa.

OPTIONS
    -h, --help
          Display the help message.
    --version-check BOOL
          Turn this option off to disable version update notifications of the
          application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO.
          Default: 1.
    --version
          Display version information.

  Main Options:
    -e, --epsilon DOUBLE
          Maximal error rate (max 0.25). In range [0.0000001..0.25]. Default:
          0.05.
    -l, --minLength INTEGER
          Minimal length of epsilon-matches. In range [0..inf]. Default: 100.
    -f, --forward
          Search only in forward strand of database.
    -r, --reverse
          Search only in reverse complement of database.
    -a, --alphabet STRING
          Alphabet type of input sequences (dna, rna, dna5, rna5, protein,
          char). One of dna, dna5, rna, rna5, protein, and char.
    -v, --verbose
          Set verbosity mode.

  Filtering Options:
    -k, --kmer INTEGER
          Length of the q-grams (max 32). In range [1..32].
    -rp, --repeatPeriod INTEGER
          Maximal period of low complexity repeats to be filtered. Default: 1.
    -rl, --repeatLength INTEGER
          Minimal length of low complexity repeats to be filtered. Default:
          1000.
    -c, --abundanceCut DOUBLE
          k-mer overabundance cut ratio. In range [0..1]. Default: 1.

  Verification Options:
    -x, --xDrop DOUBLE
          Maximal x-drop for extension. Default: 5.
    -vs, --verification STRING
          Verification strategy: exact or bestLocal or bandedGlobal One of
          exact, bestLocal, and bandedGlobal. Default: exact.
    -dt, --disableThresh INTEGER
          Maximal number of verified matches before disabling verification for
          one query sequence (default infinity). In range [0..inf].
    -n, --numMatches INTEGER
          Maximal number of kept matches per query and database. If STELLAR
          finds more matches, only the longest ones are kept. Default: 50.
    -s, --sortThresh INTEGER
          Number of matches triggering removal of duplicates. Choose a smaller
          value for saving space. Default: 500.

  Output Options:
    -o, --out OUTPUT_FILE
          Name of output file. Valid filetypes are: .txt and .gff. Default:
          stellar.gff.
    -od, --outDisabled OUTPUT_FILE
          Name of output file for disabled query sequences. Valid filetypes
          are: .fasta and .fa. Default: stellar.disabled.fasta.

REFERENCES
    Kehr, B., Weese, D., Reinert, K.: STELLAR: fast and exact local
    alignments. BMC Bioinformatics, 12(Suppl 9):S15, 2011.

VERSION
    Last update: 2016-12-22_14:49:36_+0100
    stellar version: 1.4.9 [75beba3]
    SeqAn version: 2.3.1
```


## Metadata
- **Skill**: generated
