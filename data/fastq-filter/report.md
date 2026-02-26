# fastq-filter CWL Generation Report

## fastq-filter

### Tool Description
Filter FASTQ files on various metrics.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastq-filter:0.3.0--py312h0fa9677_4
- **Homepage**: https://github.com/LUMC/fastq-filter
- **Package**: https://anaconda.org/channels/bioconda/packages/fastq-filter/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fastq-filter/overview
- **Total Downloads**: 29.4K
- **Last updated**: 2025-04-29
- **GitHub**: https://github.com/LUMC/fastq-filter
- **Stars**: N/A
### Original Help Text
```text
usage: fastq-filter [-h] [-o OUTPUT] [-l MIN_LENGTH] [-L MAX_LENGTH]
                    [-e AVERAGE_ERROR_RATE] [-q MEAN_QUALITY]
                    [-Q MEDIAN_QUALITY] [-c COMPRESSION_LEVEL] [--verbose]
                    [--quiet]
                    input [input ...]

Filter FASTQ files on various metrics.

positional arguments:
  input                 Input FASTQ files. Compression format automatically
                        detected. Use - for stdin.

options:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Output FASTQ files. Compression format automatically
                        determined by file extension. Flag can be used
                        multiple times. An output must be given for each
                        input. Default: stdout.
  -l MIN_LENGTH, --min-length MIN_LENGTH
                        The minimum length for a read.
  -L MAX_LENGTH, --max-length MAX_LENGTH
                        The maximum length for a read.
  -e AVERAGE_ERROR_RATE, --average-error-rate AVERAGE_ERROR_RATE
                        The minimum average per base error rate.
  -q MEAN_QUALITY, --mean-quality MEAN_QUALITY
                        Average quality. Same as the '--average-error-rate'
                        option but specified with a phred score. I.e '-q 30'
                        is equivalent to '-e 0.001'.
  -Q MEDIAN_QUALITY, --median-quality MEDIAN_QUALITY
                        The minimum median phred score.
  -c COMPRESSION_LEVEL, --compression-level COMPRESSION_LEVEL
                        Compression level for the output files. Relevant when
                        output files have a .gz extension. Default: 2
  --verbose             Report stats on individual filters.
  --quiet               Turn of logging output.
```

