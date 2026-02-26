# reads2graph CWL Generation Report

## reads2graph

### Tool Description
Construction of edit-distance graphs from large scale sets of short reads through minimizer- and gOMH-bucketing and graph traversal.

### Metadata
- **Docker Image**: quay.io/biocontainers/reads2graph:1.0.0--h503566f_1
- **Homepage**: https://github.com/Jappy0/reads2graph
- **Package**: https://anaconda.org/channels/bioconda/packages/reads2graph/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/reads2graph/overview
- **Total Downloads**: 1.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Jappy0/reads2graph
- **Stars**: N/A
### Original Help Text
```text
2026-02-25 09:04:25: [36mINFO: [0mWelcome to use reads2graph!
2026-02-25 09:04:25: [36mINFO: [0mreads2graph --help
reads2graph - Construction of edit-distance graphs from a set of short reads.
=============================================================================

DESCRIPTION
    Construction of edit-distance graphs from large scale sets of short reads
    through minimizer- and gOMH-bucketing and graph traversal.

OPTIONS
    -i, --input_data (std::filesystem::path)
          Please provide a fasta/fastq/ data file. Default: "".
    -o, --output_dir (std::filesystem::path)
          The directory for outputs. Default: "/".
    -r, --read_length (unsigned 32 bit integer)
          No need to input this parameter, reads2graph will calculate the
          minimum read length. Default: 0.
    -k, --k_size (unsigned 8 bit integer)
          The size for minimiser. Default: 4.
    -w, --window_number (unsigned 8 bit integer)
          The window number for minimiser. Default: 3.
    -x, --max_edit_dis (unsigned 8 bit integer)
          The maximum edit distance for constructing edges between reads
          Default: 2.
    -n, --min_edit_dis (unsigned 8 bit integer)
          The minimum edit distance for constructing edges between reads.
          Default: 1.
    -p, --num_process (signed 32 bit integer)
          The number of expected processes. Default: 26.
    --pair_wise (bool)
          Brute Force calcualte the pairwise edit distance. Default: 0.
    --bin_size_max (unsigned 32 bit integer)
          The larger threshold used to group buckets of different sizes.
          Default: 10000.
    --omh_k (unsigned 32 bit integer)
          K-mer size used in order min hashing. Default: 4.
    --omh_times (unsigned 32 bit integer)
          The number of times to perform permutation in order min hashing.
          Default: 3.
    --omh_seed (unsigned 64 bit integer)
          The seed to generate a series of seeds for OMH bucketing. Default:
          2024.
    --omh_flag (bool)
          Do not set this flag by yourself. When the permutation_times larger
          than the number of k-mer candidates and the kmer size are the same
          one, bucketing the reads using each kmer candidate. Default: 0.
    --bad_kmer_ratio (double)
          The maximum ratio of bad k-mers out of total number of kmers in a
          window of a read. Default: 0.3.
    --probability (double)
          The expected probability P for grouping two similar reads into same
          bucket by at least one minimiser that does not include the different
          bases Default: 0.86.
    --visit_depth (unsigned 32 bit integer)
          The maximum distance of nodes from the give node for updating more
          potential edges. Default: 15.
    --save_graph (bool)
          If ture, reads2graph will save graph to file in graphviz dot format.
          Default: 0.

  Common options
    -h, --help
          Prints the help page.
    -hh, --advanced-help
          Prints the help page including advanced options.
    --version
          Prints the version information.
    --copyright
          Prints the copyright/license information.
    --export-help (std::string)
          Export the help page information. Value must be one of [html, man,
          ctd, cwl].

VERSION
    Last update: 04.06.2024
    reads2graph version: 1.0.0
    Sharg version: 1.1.1
    SeqAn version: 3.3.0

LEGAL
    reads2graph Copyright: BSD 3-Clause License
    Author: Pengyao Ping
    SeqAn Copyright: 2006-2023 Knut Reinert, FU-Berlin; released under the
    3-clause BSDL.
    For full copyright and/or warranty information see --copyright.
```

