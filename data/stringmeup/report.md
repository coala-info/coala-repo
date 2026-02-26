# stringmeup CWL Generation Report

## stringmeup

### Tool Description
A post-processing tool to reclassify Kraken 2 output based on the confidence score and/or minimum minimizer hit groups.

### Metadata
- **Docker Image**: quay.io/biocontainers/stringmeup:0.1.5--pyhdfd78af_0
- **Homepage**: https://github.com/danisven/StringMeUp
- **Package**: https://anaconda.org/channels/bioconda/packages/stringmeup/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/stringmeup/overview
- **Total Downloads**: 14.4K
- **Last updated**: 2025-11-13
- **GitHub**: https://github.com/danisven/StringMeUp
- **Stars**: N/A
### Original Help Text
```text
usage: stringmeup --names <FILE> --nodes <FILE> [--output_report <FILE>] [--output_classifications <FILE>] [--output_verbose <FILE>] [--keep_unclassified] [--minimum_hit_groups INT] [--gz_output] [--help] confidence classifications

A post-processing tool to reclassify Kraken 2 output based on the confidence
score and/or minimum minimizer hit groups.

positional arguments:
  confidence            The confidence score threshold to be used in
                        reclassification [0-1].
  classifications       Path to the Kraken 2 output file containing the
                        individual read classifications.

options:
  -h, --help            show this help message and exit
  --output_report FILE  File to save the Kraken 2 report in.
  --output_classifications FILE
                        File to save the Kraken 2 read classifications in.
  --keep_unclassified   Specify if you want to output unclassified reads in
                        addition to classified reads. NOTE(!): This script
                        will always discard reads that are unclassified in the
                        classifications input file, this flag will just make
                        sure to keep previously classified reads even if they
                        are reclassified as unclassified by this script.
                        TIP(!): Always run Kraken2 with no confidence cutoff.
  --output_verbose FILE
                        File to send verbose output to. This file will
                        contain, for each read, (1) original classification,
                        (2) new classification, (3) original confidence, (4),
                        new confidence (5), original taxa name (6), new taxa
                        name, (7) original rank, (8) new rank, (9) distance
                        travelled (how many nodes was it lifted upwards in the
                        taxonomy).
  --names FILE          Taxonomy names dump file (names.dmp)
  --nodes FILE          Taxonomy nodes dump file (nodes.dmp)
  --minimum_hit_groups INT
                        The minimum number of hit groups a read needs to be
                        classified. NOTE: You need to supply a classifications
                        file (kraken2 output) that contain the
                        "minimizer_hit_groups" column.
  --gz_output           Set this flag to output <output_classifications> and
                        <output_verbose> in gzipped format (will add .gz
                        extension to the filenames).
```

