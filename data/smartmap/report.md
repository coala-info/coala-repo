# smartmap CWL Generation Report

## smartmap_SmartMapPrep

### Tool Description
SmartMapPrep prepares input files for SmartMap.

### Metadata
- **Docker Image**: quay.io/biocontainers/smartmap:1.0.0--h077b44d_4
- **Homepage**: http://shah-rohan.github.io/SmartMap
- **Package**: https://anaconda.org/channels/bioconda/packages/smartmap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/smartmap/overview
- **Total Downloads**: 4.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
SmartMapPrep [options] -x [Bowtie2 index] -o [output prefix] -1 [R1 fastq] -2 [R2 fastq]

Inputs (required):
-x Path to basename of Bowtie2 index for alignment
-o Output prefix prepended to the output files
-1 Fastq file for read mate 1 (can be gzipped)
-2 Fastq file for read mate 2 (can be gzipped)

Options:
-p Number of CPU threads to be used for multithreaded alignment (default: 1)
-I Minimum insert length (default: 100)
-L Maximum insert length (default: 250)
-k Maximum number of alignments reported (default: 51)
-s String to be removed from read names
```


## smartmap_SmartMapRNAPrep

### Tool Description
SmartMapRNAPrep [options] -x [Bowtie2 index] -o [output prefix] -1 [R1 fastq] -2 [R2 fastq]

### Metadata
- **Docker Image**: quay.io/biocontainers/smartmap:1.0.0--h077b44d_4
- **Homepage**: http://shah-rohan.github.io/SmartMap
- **Package**: https://anaconda.org/channels/bioconda/packages/smartmap/overview
- **Validation**: PASS

### Original Help Text
```text
SmartMapPrep [options] -x [Bowtie2 index] -o [output prefix] -1 [R1 fastq] -2 [R2 fastq]

Inputs (required):
-x Path to basename of Bowtie2 index for alignment
-o Output prefix prepended to the output files
-1 Fastq file for read mate 1 (can be gzipped)
-2 Fastq file for read mate 2 (can be gzipped)

Options:
-p Number of CPU threads to be used for multithreaded alignment (default: 1)
-k Maximum number of alignments reported (default: 51)
-s String to be removed from read names
```


## smartmap_SmartMap

### Tool Description
SmartMap for analysis of ambiguously mapping reads in next-generation sequencing.

### Metadata
- **Docker Image**: quay.io/biocontainers/smartmap:1.0.0--h077b44d_4
- **Homepage**: http://shah-rohan.github.io/SmartMap
- **Package**: https://anaconda.org/channels/bioconda/packages/smartmap/overview
- **Validation**: PASS

### Original Help Text
```text
SmartMap for analysis of ambiguously mapping reads in next-generation sequencing. Version 1.0.0.

Usage: SmartMap [options] [bed or bed.gz file input(s)]

Required options:
-g : Genome length file listing all chromosomes and lengths. Chromosomes will appear in this order in output file.
-o : Output prefix used for output bedgraph and log files.

Non-required options:
-i : Number of iterations. Default 1.
-m : Maximum number of alignments for a read to be processed. Default 50.
-s : Minimum score for Bowtie2 display. Default 0 (unscored).
-v : N for N-fold cross-validation. Default 1 (no cross-validation).
-c : Flag for continuous output bedgraphs. Default off.
-S : Flag for strand-specific mode. Default off.
-r : Flag for read output mode with weights. Default off.
-l : Rate of fitting in reweighting. Default 1.
-h : Display help message.

Developed by Rohan Shah (rohanshah@uchicago.edu).
```

