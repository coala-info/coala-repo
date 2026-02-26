# shortcut CWL Generation Report

## shortcut_ShortCut

### Tool Description
ShortCut

### Metadata
- **Docker Image**: quay.io/biocontainers/shortcut:1.0--hdfd78af_0
- **Homepage**: https://github.com/Aez35/ShortCut
- **Package**: https://anaconda.org/channels/bioconda/packages/shortcut/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/shortcut/overview
- **Total Downloads**: 262
- **Last updated**: 2025-06-25
- **GitHub**: https://github.com/Aez35/ShortCut
- **Stars**: N/A
### Original Help Text
```text
── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
✔ dplyr     1.1.4     ✔ readr     2.1.5
✔ forcats   1.0.0     ✔ stringr   1.5.1
✔ lubridate 1.9.4     ✔ tibble    3.3.0
✔ purrr     1.0.4     ✔ tidyr     1.3.1
── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
✖ dplyr::filter() masks stats::filter()
✖ dplyr::lag()    masks stats::lag()
ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
Checking required modules...
Requires package bowtie : /usr/local/bin/bowtie
Requires package samtools : /usr/local/bin/samtools
Requires package RNAfold : /usr/local/bin/RNAfold
Requires package cutadapt : /usr/local/bin/cutadapt
usage: ShortCut [-h] -fastq [FASTQ ...] [-n N] [-m M] [-threads THREADS]
                -kingdom {plant,animal} [-annotate [ANNOTATE]] [-out OUT]
                [-genome GENOME] [-known_mirnas KNOWN_MIRNAS] [-ssout SSOUT]
                [-trimkey TRIMKEY] [-dn_mirna DN_MIRNA]

options:
  -h, --help            show this help message and exit
  -fastq [FASTQ ...]    One or more fastq alignment files
  -n N                  Results file name
  -m M                  Minimum length of reads for Cutadapt
  -threads THREADS      Specify number of threads for samtools
  -kingdom {plant,animal}
                        Specify animal or plant
  -annotate [ANNOTATE]  Specify whether you want ShortStack to annotate
  -out OUT              output directory
  -genome GENOME        Genome for annotation
  -known_mirnas KNOWN_MIRNAS
                        FASTA-formatted file of known mature miRNA sequences
  -ssout SSOUT          output directory
  -trimkey TRIMKEY      Abundant miRNA used to find adapters for trimming with
                        option -autotrim
  -dn_mirna DN_MIRNA    De novo miRNA search in ShortStack
```

