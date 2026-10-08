# fmlrc2 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| fmlrc2 | PASS | fixed output path, k-mer option and homepage; 21-mer match to the genome rose from 0.35 to 0.82 on nanopore reads |
| fmlrc2_convert | PASS |  |

## fmlrc2

### Tool Description
FM-index Long Read Corrector - Rust implementation

### Metadata
- **Docker Image**: quay.io/biocontainers/fmlrc2:0.1.8--h7f95895_0
- **Homepage**: https://github.com/HudsonAlpha/fmlrc2
- **Package**: https://anaconda.org/channels/bioconda/packages/fmlrc2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fmlrc2/overview
- **Total Downloads**: 12.5K
- **Last updated**: 2025-07-10
- **GitHub**: https://github.com/HudsonAlpha/fmlrc2
- **Stars**: N/A
### Original Help Text
```text
FMLRC2 0.1.8
J. Matthew Holt <jholt@hudsonalpha.org>
FM-index Long Read Corrector - Rust implementation

USAGE:
    fmlrc2 [FLAGS] [OPTIONS] <COMP_MSBWT.NPY> <LONG_READS.FA> <CORRECTED_READS.FA>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information
    -v, --verbose    enable verbose output

OPTIONS:
    -b, --begin_index <begin_id>           index of read to start with (default: 0)
    -B, --branch_factor <branch_factor>    branching factor for correction, scaled by k (default: 4.0)
    -C, --cache_size <cache_size>          the length of k-mer to precompute in cache (default: 8)
    -e, --end_index <end_id>               index of read to end with (default: end of file)
    -k, --K <kmer_sizes>...                k-mer sizes for correction, can be specified multiple times (default: "-k 21
                                           59")
    -m, --min_count <min_count>            absolute minimum k-mer count to consisder a path (default: 5)
    -f, --min_dynamic_count <min_frac>     dynamic minimum k-mer count fraction of median to consider a path (default:
                                           0.1)
    -t, --threads <threads>                number of correction threads (default: 1)

ARGS:
    <COMP_MSBWT.NPY>        The compressed BWT file with high accuracy reads
    <LONG_READS.FA>         The FASTX file with uncorrected reads
    <CORRECTED_READS.FA>    The FASTA file to write corrected reads to
```

## fmlrc2_convert

### Tool Description
FMLRC2 BWT converter: convert a raw BWT of short reads into the compressed multi-string BWT (.npy) used by fmlrc2.

### Metadata
- **Docker Image**: quay.io/biocontainers/fmlrc2:0.1.8--h7f95895_0
- **Homepage**: https://github.com/HudsonAlpha/fmlrc2
- **Package**: https://anaconda.org/channels/bioconda/packages/fmlrc2/overview
- **Validation**: PASS

### Original Help Text
```text
FMLRC2 BWT Converter 0.1.8
J. Matthew Holt <jholt@hudsonalpha.org>
FMLCR BWT Converter - Rust implementation

USAGE:
    fmlrc2-convert [OPTIONS] <COMP_MSBWT.NPY>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -i, --input <in_fn>    The raw BWT (default: stdin)

ARGS:
    <COMP_MSBWT.NPY>    The location to store the compressed BWT
```

