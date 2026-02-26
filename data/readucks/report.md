# readucks CWL Generation Report

## readucks

### Tool Description
Readucks: a simple demuxing tool for nanopore data.

### Metadata
- **Docker Image**: quay.io/biocontainers/readucks:0.0.3--py_0
- **Homepage**: https://github.com/artic-network/readucks
- **Package**: https://anaconda.org/channels/bioconda/packages/readucks/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/readucks/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/artic-network/readucks
- **Stars**: N/A
### Original Help Text
```text
usage: readucks -i INPUT_PATH [-o OUTPUT_DIR] [-b] [-a] [-e] [-s] [-m MODE]
                [-p PREFIX] [-t THREADS] [-n NUM_READS_IN_BATCH]
                [--check_reads CHECK_READS]
                [--adapter_threshold ADAPTER_THRESHOLD] [-v VERBOSITY]
                [--require_two_barcodes] [--report_alternate_call]
                [--native_barcodes] [--pcr_barcodes] [--rapid_barcodes]
                [--limit_barcodes_to LIMIT_BARCODES_TO [LIMIT_BARCODES_TO ...]]
                [--threshold THRESHOLD]
                [--secondary_threshold SECONDARY_THRESHOLD]
                [--score_diff SCORE_DIFF] [--scoring_scheme SCORING_SCHEME]
                [-h] [--version]

Readucks: a simple demuxing tool for nanopore data.

Main options:
  -i INPUT_PATH, --input INPUT_PATH
                          FASTQ of input reads or a directory which will be
                          recursively searched for FASTQ files (required).
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                          Output directory (default: working directory)
  -b, --bin_barcodes      Reads will be binned based on their barcode and
                          saved to separate files. (default: False)
  -a, --annotate_files    Writes a CSV file for each input file containing
                          barcode calls for each read. (default: False)
  -e, --extended_info     Writes extended information about barcode calls.
                          (default: False)
  -s, --summary_info      Writes another file with information about barcode
                          calls. (default: False)
  -m MODE, --mode MODE    Demuxing mode, one of ["stringent","lenient",
                          "porechop"]. (default: porechop)
  -p PREFIX, --prefix PREFIX
                          Optional prefix to file names
  -t THREADS, --threads THREADS
                          The number of threads to use (1 to turn off
                          multithreading) (default: 2)
  -n NUM_READS_IN_BATCH, --num_reads_in_batch NUM_READS_IN_BATCH
                          The number of reads to process (and hold in memory)
                          at a time (default: 200)
  --check_reads CHECK_READS
                          Number of barcodes to classify before filtering
                          barcode set (default: 1000)
  --adapter_threshold ADAPTER_THRESHOLD
                          Identity required for a barcode to be included after
                          filtering (default: 90)
  -v VERBOSITY, --verbosity VERBOSITY
                          Level of output information: 0 = none, 1 = some, 2 =
                          lots (default: 1)

Demuxing options:
  --require_two_barcodes  Match barcodes at both ends of read (default single)
  --report_alternate_call
                          Reports double/single barcode call to csv in
                          single/double barcoding mode (default: False)
  --native_barcodes       Only attempts to match the 24 native barcodes
                          (default)
  --pcr_barcodes          Only attempts to match the 96 PCR barcodes (default:
                          False)
  --rapid_barcodes        Only attempts to match the 12 rapid barcodes
                          (default: False)
  --limit_barcodes_to LIMIT_BARCODES_TO [LIMIT_BARCODES_TO ...]
                          Specify a list of barcodes to look for (numbers
                          refer to native, PCR or rapid)

Barcode search settings:
  Settings for how to search for and call barcodes

  --threshold THRESHOLD   A read must have at least this percent identity to a
                          barcode (default: 75)
  --secondary_threshold SECONDARY_THRESHOLD
                          The second barcode must have at least this percent
                          identity (and match the first one) (default: 65)
  --score_diff SCORE_DIFF
                          The second barcode must have at least this percent
                          identity (and match the first one) (default: 5)
  --scoring_scheme SCORING_SCHEME
                          Comma-delimited string of alignment scores: match,
                          mismatch, gap open, gap extend (default: 3,-6,-5,-2)

Help:
  -h, --help              Show this help message and exit
  --version               Show program's version number and exit
```

