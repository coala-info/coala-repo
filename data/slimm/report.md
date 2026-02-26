# slimm CWL Generation Report

## slimm

### Tool Description
Species Level Identification of Microbes from Metagenomes

### Metadata
- **Docker Image**: quay.io/biocontainers/slimm:0.3.4--hd6d6fdc_6
- **Homepage**: https://github.com/seqan/slimm/blob/master/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/slimm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/slimm/overview
- **Total Downloads**: 6.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/seqan/slimm
- **Stars**: N/A
### Original Help Text
```text
slimm - Species Level Identification of Microbes from Metagenomes
=================================================================

SYNOPSIS
    slimm [OPTIONS] "DB" "IN"

DESCRIPTION
    SLIMM Species Level Identification of Microbes from Metagenomes

    See  http://www.seqan.de/projects/slimm  for more information.

    (c) Copyright 2014-2017 by Temesgen H. Dadi.

REQUIRED ARGUMENTS
    DB INPUT_FILE
          Valid filetype is: .sldb.
    IN INPUT_PREFIX

OPTIONS
    -h, --help
          Display the help message.
    --version-check BOOL
          Turn this option off to disable version update notifications of the
          application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO.
          Default: 1.
    --version
          Display version information.
    -o, --output-prefix OUTPUT_PREFIX
          output path prefix.
    -w, --bin-width INTEGER
          Set the width of a single bin in neuclotides. Default: 0.
    -mr, --min-reads INTEGER
          Minimum number of matching reads to consider a reference present.
          Default: 0.
    -r, --rank STRING
          The taxonomic rank of identification One of strains, species, genus,
          family, order, class, phylum, and superkingdom. Default: species.
    -cc, --cov-cut-off DOUBLE
          the quantile of coverages to use as a cutoff smaller value means
          bigger threshold. In range [0.0..1.0]. Default: 0.95.
    -ac, --abundance-cut-off DOUBLE
          do not report abundances below this value In range [0.0..10.0].
          Default: 0.01.
    -d, --directory
          Input is a directory.
    -ro, --raw-output
          Output raw reference statstics
    -co, --coverage-output
          Output raw coverage statstics
    -v, --verbose
          Enable verbose output.

EXAMPLES
    slimm -o slimm_reports/ slimm_db_5K.sldb example.bam
          get taxonomic profile from "example.bam" and write it to a tsv file
          under "slimm_reports/" directory.
    slimm -d -o slimm_reports/ slimm_db_5K.sldb example-dir/
          get taxonomic profiles from individual SAM/BAM files located under
          "example-dir/" and write them to tsv files under "slimm_reports/"
          directory with their corsponding file names.

VERSION
    Last update: Dec 10 2024
    slimm version: 0.3.4
    SeqAn version: 2.4.0
```

