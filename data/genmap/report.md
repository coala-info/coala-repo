# genmap CWL Generation Report

## genmap_index

### Tool Description
GenMap is a tool for fast and exact computation of genome mappability and can also be used for multiple genomes, e.g., to search for marker sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/genmap:1.3.0--h9948957_4
- **Homepage**: https://github.com/cpockrandt/genmap
- **Package**: https://anaconda.org/channels/bioconda/packages/genmap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/genmap/overview
- **Total Downloads**: 34.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/cpockrandt/genmap
- **Stars**: N/A
### Original Help Text
```text
GenMap index
============

SYNOPSIS

DESCRIPTION
    GenMap is a tool for fast and exact computation of genome mappability and
    can also be used for multiple genomes, e.g., to search for marker
    sequences.

    Detailed information is available in the wiki:
    <https://github.com/cpockrandt/genmap/wiki>

    Index creation. Only supports DNA and RNA (A, C, G, T/U, N). Other
    characters will be converted to N. Choose between the following index
    construction algorithms (-A / --algorithm): * divsufsort (recommended,
    faster, needs about `6n` space in main memory/RAM, `10n` for sequences
    >2GB), * skew (needs more than `25n` space on secondary memory/disk, i.e.,
    in TMPDIR), where `n` is the total number of bases in your fasta file(s).

OPTIONS
    -h, --help
          Display the help message.
    --version-check BOOL
          Turn this option off to disable version update notifications of the
          application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO.
          Default: 1.
    --version
          Display version information.
    --copyright
          Display long copyright information.
    -F, --fasta-file INPUT_FILE
          Path to the fasta file. Valid filetypes are: .fsa, .fna, .fastq,
          .fasta, .fas, .faa, and .fa.
    -FD, --fasta-directory INPUT_FILE
          Path to the directory of fasta files (indexes all .fsa .fna .fastq
          .fasta .fas .faa and .fa files in there, not including
          subdirectories).
    -I, --index OUTPUT_FILE
          Path to the index.
    -A, --algorithm STRING
          Algorithm for suffix array construction (needed for the FM index).
          One of divsufsort and skew. Default: divsufsort.
    -S, --sampling INTEGER
          Sampling rate of suffix array In range [1..64]. Default: 10.
    -v, --verbose
          Outputs some additional information on the constructed index.

VERSION
    Last update: Feb 19 2025
    GenMap index version: 1.3.0
    SeqAn version: 2.4.1

LEGAL
    GenMap index Copyright: 2019-2020 Christopher Pockrandt, released under the 3-clause-BSD; 2016-2019 Knut Reinert and Freie Universität Berlin, released under the 3-clause-BSD
    SeqAn Copyright: 2006-2015 Knut Reinert, FU-Berlin; released under the 3-clause BSDL.
    In your academic works please cite: Pockrandt et al (2020). GenMap: Ultra-fast Computation of Genome Mappability.
doi: https://doi.org/10.1093/bioinformatics/btaa222
    For full copyright and/or warranty information see --copyright.
```


## genmap_map

### Tool Description
Tool for computing the mappability/frequency on nucleotide sequences. It supports multi-fasta files with DNA or RNA alphabets (A, C, G, T/U, N). Frequency is the absolute number of occurrences, mappability is the inverse, i.e., 1 / frequency-value.

### Metadata
- **Docker Image**: quay.io/biocontainers/genmap:1.3.0--h9948957_4
- **Homepage**: https://github.com/cpockrandt/genmap
- **Package**: https://anaconda.org/channels/bioconda/packages/genmap/overview
- **Validation**: PASS

### Original Help Text
```text
GenMap map
==========

SYNOPSIS

DESCRIPTION
    GenMap is a tool for fast and exact computation of genome mappability and
    can also be used for multiple genomes, e.g., to search for marker
    sequences.

    Detailed information is available in the wiki:
    <https://github.com/cpockrandt/genmap/wiki>

    Tool for computing the mappability/frequency on nucleotide sequences. It
    supports multi-fasta files with DNA or RNA alphabets (A, C, G, T/U, N).
    Frequency is the absolute number of occurrences, mappability is the
    inverse, i.e., 1 / frequency-value.

OPTIONS
    -h, --help
          Display the help message.
    --version-check BOOL
          Turn this option off to disable version update notifications of the
          application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO.
          Default: 1.
    --version
          Display version information.
    --copyright
          Display long copyright information.
    -I, --index INPUT_FILE
          Path to the index
    -O, --output OUTPUT_FILE
          Path to output directory (or path to filename if only a single fasta
          files has been indexed)
    -E, --errors INTEGER
          Number of errors
    -K, --length INTEGER
          Length of k-mers
    -S, --selection OUTPUT_FILE
          Path to a bed file (3 columns: chromosome, start, end) with selected
          coordinates to compute the mappability (e.g., exon coordinates)
    -nc, --no-reverse-complement
          Searches the k-mers *NOT* on the reverse strand.
    -ep, --exclude-pseudo
          Mappability only counts the number of fasta files that contain the
          k-mer, not the total number of occurrences (i.e., neglects so
          called- pseudo genes / sequences). This has no effect on the csv
          output.
    -fs, --frequency-small
          Stores frequencies using 8 bit per value (max. value 255) instead of
          the mappbility using a float per value (32 bit). Applies to all
          formats (raw, txt, wig, bedgraph).
    -fl, --frequency-large
          Stores frequencies using 16 bit per value (max. value 65535) instead
          of the mappbility using a float per value (32 bit). Applies to all
          formats (raw, txt, wig, bedgraph).
    -r, --raw
          Output raw files, i.e., the binary format of std::vector<T> with T =
          float, uint8_t or uint16_t (depending on whether -fs or -fl is set).
          For each fasta file that was indexed a separate file is created.
          File type is .map, .freq8 or .freq16.
    -t, --txt
          Output human readable text files, i.e., the mappability respectively
          frequency values separated by spaces (depending on whether -fs or
          -fl is set). For each fasta file that was indexed a separate txt
          file is created. WARNING: This output is significantly larger than
          raw files.
    -w, --wig
          Output wig files, e.g., for adding a custom feature track to genome
          browsers. For each fasta file that was indexed a separate wig file
          and chrom.size file is created.
    -bg, --bedgraph
          Output bedgraph files. For each fasta file that was indexed a
          separate bedgraph-file is created.
    -d, --csv
          Output a detailed csv file reporting the locations of each k-mer
          (WARNING: This will produce large files and makes computing the
          mappability significantly slower).
    -m, --memory-mapping
          Turns memory-mapping on, i.e. the index is not loaded into RAM but
          accessed directly from secondary-memory. This may increase the
          overall running time, but do NOT use it if the index lies on network
          storage.
    -T, --threads INTEGER
          Number of threads Default: 20.
    -v, --verbose
          Outputs some additional information.

VERSION
    Last update: Feb 19 2025
    GenMap map version: 1.3.0
    SeqAn version: 2.4.1

LEGAL
    GenMap map Copyright: 2019-2020 Christopher Pockrandt, released under the 3-clause-BSD; 2016-2019 Knut Reinert and Freie Universität Berlin, released under the 3-clause-BSD
    SeqAn Copyright: 2006-2015 Knut Reinert, FU-Berlin; released under the 3-clause BSDL.
    In your academic works please cite: Pockrandt et al (2020). GenMap: Ultra-fast Computation of Genome Mappability.
doi: https://doi.org/10.1093/bioinformatics/btaa222
    For full copyright and/or warranty information see --copyright.
```

