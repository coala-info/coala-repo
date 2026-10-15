# polypolish CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| polypolish_filter | PASS |  |
| polypolish_polish | PASS |  |

## polypolish_filter

### Tool Description
filter paired-end alignments based on insert size

### Metadata
- **Docker Image**: quay.io/biocontainers/polypolish:0.6.1--h3ab6199_0
- **Homepage**: https://github.com/rrwick/Polypolish
- **Package**: https://anaconda.org/channels/bioconda/packages/polypolish/overview
- **Validation**: PASS

### Original Help Text
```text
filter paired-end alignments based on insert size

Usage: polypolish filter [OPTIONS] --in1 <IN1> --in2 <IN2> --out1 <OUT1> --out2 <OUT2>

Options:
      --in1 <IN1>                  Input SAM file - first read in pairs
      --in2 <IN2>                  Input SAM file - first second in pairs
      --out1 <OUT1>                Output SAM file - first read in pairs
      --out2 <OUT2>                Output SAM file - first second in pairs
      --orientation <ORIENTATION>  Expected pair orientation [default: auto]
      --low <LOW>                  Low percentile threshold [default: 0.1]
      --high <HIGH>                High percentile threshold [default: 99.9]
  -h, --help                       Print help
  -V, --version                    Print version
```

## polypolish_polish

### Tool Description
polish a long-read assembly using short-read alignments

### Metadata
- **Docker Image**: quay.io/biocontainers/polypolish:0.6.1--h3ab6199_0
- **Homepage**: https://github.com/rrwick/Polypolish
- **Package**: https://anaconda.org/channels/bioconda/packages/polypolish/overview
- **Validation**: PASS

### Original Help Text
```text
polish a long-read assembly using short-read alignments

Usage: polypolish polish [OPTIONS] <ASSEMBLY> [SAM]...

Arguments:
  <ASSEMBLY>  Assembly to polish (one file in FASTA format)
  [SAM]...    Short read alignments (one or more files in SAM format)

Options:
      --debug <DEBUG>
          Optional file to store per-base information for debugging purposes
  -i, --fraction_invalid <FRACTION_INVALID>
          A base must make up less than this fraction of the read depth to be considered invalid
          [default: 0.2]
  -v, --fraction_valid <FRACTION_VALID>
          A base must make up at least this fraction of the read depth to be considered valid
          [default: 0.5]
  -m, --max_errors <MAX_ERRORS>
          Ignore alignments with more than this many mismatches and indels [default: 10]
  -d, --min_depth <MIN_DEPTH>
          A base must occur at least this many times in the pileup to be considered valid [default:
          5]
      --careful
          Ignore any reads with multiple alignments
  -h, --help
          Print help
  -V, --version
          Print version
```

