# raptor CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| raptor_build | PASS | Raptor repository test files (small simulated sequences); index built from a list and from a layout |
| raptor_layout | PASS | Raptor repository test files (small simulated sequences) |
| raptor_prepare | PASS | Raptor repository test files (small simulated sequences); minimiser files written |
| raptor_search | PASS | Raptor repository test files (small simulated sequences); queries hit the expected bins |
| raptor_upgrade | PASS | Raptor repository test files (small simulated sequences); index made with Raptor 2.0.0 upgraded and searched with Raptor 3 |

## raptor_build

### Tool Description
Constructs a Raptor index.

### Metadata
- **Docker Image**: quay.io/biocontainers/raptor:3.0.1--haf24da9_4
- **Homepage**: https://github.com/seqan/raptor
- **Package**: https://anaconda.org/channels/bioconda/packages/raptor/overview
- **Validation**: PASS

### Original Help Text
```text
Raptor-build - A fast and space-efficient pre-filter for querying very large collections of nucleotide sequences.
=================================================================================================================

SYNOPSIS
    raptor build --input <file> --output <file> [--threads <number>] [--quiet]
    [--kmer <number>|--shape <01-pattern>] [--window <number>] [--fpr
    <number>] [--hash <number>] [--parts <number>] [--compressed]

DESCRIPTION
    Constructs a Raptor index.

    The input may be a layout file from raptor layout, a list of minimiser
    files produced from raptor prepare, or a file with a list of files to
    process.

OPTIONS

  General options
    --input (std::filesystem::path)
          A layout file from raptor layout, or a file containing file names.
          The file must contain at least one file path per line, with multiple
          paths being separated by a whitespace. Each line in the file
          corresponds to one bin. Valid extensions for the paths in the file
          are [minimiser] when using preprocessed input from raptor prepare,
          and [embl,fasta,fa,fna,ffn,faa,frn,fas,fastq,fq,genbank,gb,gbk,sam],
          possibly followed by [bz2,gz,bgzf]. The input file must exist and
          read permissions must be granted.
    --output (std::filesystem::path)
          A valid path for the output file. Write permissions must be granted.
    --threads (unsigned 8 bit integer)
          The number of threads to use. Default: 1. Value must be a positive
          integer.
    --quiet
          Do not print time and memory usage.

  k-mer options
    --kmer (unsigned 8 bit integer)
          The k-mer size. Default: 20, or read from layout file. Value must be
          in range [1,32].
    --window (unsigned 32 bit integer)
          The window size. Default: k-mer size. Value must be a positive
          integer.
    --shape (std::string)
          The shape to use for k-mers. Mutually exclusive with --kmer. Parsed
          from right to left. Default: 11111111111111111111 (a k-mer of size
          20), or read from layout file. Value must match the pattern '[01]+'.

  Index options
    --fpr (double)
          The false positive rate. Default: 0.050000, or read from layout
          file. Value must be in range [0.000000,1.000000].
    --hash (unsigned 64 bit integer)
          The number of hash functions to use. Default: 2, or read from layout
          file. Value must be in range [1,5].
    --parts (unsigned 8 bit integer)
          Splits the index in this many parts. Not available for the HIBF.
          Default: 1. Value must be a power of two.
    --compressed
          Build a compressed index.

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

EXAMPLES
    raptor build --input bins.list --kmer 19 --window 23 --fpr 0.05 --output
    raptor.index

    raptor build --input bins.list --shape 11011 --window 8 --output
    raptor.index

    raptor build --input bins.list --kmer 32 --window 32 --hash 3 --parts 4
    --output raptor.index

    raptor build --input minimiser.list --fpr 0.05 --output raptor.index

    raptor build --input raptor.layout --output raptor.index

    raptor build --input raptor.layout --fpr 0.05 --output raptor.index

VERSION
    Last update: Unavailable
    Raptor-build version: 3.0.1 (commit unavailable)
    Sharg version: 1.1.1
    SeqAn version: 3.3.0

URL
    https://github.com/seqan/raptor

LEGAL
    Raptor-build Copyright: BSD 3-Clause License
    Author: Enrico Seiler
    Contact: enrico.seiler@fu-berlin.de
    SeqAn Copyright: 2006-2023 Knut Reinert, FU-Berlin; released under the
    3-clause BSDL.
    In your academic works please cite: Raptor: A fast and space-efficient
    pre-filter for querying very large collections of nucleotide sequences;
    Enrico Seiler, Svenja Mehringer, Mitra Darvish, Etienne Turc, and Knut
    Reinert; iScience 2021 24 (7): 102782. doi:
    https://doi.org/10.1016/j.isci.2021.102782
    For full copyright and/or warranty information see --copyright.
```

## raptor_layout

### Tool Description
Raptor-layout - A fast and space-efficient pre-filter for querying very large collections of nucleotide sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/raptor:3.0.1--haf24da9_4
- **Homepage**: https://github.com/seqan/raptor
- **Package**: https://anaconda.org/channels/bioconda/packages/raptor/overview
- **Validation**: PASS

### Original Help Text
```text
Raptor-layout - A fast and space-efficient pre-filter for querying very large collections of nucleotide sequences.
==================================================================================================================

DESCRIPTION
    Computes an HIBF layout that tries to minimize the disk space consumption
    of the resulting index. The space is estimated using a k-mer count per
    user bin which represents the potential denisity in a technical bin in an
    interleaved Bloom filter. You can pass the resulting layout to raptor
    (https://github.com/seqan/raptor) to build the index and conduct queries.

OPTIONS

  Main options:
    --input-file (std::filesystem::path)
          The input must be a file containing paths to sequence data you wish
          to estimate; one filepath per line. If your file contains auxiliary
          information (e.g. species IDs), your file must be tab-separated.
          Example file:
          ```
          /absolute/path/to/file1.fasta
          /absolute/path/to/file2.fa.gz
          ```
    --kmer-size (unsigned 8 bit integer)
          The k-mer size influences the size estimates of the input. Choosing
          a k-mer size that is too small for your data will result in files
          appearing more similar than they really are. Likewise, a large k-mer
          size might miss out on certain similarities. For DNA sequences, a
          k-mer size between [16,32] has proven to work well. Default: 19.
    --tmax (unsigned 16 bit integer)
          Limits the number of technical bins on each level of the HIBF.
          Choosing a good tmax is not trivial. The smaller tmax, the more
          levels the layout needs to represent the data. This results in a
          higher space consumption of the index. While querying each
          individual level is cheap, querying many levels might also lead to
          an increased runtime. A good tmax is usually the square root of the
          number of user bins/samples rounded to the next multiple of 64. Note
          that your tmax will always be rounded to the next multiple of 64. At
          the expense of a longer runtime, you can enable the statistic mode
          that determines the best tmax for your data set. See the advanced
          option --determine-best-tmax Default: ≈sqrt(#samples).
    --num-hash-functions (unsigned 64 bit integer)
          The number of hash functions to use when building the HIBF from the
          resulting layout. This parameter is needed to correctly estimate the
          index size when computing the layout. Default: 2.
    --false-positive-rate (double)
          The false positive rate you aim for when building the HIBF from the
          resulting layout. This parameter is needed to correctly estimate the
          index size when computing the layout. Default: 0.05.
    --output-filename (std::filesystem::path)
          A file name for the resulting layout. Default: "binning.out".
    --threads (unsigned 64 bit integer)
          The number of threads to use. Currently, only merging of sketches is
          parallelized, so if the flag --disable-rearrangement is set,
          --threads will have no effect. Default: 1. Value must be in range
          [1,18446744073709551615].

  HyperLogLog Sketches:
    To improve the layout, you can estimate the sequence similarities using
    HyperLogLog sketches.
    --disable-estimate-union
          The sketches are used to estimate the sequence similarity among a
          set of user bins. This will improve the layout computation as
          merging user bins that do not increase technical bin sizes will be
          preferred. This may use more RAM and can be disabled in RAM-critical
          environments. Attention: Also disables rearrangement which depends
          on union estimations.
    --disable-rearrangement
          As a preprocessing step, rearranging the order of the given user
          bins based on their sequence similarity may lead to favourable small
          unions and thus a smaller index. Depending on the number of input
          samples (user bins), this may be time-consuming and can thus be
          disabled if a suboptimal layout is sufficient.

  Parameter Tweaking:
    --alpha (double)
          The layout algorithm optimizes the space consumption of the
          resulting HIBF but currently has no means of optimizing the runtime
          for querying such an HIBF. In general, the ratio of merged bins and
          split bins influences the query time because a merged bin always
          triggers another search on a lower level. To influence this ratio,
          alpha can be used. The higher alpha, the less merged bins are chosen
          in the layout. This improves query times but leads to a bigger
          index. Default: 1.2.
    --max-rearrangement-ratio (double)
          When the flag --disable-rearrangement is not set, this option can
          influence the rearrangement algorithm. The algorithm only rearranges
          the order of user bins in fixed intervals. The higher
          --max-rearrangement-ratio, the larger the intervals. This
          potentially improves the layout, but increases the runtime of the
          layout algorithm. Default: 0.5. Value must be in range
          [0.000000,1.000000].
    --sketch-bits (unsigned 8 bit integer)
          The number of bits the HyperLogLog sketch should use to distribute
          the values into bins. Default: 12. Value must be in range [5,32].

  Special options
    --determine-best-tmax
          When this flag is set, the program will compute multiple layouts for
          tmax in [64 , 128, 256, ... , tmax] as well as tmax=sqrt(#samples).
          The layout algorithm itself only optimizes the space consumption.
          When determining the best layout, we additionally keep track of the
          average number of queries needed to traverse each layout. This query
          cost is taken into account when determining the best tmax for your
          data. Note that the option --tmax serves as upper bound. Once the
          layout quality starts dropping, the computation is stopped. To run
          all layout computations, pass the flag --force-all-binnings.
    --force-all-binnings
          Forces all layouts up to --tmax to be computed, regardless of the
          layout quality. If the flag --determine-best-tmax is not set, this
          flag is ignored and has no effect.
    --output-sketches-to (std::filesystem::path)
          If you supply a directory path with this option, the hyperloglog
          sketches of your input will be stored in the respective path; one
          .hll file per input file. Default: None.

REFERENCES
    [1] Philippe Flajolet, Éric Fusy, Olivier Gandouet, Frédéric Meunier.
    HyperLogLog: the analysis of a near-optimal cardinality estimation
    algorithm. AofA: Analysis of Algorithms, Jun 2007, Juan les Pins, France.
    pp.137-156. hal-00406166v2, https://doi.org/10.46298/dmtcs.3545

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
    Last update: Unavailable
    Raptor-layout version: 3.0.1 (commit unavailable)
    Sharg version: 1.1.1
    SeqAn version: 3.3.0

URL
    https://github.com/seqan/raptor

LEGAL
    Raptor-layout Copyright: BSD 3-Clause License
    Author: Svenja Mehringer
    Contact: svenja.mehringer@fu-berlin.de
    SeqAn Copyright: 2006-2023 Knut Reinert, FU-Berlin; released under the
    3-clause BSDL.
    In your academic works please cite: Raptor: A fast and space-efficient
    pre-filter for querying very large collections of nucleotide sequences;
    Enrico Seiler, Svenja Mehringer, Mitra Darvish, Etienne Turc, and Knut
    Reinert; iScience 2021 24 (7): 102782. doi:
    https://doi.org/10.1016/j.isci.2021.102782
    For full copyright and/or warranty information see --copyright.
```

## raptor_prepare

### Tool Description
Raptor-prepare - A fast and space-efficient pre-filter for querying very large collections of nucleotide sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/raptor:3.0.1--haf24da9_4
- **Homepage**: https://github.com/seqan/raptor
- **Package**: https://anaconda.org/channels/bioconda/packages/raptor/overview
- **Validation**: PASS

### Original Help Text
```text
Raptor-prepare - A fast and space-efficient pre-filter for querying very large collections of nucleotide sequences.
===================================================================================================================

SYNOPSIS
    raptor prepare --input <file> --output <directory> [--threads <number>]
    [--quiet] [--kmer <number>|--shape <01-pattern>] [--window <number>]
    [--kmer-count-cutoff <number>|--use-filesize-dependent-cutoff]

DESCRIPTION
    Computes minimisers for the use with raptor layout and raptor build.

    Can continue where it left off after a crash or in multiple runs.

OPTIONS

  General options
    --input (std::filesystem::path)
          File containing file names. The file must contain at least one file
          path per line, with multiple paths being separated by a whitespace.
          Each line in the file corresponds to one bin. Valid extensions for
          the paths in the file are [minimiser] when using preprocessed input
          from raptor prepare, and
          [embl,fasta,fa,fna,ffn,faa,frn,fas,fastq,fq,genbank,gb,gbk,sam],
          possibly followed by [bz2,gz,bgzf]. The input file must exist and
          read permissions must be granted.
    --output (std::filesystem::path)
          A valid path for the output directory.
          Will create a minimiser.list inside the output directory. This file
          contains a list of generated minimiser files, in the same order as
          the input.
          When you manually delete a .in_progress file, also delete the
          corresponding .header and .minimiser file!
          Created output files for each file:
          *.header: Contains the shape, window size, cutoff and minimiser
          count.
          *.minimiser: Contains binary minimiser values, one minimiser per
          line.
          *.in_progress: Temporary file to track process. Deleted after
          finishing computation.
    --threads (unsigned 8 bit integer)
          The number of threads to use. Default: 1. Value must be a positive
          integer.
    --quiet
          Do not print time and memory usage.

  k-mer options
    --kmer (unsigned 8 bit integer)
          The k-mer size. Default: 20. Value must be in range [1,32].
    --window (unsigned 32 bit integer)
          The window size. Default: k-mer size. Value must be a positive
          integer.
    --shape (std::string)
          The shape to use for k-mers. Mutually exclusive with --kmer. Parsed
          from right to left. Default: 11111111111111111111 (a k-mer of size
          20). Value must match the pattern '[01]+'.

  Processing options
    --kmer-count-cutoff (unsigned 8 bit integer)
          Only store k-mers with at least (>=) x occurrences. Mutually
          exclusive with --use-filesize-dependent-cutoff. Default: 1. Value
          must be in range [1,254].
    --use-filesize-dependent-cutoff
          Apply cutoffs from Mantis(Pandey et al., 2018). Mutually exclusive
          with --kmer-count-cutoff.

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

EXAMPLES
    raptor prepare --input bins.list --output some_directory --kmer 20
    --window 24

    raptor prepare --input bins.list --output some_directory
    --kmer-count-cutoff 2

    raptor prepare --input bins.list --output some_directory
    --use-filesize-dependent-cutoff

VERSION
    Last update: Unavailable
    Raptor-prepare version: 3.0.1 (commit unavailable)
    Sharg version: 1.1.1
    SeqAn version: 3.3.0

URL
    https://github.com/seqan/raptor

LEGAL
    Raptor-prepare Copyright: BSD 3-Clause License
    Author: Enrico Seiler
    Contact: enrico.seiler@fu-berlin.de
    SeqAn Copyright: 2006-2023 Knut Reinert, FU-Berlin; released under the
    3-clause BSDL.
    In your academic works please cite: Raptor: A fast and space-efficient
    pre-filter for querying very large collections of nucleotide sequences;
    Enrico Seiler, Svenja Mehringer, Mitra Darvish, Etienne Turc, and Knut
    Reinert; iScience 2021 24 (7): 102782. doi:
    https://doi.org/10.1016/j.isci.2021.102782
    For full copyright and/or warranty information see --copyright.
```

## raptor_search

### Tool Description
Raptor-search - A fast and space-efficient pre-filter for querying very large collections of nucleotide sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/raptor:3.0.1--haf24da9_4
- **Homepage**: https://github.com/seqan/raptor
- **Package**: https://anaconda.org/channels/bioconda/packages/raptor/overview
- **Validation**: PASS

### Original Help Text
```text
Raptor-search - A fast and space-efficient pre-filter for querying very large collections of nucleotide sequences.
==================================================================================================================

SYNOPSIS
    raptor search --index <file> --query <file> --output <file> [--threads
    <number>] [--quiet] [--error <number>|--threshold <number>]
    [--query_length <number>] [--tau <number>] [--pmax <number>]
    [--cache-thresholds]

DESCRIPTION
    Queries a Raptor index.

OPTIONS

  General options
    --index (std::filesystem::path)
          Provide a valid path to an index. Parts: Without suffix _0
    --query (std::filesystem::path)
          Provide a path to the query file. The input file must exist and read
          permissions must be granted. Valid file extensions are
          [embl,fasta,fa,fna,ffn,faa,frn,fas,fastq,fq,genbank,gb,gbk,sam],
          possibly followed by [bz2,gz,bgzf].
    --output (std::filesystem::path)
          A valid path for the output file. Write permissions must be granted.
    --threads (unsigned 8 bit integer)
          The number of threads to use. Default: 1. Value must be a positive
          integer.
    --quiet
          Do not print time and memory usage.

  Threshold method options
    If no option is set, --error 0 will be used as default.
    Setting --query_length also skips validations associated with the query
    length, e.g., too long/short queries or a high variance in the query
    lengths. Notably, queries that are shorter than the window size result in
    undefined behavior.
    --error (unsigned 8 bit integer)
          The number of errors. Mutually exclusive with --threshold. Default:
          0. Value must be a positive integer or 0.
    --threshold (double)
          Ratio of k-mers that need to be found for a hit to occur. Mutually
          exclusive with --error. Default: None. Value must be in range [0,1].
    --query_length (unsigned 64 bit integer)
          The query length. Only influences the threshold when using --error.
          Enables skipping of the query length computation for both --error
          and --threshold. Default: Median of sequence lengths in query file.

  Dynamic thresholding options
    These option have no effect when using --threshold or k-mer size == window
    size.
    A higher threshold means that less, in the extreme case even false
    negative, results will be produced.
    A lower threshold means that more, possibly false positive, results will
    be produced.
    --tau (double)
          The higher tau, the lower the threshold. Default: 0.9999. Value must
          be in range [0,1].
    --p_max (double)
          The higher p_max, the lower the threshold. Default: 0.15. Value must
          be in range [0,1].
    --cache-thresholds
          Stores the computed thresholds with an unique name next to the
          index. In the next search call using this option, the stored
          thresholds are re-used. Two files are stored:
          threshold_*.bin: Depends on query_length, window, kmer/shape,
          errors, and tau.
          correction_*.bin: Depends on query_length, window, kmer/shape,
          p_max, and fpr.

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

EXAMPLES
    raptor search --index raptor.index --query queries.fastq --output
    search.output

    raptor search --index raptor.index --query queries.fastq --output
    search.output --threshold 0.7

    raptor search --index raptor.index --query queries.fastq --output
    search.output --error 2

    raptor search --index raptor.index --query queries.fastq --output
    search.output --error 2 --query_length 250

VERSION
    Last update: Unavailable
    Raptor-search version: 3.0.1 (commit unavailable)
    Sharg version: 1.1.1
    SeqAn version: 3.3.0

URL
    https://github.com/seqan/raptor

LEGAL
    Raptor-search Copyright: BSD 3-Clause License
    Author: Enrico Seiler
    Contact: enrico.seiler@fu-berlin.de
    SeqAn Copyright: 2006-2023 Knut Reinert, FU-Berlin; released under the
    3-clause BSDL.
    In your academic works please cite: Raptor: A fast and space-efficient
    pre-filter for querying very large collections of nucleotide sequences;
    Enrico Seiler, Svenja Mehringer, Mitra Darvish, Etienne Turc, and Knut
    Reinert; iScience 2021 24 (7): 102782. doi:
    https://doi.org/10.1016/j.isci.2021.102782
    For full copyright and/or warranty information see --copyright.
```

## raptor_upgrade

### Tool Description
Raptor-upgrade - A fast and space-efficient pre-filter for querying very large collections of nucleotide sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/raptor:3.0.1--haf24da9_4
- **Homepage**: https://github.com/seqan/raptor
- **Package**: https://anaconda.org/channels/bioconda/packages/raptor/overview
- **Validation**: PASS

### Original Help Text
```text
Raptor-upgrade - A fast and space-efficient pre-filter for querying very large collections of nucleotide sequences.
===================================================================================================================

SYNOPSIS
    raptor upgrade --input <file> --output <file> [--fpr <number>|--bins
    <file>]

DESCRIPTION
    Upgrades a Raptor index created with Raptor 2.0 to be compatible with
    Raptor 3.0.

    The only new parameter need is the false positive rate. The false positive
    rate affects the search results. This can be done in three different ways:

    1) Pass the false positive rate via --fpr.

    2) The false positive rate can be automatically determined if the paths of
    the files used to build the index are still available.

    3) Pass a file containing the path to the original files, one line per
    file. The false positive rate can then be automatically determined. The
    order of the files does not matter. The file with the most k-mers will
    determine the false positive rate.

OPTIONS
    --fpr (double)
          The false positive rate. Mutually exclusive with --bins. Default:
          None. Value must be in range [0.000000,1.000000].
    --bins (std::filesystem::path)
          File containing one file per line per bin. Mutually exclusive with
          --fpr. Default: None. The input file must exist and read permissions
          must be granted.
    --input (std::filesystem::path)
          The index to upgrade. Parts: Without suffix _0
    --output (std::filesystem::path)
          Path to new index.

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

EXAMPLES
    raptor upgrade --input old.index --output new.index

    raptor upgrade --input old.index --output new.index --fpr 0.05

    raptor upgrade --input old.index --output new.index --bins bins.list

VERSION
    Last update: Unavailable
    Raptor-upgrade version: 3.0.1 (commit unavailable)
    Sharg version: 1.1.1
    SeqAn version: 3.3.0

URL
    https://github.com/seqan/raptor

LEGAL
    Raptor-upgrade Copyright: BSD 3-Clause License
    Author: Enrico Seiler
    Contact: enrico.seiler@fu-berlin.de
    SeqAn Copyright: 2006-2023 Knut Reinert, FU-Berlin; released under the
    3-clause BSDL.
    In your academic works please cite: Raptor: A fast and space-efficient
    pre-filter for querying very large collections of nucleotide sequences;
    Enrico Seiler, Svenja Mehringer, Mitra Darvish, Etienne Turc, and Knut
    Reinert; iScience 2021 24 (7): 102782. doi:
    https://doi.org/10.1016/j.isci.2021.102782
    For full copyright and/or warranty information see --copyright.
```

## Metadata
- **Skill**: generated
