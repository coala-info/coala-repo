# segmentation-fold CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| segmentation-fold | Failed | tool bug: -f folds only the first record of a multi-FASTA file (also on stdin); -s works (85 nt K-turn RNA: 2 segments, -60.91 kcal/mole); fixed -p to take 1/0 and the homepage |
| segmentation-fold_utils_add_read_counts | PASS | repo test output matches the expected file (read counts 20, 1, 2); only the BAM path text in headers differs because of staging |
| segmentation-fold_utils_estimate_energy | PASS | repo XML test gives a 7-line dbn file with transition energies, as the repo test expects |
| segmentation-fold_utils_extract_boxed_sequences | PASS | repo tests 1 and 3 (--max-inner-dist 90 and 10) output identical to the expected files; staged the FASTA writable so pysam can build its index |
| segmentation-fold_utils_filter_annotated_entries | PASS | repo test gives the expected overlapping and non-overlapping dbn files; only the bed path text in one header differs because of staging |
| segmentation-fold_utils_filter_by_energy | PASS | repo test with --energy 0 gives both output files identical to the expected ones |
| segmentation-fold_utils_find_boxes | PASS | repo genome test with both strands gives a bed file identical to the expected one; staged the FASTA writable so pysam can build its index |
| segmentation-fold_utils_fix_fasta_headers | PASS | repo test output identical to the expected FASTA |

## segmentation-fold

### Tool Description
Calculates RNA secondary structure and folding parameters.

### Metadata
- **Docker Image**: quay.io/biocontainers/segmentation-fold:1.7.0--py27_0
- **Homepage**: https://github.com/yhoogstrate/segmentation-fold
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/segmentation-fold/overview
- **Total Downloads**: 13.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/yhoogstrate/segmentation-fold
- **Stars**: N/A
### Original Help Text
```text
Usage: segmentation-fold -s [SEQUENCE]
       segmentation-fold -f [FASTA_FILE]
   * Note: If FASTA_FILE and SEQUENCE are not provided,
           the program will read from STDIN.


The following parameters can be used:
  -s SEQUENCE       Specific RNA SEQUENCE (overrules -f)
  -f FASTA_FILE     Path of FASTA_FILE containing sequence(s)
  -p                Enable/disable segment functionality           [1/0]
  -H HAIRPINSIZE    Minimum hairpin size, default: 3               [1,N}
  -x SEGMENTS_XML   Use custom  "segments.xml"-syntaxed file
  -t NUM_THREADS    Number of threads; 0 = maximum available,      [0,N}
                    default: 3 

  -h, --help        Display this help and exit
  -V, --version     Show version and license
  -X, --default-xml Show path to default "segments.xml" on
                    system


If you encounter problems with this software, please report it at:
   <https://github.com/yhoogstrate/segmentation-fold/issues>
```


## segmentation-fold_utils_add_read_counts

### Tool Description
segmentation-fold-utils add-read-counts

### Metadata
- **Docker Image**: quay.io/biocontainers/segmentation-fold:1.7.0--py27_0
- **Homepage**: https://github.com/yhoogstrate/segmentation-fold
- **Package**: https://anaconda.org/channels/bioconda/packages/segmentation-fold/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: segmentation-fold-utils add-read-counts [OPTIONS] DBN_INPUT_FILE
                                               BAM_INPUT_FILE DBN_OUTPUT_FILE

Options:
  -r, --regex TEXT  Regex to capture the targeted location in DBN file
                    (default: '>.*?(chr[^:]):([0-9]+)-([0-9]+)' )
  --help            Show this message and exit.
```

## segmentation-fold_utils_estimate_energy

### Tool Description
segmentation-fold-utils estimate-energy

### Metadata
- **Docker Image**: quay.io/biocontainers/segmentation-fold:1.7.0--py27_0
- **Homepage**: https://github.com/yhoogstrate/segmentation-fold
- **Package**: https://anaconda.org/channels/bioconda/packages/segmentation-fold/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: segmentation-fold-utils estimate-energy [OPTIONS] DBN_OUTPUT_FILE

Options:
  -t, --temp-dir PATH             Ppath in which temporary conifig files will
                                  be stored (default: /tmp)
  -s, --segmentation-fold TEXT    Location of segmentatio-fold binary
                                  (default: segmentation-fold)
  -x, --xml-file FILENAME         Location of segments.xml (default:
                                  /usr/local/share/segmentation-
                                  fold/segments.xml)
  -T, --threads INTEGER           Number of threads per spawned instance of
                                  segmentation-fold
  -p, --precision FLOAT           Minimal difference for binary split - the
                                  smaller this value the slower. if this value
                                  equals 0, the difference is set to infinity
                                  (default: 0.05)
  -r, --randomize INTEGER         Shuffle each sequence this many times and
                                  predict energy of shuffled sequence(s)
                                  (default: 0, 0 means disabled)
  -f, --sequences-from-fasta-file PATH
                                  Use sequences from a FASTA file instead of
                                  using the XML file that also contains the
                                  segments. In XML files you can explicitly
                                  link one Segment(Loop) to one particular
                                  sequence instead of doing n*n comparisons
                                  (default: None)
  --help                          Show this message and exit.
```

## segmentation-fold_utils_extract_boxed_sequences

### Tool Description
segmentation-fold-utils extract-boxed-sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/segmentation-fold:1.7.0--py27_0
- **Homepage**: https://github.com/yhoogstrate/segmentation-fold
- **Package**: https://anaconda.org/channels/bioconda/packages/segmentation-fold/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: segmentation-fold-utils extract-boxed-sequences [OPTIONS]
                                                       FASTA_INPUT_FILE
                                                       BED_INPUT_FILE
                                                       FASTA_OUTPUT_FILE

Options:
  -d, --max-inner-dist INTEGER  Maximal distance between the boxes
                                (default=250bp)
  -e, --bp-extension INTEGER    Extend extracted sequences with this number of
                                bases (default: 10bp)
  --help                        Show this message and exit.
```

## segmentation-fold_utils_filter_annotated_entries

### Tool Description
segmentation-fold-utils filter-annotated-entries

### Metadata
- **Docker Image**: quay.io/biocontainers/segmentation-fold:1.7.0--py27_0
- **Homepage**: https://github.com/yhoogstrate/segmentation-fold
- **Package**: https://anaconda.org/channels/bioconda/packages/segmentation-fold/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: segmentation-fold-utils filter-annotated-entries [OPTIONS]
                                                        DBN_INPUT_FILE
                                                        BED_INPUT_FILE DBN_OUT
                                                        PUT_FILE_OVERLAPPING D
                                                        BN_OUTPUT_FILE_NON_OVE
                                                        RLAPPING

Options:
  -r, --regex TEXT  Regex to capture the targeted location in DBN file
                    (default: '>.*?(chr[^:]):([0-9]+)-([0-9]+)' )
  --help            Show this message and exit.
```

## segmentation-fold_utils_filter_by_energy

### Tool Description
segmentation-fold-utils filter-by-energy

### Metadata
- **Docker Image**: quay.io/biocontainers/segmentation-fold:1.7.0--py27_0
- **Homepage**: https://github.com/yhoogstrate/segmentation-fold
- **Package**: https://anaconda.org/channels/bioconda/packages/segmentation-fold/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: segmentation-fold-utils filter-by-energy [OPTIONS] DBN_INPUT_FILE DBN_O
                                                UTPUT_FILE_LARGER_OR_EQUAL
                                                DBN_OUTPUT_FILE_SMALLER

Options:
  -e, --energy FLOAT  Entries with transitions with energy smaller than energy
                      (< e) or without transitions will be put into
                      DBN_OUTPUT_FILE_LARGER_OR_EQUAL and those larger or
                      equal (>= e) to DBN_OUTPUT_FILE_SMALLER
  --help              Show this message and exit.
```

## segmentation-fold_utils_find_boxes

### Tool Description
segmentation-fold-utils find-boxes

### Metadata
- **Docker Image**: quay.io/biocontainers/segmentation-fold:1.7.0--py27_0
- **Homepage**: https://github.com/yhoogstrate/segmentation-fold
- **Package**: https://anaconda.org/channels/bioconda/packages/segmentation-fold/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: segmentation-fold-utils find-boxes [OPTIONS] FASTA_INPUT_FILE
                                          BED_OUTPUT_FILE

Options:
  -c, --box1 TEXT           Sequence of box1 (default = C-box: 'NRUGAUG')
  -d, --box2 TEXT           Sequence of box2 (default = D-box: 'CUGA')
  --forward / --no-forward  Search in the forward direction of the reference
                            sequence
  --reverse / --no-reverse  Search in the reverse complement of the reference
                            sequence
  --help                    Show this message and exit.
```

## segmentation-fold_utils_fix_fasta_headers

### Tool Description
segmentation-fold-utils fix-fasta-headers

### Metadata
- **Docker Image**: quay.io/biocontainers/segmentation-fold:1.7.0--py27_0
- **Homepage**: https://github.com/yhoogstrate/segmentation-fold
- **Package**: https://anaconda.org/channels/bioconda/packages/segmentation-fold/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: segmentation-fold-utils fix-fasta-headers [OPTIONS] FASTA_INPUT_FILE
                                                 FASTA_OUTPUT_FILE

Options:
  --help  Show this message and exit.
```

## Metadata
- **Skill**: generated
