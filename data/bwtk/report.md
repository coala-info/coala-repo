# bwtk CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| bwtk_adjust | PASS |  |
| bwtk_bg2bw | PASS |  |
| bwtk_chroms | PASS |  |
| bwtk_merge | Failed | tool bug: bwtk 1.8.1 merge rounds values to integers (mean of 1.25 and 2.5 gives 2, not 1.875), fixed upstream in 1.8.2. |
| bwtk_score | PASS |  |
| bwtk_values | PASS |  |

## bwtk_bg2bw

### Tool Description
Convert a bedGraph file to bigWig

### Metadata
- **Docker Image**: quay.io/biocontainers/bwtk:1.8.1--h9990f68_0
- **Homepage**: https://github.com/bjmt/bwtk
- **Package**: https://anaconda.org/channels/bioconda/packages/bwtk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bwtk/overview
- **Total Downloads**: 793
- **Last updated**: 2025-11-16
- **GitHub**: https://github.com/bjmt/bwtk
- **Stars**: N/A

### Original Help Text
```text
bwtk v1.8.1  Copyright (C) 2025  Benjamin Jean-Marie Tremblay
bwtk bg2bw [options] -g <chrom.sizes> -i <file.bedGraph[.gz]> -o <file.bw>
    -i    Input bedGraph (can be gzipped), use '-' for stdin
    -o    Output bigWig
    -g    Genome chrom.sizes or genome.fa.fai file
    -p    Use a preset genome instead of -g [tair10]
    -u    When using -p, use UCSC-style names (default: Ensembl)
    -S    Ignore chromosomes found in bedGraph but not chrom.sizes
    -a    Add this value to scores [0]
    -m    Multiply scores by this value [1]
    -l    log10-transform scores
    -t    Trim values above this max [Inf]
    -s    Step size for binning [0]
    -h    Print this message and exit
Order of operations: a -> m -> l -> t -> s
```

## bwtk_adjust

### Tool Description
Perform an operation on a bigWig

### Metadata
- **Docker Image**: quay.io/biocontainers/bwtk:1.8.1--h9990f68_0
- **Homepage**: https://github.com/bjmt/bwtk
- **Package**: https://anaconda.org/channels/bioconda/packages/bwtk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bwtk/overview
- **Total Downloads**: 793
- **Last updated**: 2025-11-16
- **GitHub**: https://github.com/bjmt/bwtk
- **Stars**: N/A

### Original Help Text
```text
bwtk v1.8.1  Copyright (C) 2025  Benjamin Jean-Marie Tremblay
bwtk adjust [options] -i <in.bw> -o <out.bw>
    -i    Input bigWig file
    -o    Output bigWig file
    -B    Output as bedGraph.gz ('-o-' for ungzipped stdout)
    -b    Subset to ranges in a BED file ('-' for stdin)
    -r    Subset to a single range (chrName:X-Y)
    -a    Add this value to scores [0]
    -m    Multiply scores by this value [1]
    -l    log10-transform scores
    -t    Trim values above this max [Inf]
    -s    Step size for binning [0]
    -h    Print this message and exit
Order of operations: a -> m -> l -> t -> s
```

## bwtk_merge

### Tool Description
Average multiple bigWig files together

### Metadata
- **Docker Image**: quay.io/biocontainers/bwtk:1.8.1--h9990f68_0
- **Homepage**: https://github.com/bjmt/bwtk
- **Package**: https://anaconda.org/channels/bioconda/packages/bwtk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bwtk/overview
- **Total Downloads**: 793
- **Last updated**: 2025-11-16
- **GitHub**: https://github.com/bjmt/bwtk
- **Stars**: N/A

### Original Help Text
```text
bwtk v1.8.1  Copyright (C) 2025  Benjamin Jean-Marie Tremblay
bwtk merge [options] -o <out.bw> <file1.bw> <file2.bw> [...]
    -o    Output bigWig
    -B    Output as bedGraph.gz ('-o-' for ungzipped stdout)
    -S    Sum values instead of averaging
    -M    Take the max value instead of averaging
    -n    Take the min value instead of averaging
    -a    Add this value to scores [0]
    -m    Multiply scores by this value [1]
    -l    log10-transform scores
    -t    Trim values above this max [Inf]
    -s    Step size for binning [0]
    -h    Print this message and exit
Order of operations: avg|sum|max|min -> a -> m -> l -> t -> s
```

## bwtk_values

### Tool Description
Return bigWig values from overlapping BED ranges

### Metadata
- **Docker Image**: quay.io/biocontainers/bwtk:1.8.1--h9990f68_0
- **Homepage**: https://github.com/bjmt/bwtk
- **Package**: https://anaconda.org/channels/bioconda/packages/bwtk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bwtk/overview
- **Total Downloads**: 793
- **Last updated**: 2025-11-16
- **GitHub**: https://github.com/bjmt/bwtk
- **Stars**: N/A

### Original Help Text
```text
bwtk v1.8.1  Copyright (C) 2025  Benjamin Jean-Marie Tremblay
bwtk values [options] -i <file.bw> -b <ranges.bed> -o <values.tsv>
    -i    Input bigWig
    -b    BED file with ranges to extract values from ('-' for stdin)
    -o    Output values in TSV format (use '-' for stdout)
    -s    Desired size of ranges, will be resized from the centre
    -l    Resize ranges from the left with -s (based on strand)
    -r    Resize ranges from the right with -s (based on strand)
    -h    Print this message and exit
```

## bwtk_score

### Tool Description
Get summary scores of bigWig values from BED ranges

### Metadata
- **Docker Image**: quay.io/biocontainers/bwtk:1.8.1--h9990f68_0
- **Homepage**: https://github.com/bjmt/bwtk
- **Package**: https://anaconda.org/channels/bioconda/packages/bwtk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bwtk/overview
- **Total Downloads**: 793
- **Last updated**: 2025-11-16
- **GitHub**: https://github.com/bjmt/bwtk
- **Stars**: N/A

### Original Help Text
```text
bwtk v1.8.1  Copyright (C) 2025  Benjamin Jean-Marie Tremblay
bwtk score [options] -i <file.bw> -o <scores.tsv>
    -i    Input bigWig
    -o    Output scores in TSV format (use '-' for stdout)
    -b    BED file to score, otherwise scores chromosomes ('-' for stdin)
    -B    Return a BED instead with this stat in the score column
    -h    Print this message and exit
```

## bwtk_chroms

### Tool Description
Print a chrom.sizes file from a bigWig header

### Metadata
- **Docker Image**: quay.io/biocontainers/bwtk:1.8.1--h9990f68_0
- **Homepage**: https://github.com/bjmt/bwtk
- **Package**: https://anaconda.org/channels/bioconda/packages/bwtk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bwtk/overview
- **Total Downloads**: 793
- **Last updated**: 2025-11-16
- **GitHub**: https://github.com/bjmt/bwtk
- **Stars**: N/A

### Original Help Text
```text
bwtk v1.8.1  Copyright (C) 2025  Benjamin Jean-Marie Tremblay
bwtk chroms [options] -i <file.bw> -o <chrom.sizes>
    -i    Input bigWig
    -o    Output chrom.sizes file (use '-' for stdout)
    -h    Print this message and exit
```

