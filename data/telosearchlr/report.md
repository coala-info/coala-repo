# telosearchlr CWL Generation Report

## telosearchlr_TeloSearchLR.py

### Tool Description
TELOomeric repeat motif SEARCH using Long Reads

### Metadata
- **Docker Image**: quay.io/biocontainers/telosearchlr:1.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/gchchung/TeloSearchLR
- **Package**: https://anaconda.org/channels/bioconda/packages/telosearchlr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/telosearchlr/overview
- **Total Downloads**: 656
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/gchchung/TeloSearchLR
- **Stars**: N/A
### Original Help Text
```text
Missing or incorrect options. See below.

TeloSearchLR: TELOomeric repeat motif SEARCH using Long Reads
                
Version: 1.0.0   Contact: Dr. George Chung (gc95@nyu.edu)
                
Usage:   python /usr/local/bin/TeloSearchLR.py [options]
                
Options:
  Run modes:
    (default)                      "occupancy mode", repeat motifs ranked by occupancy
    -e --exhaustive                enable "exhaustive mode", motifs ranked by period AND occupancy
    -s --single_motif       STR    enable "single-motif mode", specify the motif whose occupancy is to be plotted
  Required for all modes:
    -f --fasta              STR    long-read sequencing library file name
    -n --num_of_nucleotides INT    number of nucleotides to plot motif occupancy
  Required for occupancy and exhaustive modes:
    -k --k_value            INT    shortest repeat period (>0) to consider by TideHunter
    -K --K_value            INT    longest repeat period (≥k) to consider by TideHunter
    -m --mth_pattern        INT    rank of the most frequent motif to plot (>0)
    -M --Mth_pattern        INT    rank of the least frequent motif to plot (≥m)
  Required for single-motif mode:
    -T --TideHunter         STR    a TideHunter (>=v1.5.4) tabular output
  Other options:
    -t --terminal           INT    terminal number of nucleotides to consider for ranking motif occupancy [1000]
    -c --cores              INT    number of threads to use for TideHunter [4]
    -p --path               STR    path of TideHunter (if not already in $PATH)
    -v --version                   display the version number and quit
    -h --help                      display this help message and quit
```

