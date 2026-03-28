# guide-counter CWL Generation Report

## guide-counter_count

### Tool Description
Counts the guides observed in a CRISPR screen, starting from one or more FASTQs. FASTQs are one per sample and currently only single-end FASTQ inputs are supported.

### Metadata
- **Docker Image**: quay.io/biocontainers/guide-counter:0.1.3--h503566f_4
- **Homepage**: https://github.com/fulcrumgenomics/guide-counter
- **Package**: https://anaconda.org/channels/bioconda/packages/guide-counter/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/guide-counter/overview
- **Total Downloads**: 9.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/fulcrumgenomics/guide-counter
- **Stars**: N/A
### Original Help Text
```text
guide-counter-count 
Counts the guides observed in a CRISPR screen, starting from one or more FASTQs.  FASTQs are one per
sample and currently only single-end FASTQ inputs are supported.

A set of sample IDs may be provided using `--samples id1 id2 ..`.  If provided it must have the same
number of values as input FASTQs.  If not provided the FASTQ names are used minus any fastq/fq/gz
suffixes.

Automatically determines the range of valid offsets within the sequencing reads where the guide
sequences are located, independently for each FASTQ input.  The first `offset-sample-size` reads
from each FASTQ are examined to determine the offsets at which guides are found. When processing the
full FASTQ, checks only those offsets that accounted for at least `offset-min-fraction` of the first
`offset-sample-size` reads.

Matching by default allows for one mismatch (and no indels) between the read sub-sequence and the
expected guide sequences.  Exact matching may be enabled by specifying the `--exact-match` option.

Optionally lists may be provided of essential genes, nonessential genes and control guide ids, as
well as a regular expression to be used to identify control guides.  Using this information guides
are classified as either Essential, Nonessential, Control, or Other.

Three output files are generated.  The first is named `{output}.counts.txt` and contains columns for
the guide id, the gene targeted by the guide and one count column per input FASTQ with raw/un-
normalized counts.  The second, `{output}.extended-counts.txt` is identical to the first except for
having a `guide_type` column inserted as the third column.  Finally `{output}.stats.txt` contains
basic QC statistics per input FASTQ on the matching process.

USAGE:
    guide-counter count [OPTIONS] --input <INPUT>... --library <LIBRARY> --output <OUTPUT>

OPTIONS:
    -c, --control-guides <CONTROL_GUIDES>
            Optional path to file with list control guide IDs.  IDs should appear one per line and
            are case sensitive.  If the file has multiple tab-separated columns, the first column is
            used

    -C, --control-pattern <CONTROL_PATTERN>
            Optional regular expression used to ID control guides. Pattern is matched, case
            insensitive, to guide IDs and Gene names

    -e, --essential-genes <ESSENTIAL_GENES>
            Optional path to file with list of essential genes.  Gene names should appear one per
            line and are case sensitive. If the file has multiple tab-separated columns, the first
            column is used

    -f, --offset-min-fraction <OFFSET_MIN_FRACTION>
            After sampling the first `offset_sample_size` reads, use offsets that
            
            [default: 0.0025]

    -h, --help
            Print help information

    -i, --input <INPUT>...
            Input fastq file(s)

    -l, --library <LIBRARY>
            Path to the guide library metadata.  May be a tab- or comma-separated file.  Must have a
            header line, and the first three fields must be (in order): i) the ID of the guide, ii)
            the base sequence of the guide, iii) the gene the guide targets

    -n, --nonessential-genes <NONESSENTIAL_GENES>
            Optional path to file with list of nonessential genes.  Gene names should appear one per
            line and are case sensitive.  If the file has multiple tab-separated columns, the first
            column is used

    -N, --offset-sample-size <OFFSET_SAMPLE_SIZE>
            The number of reads to be examined when determining the offsets at which guides may be
            found in the input reads
            
            [default: 100000]

    -o, --output <OUTPUT>
            Path prefix to use for all output files

    -s, --samples <SAMPLES>...
            Sample names corresponding to the input fastqs. If provided must be the same length as
            input.  Otherwise will be inferred from input file names

    -x, --exact-match
            Perform exact matching only, don't allow mismatches between reads and guides
```


## guide-counter_FASTQs

### Tool Description
A tool for counting guide RNAs in FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/guide-counter:0.1.3--h503566f_4
- **Homepage**: https://github.com/fulcrumgenomics/guide-counter
- **Package**: https://anaconda.org/channels/bioconda/packages/guide-counter/overview
- **Validation**: PASS

### Original Help Text
```text
error: Found argument 'FASTQs' which wasn't expected, or isn't valid in this context

USAGE:
    guide-counter <SUBCOMMAND>

For more information try --help
```


## Metadata
- **Skill**: generated
