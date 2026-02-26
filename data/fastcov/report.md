# fastcov CWL Generation Report

## fastcov

### Tool Description
Plot the coverage based on some bam files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastcov:0.1.3--hdfd78af_0
- **Homepage**: https://github.com/RaverJay/fastcov
- **Package**: https://anaconda.org/channels/bioconda/packages/fastcov/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fastcov/overview
- **Total Downloads**: 193
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/RaverJay/fastcov
- **Stars**: N/A
### Original Help Text
```text
usage: fastcov [-h] [-p POSITION] [-l] [-o OUTPUT_FILE] [-c CSV_OUT]
               [--csv_no_header]
               bamfile [bamfile ...]

Plot the coverage based on some bam files.

positional arguments:
  bamfile               Alignment files to include in the coverage plot.

optional arguments:
  -h, --help            show this help message and exit
  -p POSITION, --position POSITION
                        Specify a genomic position to plot exclusively.
                        Format: <ref_name>[:<start>-<stop>] Coordinates are
                        1-based and inclusive. Start and/or stop are optional
                        with fallbacks 1 and <length_of_ref> respectively
                        (i.e. 'chr1', 'chr1:-200', 'chr1:100-' and
                        'chr1:100-200 are legal)
  -l, --logscale        Use logarithmic scale on y-axis.
  -o OUTPUT_FILE, --output_file OUTPUT_FILE
                        Specify plot output filename. File extension defines
                        the format (default: fastcov_output.pdf)
  -c CSV_OUT, --csv_out CSV_OUT
                        Specify csv data output filename. Use '-' to write to
                        stdout. Will disable plot output by default, specify
                        --output_file to re-enable plot output.
  --csv_no_header       Suppress column names in csv output.
```

