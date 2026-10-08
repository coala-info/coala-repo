# fasten CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| fasten_fasten_clean | PASS |  |
| fasten_fasten_combine | PASS |  |
| fasten_fasten_convert | PASS |  |
| fasten_fasten_deshuffle | PASS |  |
| fasten_fasten_head | PASS |  |
| fasten_fasten_inspect | PASS |  |
| fasten_fasten_kmer | PASS |  |
| fasten_fasten_metrics | PASS |  |
| fasten_fasten_mutate | PASS |  |
| fasten_fasten_normalize | PASS |  |
| fasten_fasten_quality_filter | PASS |  |
| fasten_fasten_randomize | PASS |  |
| fasten_fasten_regex | PASS |  |
| fasten_fasten_repair | PASS |  |
| fasten_fasten_replace | PASS |  |
| fasten_fasten_sample | PASS |  |
| fasten_fasten_shuffle | PASS |  |
| fasten_fasten_sort | PASS |  |
| fasten_fasten_straighten | PASS |  |
| fasten_fasten_trim | PASS |  |

## fasten_fasten_metrics

### Tool Description
Gives read metrics on a read set.

### Metadata
- **Docker Image**: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
- **Homepage**: https://github.com/lskatz/fasten
- **Package**: https://anaconda.org/channels/bioconda/packages/fasten/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fasten/overview
- **Total Downloads**: 26.8K
- **Last updated**: 2025-10-26
- **GitHub**: https://github.com/lskatz/fasten
- **Stars**: N/A
### Original Help Text
```text
fasten_metrics: Gives read metrics on a read set.

Usage: fasten_metrics [-h] [-n INT] [-p] [--verbose] [--version] [--each-read]

Options:
    -h, --help          Print this help menu.
    -n, --numcpus INT   Number of CPUs (default: 1)
    -p, --paired-end    The input reads are interleaved paired-end
        --verbose       Print more status messages
        --version       Print the version of Fasten and exit
        --each-read     Print the metrics for each read. This creates very
                        large output
```


## fasten_fasten_shuffle

### Tool Description
Interleaves reads from either stdin or file parameters

### Metadata
- **Docker Image**: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
- **Homepage**: https://github.com/lskatz/fasten
- **Package**: https://anaconda.org/channels/bioconda/packages/fasten/overview
- **Validation**: PASS

### Original Help Text
```text
fasten_shuffle: Interleaves reads from either stdin or file parameters

Usage: fasten_shuffle [-h] [-n INT] [-p] [--verbose] [--version] [-d] [-1 1.fastq] [-2 2.fastq]

Options:
    -h, --help          Print this help menu.
    -n, --numcpus INT   Number of CPUs (default: 1)
    -p, --paired-end    The input reads are interleaved paired-end
        --verbose       Print more status messages
        --version       Print the version of Fasten and exit
    -d, --deshuffle     Deshuffle reads from stdin
    -1 1.fastq          Forward reads. If deshuffling, reads are written to
                        this file.
    -2 2.fastq          Forward reads. If deshuffling, reads are written to
                        this file.
```


## fasten_fasten_trim

### Tool Description
Blunt-end trims using 0-based coordinates

### Metadata
- **Docker Image**: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
- **Homepage**: https://github.com/lskatz/fasten
- **Package**: https://anaconda.org/channels/bioconda/packages/fasten/overview
- **Validation**: PASS

### Original Help Text
```text
fasten_trim: Blunt-end trims using 0-based coordinates

Usage: fasten_trim [-h] [-n INT] [-p] [--verbose] [--version] [-f INT] [-l INT] [-a path/to/file.fa]

Options:
    -h, --help          Print this help menu.
    -n, --numcpus INT   Number of CPUs (default: 1)
    -p, --paired-end    The input reads are interleaved paired-end
        --verbose       Print more status messages
        --version       Print the version of Fasten and exit
    -f, --first-base INT
                        The first base to keep (default: 0)
    -l, --last-base INT The last base to keep (default: 0)
    -a, --adapterseqs path/to/file.fa
                        fasta file of adapters
```


## fasten_fasten_clean

### Tool Description
Trims and filters reads

### Metadata
- **Docker Image**: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
- **Homepage**: https://github.com/lskatz/fasten
- **Package**: https://anaconda.org/channels/bioconda/packages/fasten/overview
- **Validation**: PASS

### Original Help Text
```text
fasten_clean: Trims and filters reads

Usage: fasten_clean [-h] [-n INT] [-p] [--verbose] [--version] [--min-length INT] [--min-avg-quality FLOAT] [--min-trim-quality INT]

Options:
    -h, --help          Print this help menu.
    -n, --numcpus INT   Number of CPUs (default: 1)
    -p, --paired-end    The input reads are interleaved paired-end
        --verbose       Print more status messages
        --version       Print the version of Fasten and exit
        --min-length INT
                        Minimum length for each read in bp
        --min-avg-quality FLOAT
                        Minimum average quality for each read
        --min-trim-quality INT
                        Trim the edges of each read until a nucleotide of at
                        least X quality is found
```


## fasten_fasten_sample

### Tool Description
Downsample your reads

### Metadata
- **Docker Image**: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
- **Homepage**: https://github.com/lskatz/fasten
- **Package**: https://anaconda.org/channels/bioconda/packages/fasten/overview
- **Validation**: PASS

### Original Help Text
```text
fasten_sample: Downsample your reads

Usage: fasten_sample [-h] [-n INT] [-p] [--verbose] [--version] [-f FLOAT]

Options:
    -h, --help          Print this help menu.
    -n, --numcpus INT   Number of CPUs (default: 1)
    -p, --paired-end    The input reads are interleaved paired-end
        --verbose       Print more status messages
        --version       Print the version of Fasten and exit
    -f, --frequency FLOAT
                        Frequency of sequences to print, 0 to 1. Default: 1
```


## fasten_fasten_randomize

### Tool Description
Create random reads from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
- **Homepage**: https://github.com/lskatz/fasten
- **Package**: https://anaconda.org/channels/bioconda/packages/fasten/overview
- **Validation**: PASS

### Original Help Text
```text
fasten_randomize: Create random reads from stdin.

Usage: fasten_randomize [-h] [-n INT] [-p] [--verbose] [--version]

Options:
    -h, --help          Print this help menu.
    -n, --numcpus INT   Number of CPUs (default: 1)
    -p, --paired-end    The input reads are interleaved paired-end
        --verbose       Print more status messages
        --version       Print the version of Fasten and exit
```


## fasten_fasten_regex

### Tool Description
Filter reads based on a regular expression.

### Metadata
- **Docker Image**: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
- **Homepage**: https://github.com/lskatz/fasten
- **Package**: https://anaconda.org/channels/bioconda/packages/fasten/overview
- **Validation**: PASS

### Original Help Text
```text
fasten_regex: Filter reads based on a regular expression.

Usage: fasten_regex [-h] [-n INT] [-p] [--verbose] [--version] [-r STRING] [-w String]

Options:
    -h, --help          Print this help menu.
    -n, --numcpus INT   Number of CPUs (default: 1)
    -p, --paired-end    The input reads are interleaved paired-end
        --verbose       Print more status messages
        --version       Print the version of Fasten and exit
    -r, --regex STRING  Regular expression (default: '.')
    -w, --which String  Which field to match on? ID, SEQ, QUAL. Default: SEQ
```


## fasten_fasten_quality_filter

### Tool Description
Transforms any low-quality base to 'N'.

### Metadata
- **Docker Image**: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
- **Homepage**: https://github.com/lskatz/fasten
- **Package**: https://anaconda.org/channels/bioconda/packages/fasten/overview
- **Validation**: PASS

### Original Help Text
```text
fasten_quality_filter: Transforms any low-quality base to 'N'.

Usage: fasten_quality_filter [-h] [-n INT] [-p] [--verbose] [--version] [-m INT]

Options:
    -h, --help          Print this help menu.
    -n, --numcpus INT   Number of CPUs (default: 1)
    -p, --paired-end    The input reads are interleaved paired-end
        --verbose       Print more status messages
        --version       Print the version of Fasten and exit
    -m, --max-quality INT
                        The maximum quality at which a base will be
                        transformed to 'N'
```


## fasten_fasten_repair

### Tool Description
Repairs reads

### Metadata
- **Docker Image**: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
- **Homepage**: https://github.com/lskatz/fasten
- **Package**: https://anaconda.org/channels/bioconda/packages/fasten/overview
- **Validation**: PASS

### Original Help Text
```text
fasten_repair: Repairs reads

Usage: fasten_repair [-h] [-n INT] [-p] [--verbose] [--version] [--min-length INT] [--min-quality FLOAT] [--remove-info] [-m STRING]

Options:
    -h, --help          Print this help menu.
    -n, --numcpus INT   Number of CPUs (default: 1)
    -p, --paired-end    The input reads are interleaved paired-end
        --verbose       Print more status messages
        --version       Print the version of Fasten and exit
        --min-length INT
                        Minimum read length allowed
        --min-quality FLOAT
                        Minimum quality allowed
        --remove-info   Remove fasten_inspect headers
    -m, --mode STRING   Either repair or panic. If panic, then the binary will
                        panic when the first issue comes up. Default:repair
```


## fasten_fasten_inspect

### Tool Description
Marks up your reads with useful information like read length

### Metadata
- **Docker Image**: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
- **Homepage**: https://github.com/lskatz/fasten
- **Package**: https://anaconda.org/channels/bioconda/packages/fasten/overview
- **Validation**: PASS

### Original Help Text
```text
fasten_inspect: Marks up your reads with useful information like read length

Usage: fasten_inspect [-h] [-n INT] [-p] [--verbose] [--version]

Options:
    -h, --help          Print this help menu.
    -n, --numcpus INT   Number of CPUs (default: 1)
    -p, --paired-end    The input reads are interleaved paired-end
        --verbose       Print more status messages
        --version       Print the version of Fasten and exit
```


## fasten_fasten_kmer

### Tool Description
Counts kmers.

### Metadata
- **Docker Image**: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
- **Homepage**: https://github.com/lskatz/fasten
- **Package**: https://anaconda.org/channels/bioconda/packages/fasten/overview
- **Validation**: PASS

### Original Help Text
```text
fasten_kmer: Counts kmers.

Usage: fasten_kmer [-h] [-n INT] [-p] [--verbose] [--version] [-k INT] [-r] [-m]

Options:
    -h, --help          Print this help menu.
    -n, --numcpus INT   Number of CPUs (default: 1)
    -p, --paired-end    The input reads are interleaved paired-end
        --verbose       Print more status messages
        --version       Print the version of Fasten and exit
    -k, --kmer-length INT
                        The size of the kmer (default: 21)
    -r, --revcomp       Count kmers on the reverse complement strand too
    -m, --remember-reads 
                        Add reads to subsequent columns. Each read begins with
                        the kmer. Only lists reads in the forward direction.
```


## fasten_fasten_straighten

### Tool Description
Convert a fastq file to a standard 4-lines-per-entry format

### Metadata
- **Docker Image**: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
- **Homepage**: https://github.com/lskatz/fasten
- **Package**: https://anaconda.org/channels/bioconda/packages/fasten/overview
- **Validation**: PASS

### Original Help Text
```text
fasten_straighten: Convert a fastq file to a standard 4-lines-per-entry format

Usage: fasten_straighten [-h] [-n INT] [-p] [--verbose] [--version]

Options:
    -h, --help          Print this help menu.
    -n, --numcpus INT   Number of CPUs (default: 1)
    -p, --paired-end    The input reads are interleaved paired-end
        --verbose       Print more status messages
        --version       Print the version of Fasten and exit
```


## fasten_fasten_combine

### Tool Description
Collapse identical reads into single reads, recalculating quality values.

### Metadata
- **Docker Image**: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
- **Homepage**: https://github.com/lskatz/fasten
- **Package**: https://anaconda.org/channels/bioconda/packages/fasten/overview
- **Validation**: PASS

### Original Help Text
```text
fasten_combine: Collapse identical reads into single reads, recalculating quality values. If paired end, then each set of reads must be identical to be collapsed. Warning: due to multiple reads collapsing into one, read identifiers will be reconstituted. NOTE: range of quality scores is !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHI

Usage: fasten_combine [-h] [-n INT] [-p] [--verbose] [--version] [--max-qual-char CHAR] [--min-qual-char CHAR]

Options:
    -h, --help          Print this help menu.
    -n, --numcpus INT   Number of CPUs (default: 1)
    -p, --paired-end    The input reads are interleaved paired-end
        --verbose       Print more status messages
        --version       Print the version of Fasten and exit
        --max-qual-char CHAR
                        Maximum quality character (default: I)
        --min-qual-char CHAR
                        Minimum quality character (default: !)
```

## fasten_fasten_convert

### Tool Description
Converts between sequence formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
- **Homepage**: https://github.com/lskatz/fasten
- **Package**: https://anaconda.org/channels/bioconda/packages/fasten/overview
- **Validation**: PASS

### Original Help Text
```text
fasten_convert: Converts between sequence formats.

Usage: fasten_convert [-h] [-n INT] [-p] [--verbose] [--version] [-i FORMAT] [-o FORMAT]

Options:
    -h, --help          Print this help menu.
    -n, --numcpus INT   Number of CPUs (default: 1)
    -p, --paired-end    The input reads are interleaved paired-end
        --verbose       Print more status messages
        --version       Print the version of Fasten and exit
    -i, --in-format FORMAT
                        The input format for stdin. FORMAT can be: fastq,
                        fasta, sam.
    -o, --out-format FORMAT
                        The output format for stdin. See --in-format for
                        FORMAT options.
```

## fasten_fasten_deshuffle

### Tool Description
Deshuffle interleaved reads from stdin into two FASTQ files (fasten_shuffle --deshuffle).

### Metadata
- **Docker Image**: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
- **Homepage**: https://github.com/lskatz/fasten
- **Package**: https://anaconda.org/channels/bioconda/packages/fasten/overview
- **Validation**: PASS

### Original Help Text
```text
fasten_shuffle: Interleaves reads from either stdin or file parameters

Usage: fasten_shuffle [-h] [-n INT] [-p] [--verbose] [--version] [-d] [-1 1.fastq] [-2 2.fastq]

Options:
    -h, --help          Print this help menu.
    -n, --numcpus INT   Number of CPUs (default: 1)
    -p, --paired-end    The input reads are interleaved paired-end
        --verbose       Print more status messages
        --version       Print the version of Fasten and exit
    -d, --deshuffle     Deshuffle reads from stdin
    -1 1.fastq          Forward reads. If deshuffling, reads are written to
                        this file.
    -2 2.fastq          Forward reads. If deshuffling, reads are written to
                        this file.
```

## fasten_fasten_head

### Tool Description
Keep first N reads or bases

### Metadata
- **Docker Image**: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
- **Homepage**: https://github.com/lskatz/fasten
- **Package**: https://anaconda.org/channels/bioconda/packages/fasten/overview
- **Validation**: PASS

### Original Help Text
```text
fasten_head: Keep first N reads or bases

Usage: fasten_head [-h] [-n INT] [-p] [--verbose] [--version] [-r INT] [-b INT]

Options:
    -h, --help          Print this help menu.
    -n, --numcpus INT   Number of CPUs (default: 1)
    -p, --paired-end    The input reads are interleaved paired-end
        --verbose       Print more status messages
        --version       Print the version of Fasten and exit
    -r, --reads INT     Number of reads or pairs of reads to keep, default: 10
    -b, --bases INT     Number of bases to keep, default: 0 (zero for no
                        limit).
```

## fasten_fasten_mutate

### Tool Description
Introduces point mutations randomly.

### Metadata
- **Docker Image**: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
- **Homepage**: https://github.com/lskatz/fasten
- **Package**: https://anaconda.org/channels/bioconda/packages/fasten/overview
- **Validation**: PASS

### Original Help Text
```text
fasten_mutate: Introduces point mutations randomly. There is no 
evolutionary model; multiple hits are allowed. Therefore, 
the number of SNPs through --snps is an upper 
limit.

Usage: fasten_mutate [-h] [-n INT] [-p] [--verbose] [--version] [-s INT] [-m]

Options:
    -h, --help          Print this help menu.
    -n, --numcpus INT   Number of CPUs (default: 1)
    -p, --paired-end    The input reads are interleaved paired-end
        --verbose       Print more status messages
        --version       Print the version of Fasten and exit
    -s, --snps INT      Maximum number of SNPs (point mutations) to include
                        per read.
    -m, --mark          lowercase all reads but uppercase the SNPs (not yet
                        implemented)
```

## fasten_fasten_normalize

### Tool Description
Normalizes reads based on kmer coverage.

### Metadata
- **Docker Image**: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
- **Homepage**: https://github.com/lskatz/fasten
- **Package**: https://anaconda.org/channels/bioconda/packages/fasten/overview
- **Validation**: PASS

### Original Help Text
```text
fasten_normalize: Normalizes reads based on kmer coverage.

Usage: fasten_normalize [-h] [-n INT] [-p] [--verbose] [--version] [-t INT]

Options:
    -h, --help          Print this help menu.
    -n, --numcpus INT   Number of CPUs (default: 1)
    -p, --paired-end    The input reads are interleaved paired-end
        --verbose       Print more status messages
        --version       Print the version of Fasten and exit
    -t, --target-depth INT
                        The target depth of kmer.
```

## fasten_fasten_replace

### Tool Description
Streaming editor for fastq data using a find/replace.

### Metadata
- **Docker Image**: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
- **Homepage**: https://github.com/lskatz/fasten
- **Package**: https://anaconda.org/channels/bioconda/packages/fasten/overview
- **Validation**: PASS

### Original Help Text
```text
fasten_replace: Streaming editor for fastq data using a find/replace.

Usage: fasten_replace [-h] [-n INT] [-p] [--verbose] [--version] [-f STRING] [-r STRING] [-w STRING]

Options:
    -h, --help          Print this help menu.
    -n, --numcpus INT   Number of CPUs (default: 1)
    -p, --paired-end    The input reads are interleaved paired-end
        --verbose       Print more status messages
        --version       Print the version of Fasten and exit
    -f, --find STRING   Regular expression (default: '.')
    -r, --replace STRING
                        String to replace each match
    -w, --which STRING  Which field to match on? ID, SEQ, QUAL. Default: SEQ
```

## fasten_fasten_sort

### Tool Description
Sort reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
- **Homepage**: https://github.com/lskatz/fasten
- **Package**: https://anaconda.org/channels/bioconda/packages/fasten/overview
- **Validation**: PASS

### Original Help Text
```text
fasten_sort: Sort reads. This can be useful for many things including checksums and reducing gzip file sizes. Remember to use --paired-end if applicable.

Usage: fasten_sort [-h] [-n INT] [-p] [--verbose] [--version] [-s STRING] [-k STRING] [-r] [-c INT]

Options:
    -h, --help          Print this help menu.
    -n, --numcpus INT   Number of CPUs (default: 1)
    -p, --paired-end    The input reads are interleaved paired-end
        --verbose       Print more status messages
        --version       Print the version of Fasten and exit
    -s, --sort-by STRING
                        Sort by either SEQ, MINIMIZER, GC, or ID. If GC, then
                        the entries are sorted by GC percentage. SEQ and ID
                        are alphabetically sorted.
    -k, --kmer-length STRING
                        Length of kmer if using minimizers
    -r, --reverse       Reverse sort
    -c, --chunk-size INT
                        If > 0, then chunks of reads or pairs will be sorted
                        instead of the whole set. This is useful for streaming
                        large files. Default: 0
```

## Metadata
- **Skill**: generated
