# fasten CWL Generation Report

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


## Metadata
- **Skill**: generated
