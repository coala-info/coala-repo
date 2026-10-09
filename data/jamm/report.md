# jamm CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| jamm_JAMM.sh | Failed | image problem: peak calling stops with the R error 'EXPR must be a length 1 vector' from mclust (checkModelName) on real ChIP-seq reads, and the peak file is empty |
| jamm_SignalGenerator.sh | PASS |  |

## jamm_JAMM.sh

### Tool Description
Welcome to JAMM v1.0.7rev5 (GNU GPLv3). Copyright (C) 2014-2020  Mahmoud Ibrahim.

This program comes with ABSOLUTELY NO WARRANTY; for details visit http://www.gnu.org/licenses/gpl.html. This is free software, and you are welcome to redistribute it under certain conditions; visit http://www.gnu.org/licenses/gpl.html for details.

### Metadata
- **Docker Image**: quay.io/biocontainers/jamm:1.0.8.0--hdfd78af_1
- **Homepage**: https://github.com/mahmoudibrahim/JAMM
- **Package**: https://anaconda.org/channels/bioconda/packages/jamm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/jamm/overview
- **Total Downloads**: 27.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mahmoudibrahim/JAMM
- **Stars**: N/A
### Original Help Text
```text
Welcome to JAMM v1.0.7rev5 (GNU GPLv3). Copyright (C) 2014-2020  Mahmoud Ibrahim.

This program comes with ABSOLUTELY NO WARRANTY; for details visit http://www.gnu.org/licenses/gpl.html. This is free software, and you are welcome to redistribute it under certain conditions; visit http://www.gnu.org/licenses/gpl.html for details.

OPTIONS:
   -s      directory containing Sample files (required)
   -g      Genome size file (required)
   -o      Output directory (required)
   -c      directory containing input or Control files
   -f      Fragment length(s) (default: estimated)
   -r      Resolution, peak or region or window (default: peak)
   -m      Mode, normal or narrow (default: normal)
   -i      clustering Initialization window selection, deterministic or stochastic (default: deterministic)
   -b	   Bin Size (default: estimated)
   -w      minimum Window size (default: 2 --- Note: this means minimum_window_size = bin_size x the_value_of_-w)
   -e	   window Enrichment cutoff, auto or any numeric value (default: 1 --- Set this to "auto" to estimate the window enrichment cutoff)
   -d	   keep PCR Dupicates in single-end mode, y or n (default: n --- if -t is "paired", this option has no effect) 
   -t	   Type, single or paired (default: single, requires BED files. paired requires BEDPE files)
   -p	   Number of processors used by R scripts (default: 1)
   -T      Directory where the temporary working repository will be created. This directory will be deleted after JAMM is done (default: a new directory is created in /tmp folder).
```

## jamm_SignalGenerator.sh

### Tool Description
JAMM Signal Generator Script: generates read signal tracks for given regions from sample (and control) read files.

### Metadata
- **Docker Image**: quay.io/biocontainers/jamm:1.0.8.0--hdfd78af_1
- **Homepage**: https://github.com/mahmoudibrahim/JAMM
- **Package**: https://anaconda.org/channels/bioconda/packages/jamm/overview
- **Validation**: PASS

### Original Help Text
```text
Welcome to JAMM v1.0.7rev5 Signal Generator Script (GNU GPLv3). Copyright (C) 2014-2019  Mahmoud Ibrahim.

This program comes with ABSOLUTELY NO WARRANTY; for details visit http://www.gnu.org/licenses/gpl.html. This is free software, and you are welcome to redistribute it under certain conditions; visit http://www.gnu.org/licenses/gpl.html for details.

OPTIONS:
   -s      Directory containing sample files (required)
   -g      Genome size file (required)
   -o      Output Directory (required)
   -c      directory containing input or Control files
   -r 	   file with Regions to get signal for (required)
   -b      Bin size for signal generation (default: 10)
   -f      Fragment lengths (required if -t is "single")
   -p	   Number of processors used by R scripts (default: 1)
   -t	   Alignment type, paired or single (default: single)
   -n	   Normalization method, chromAverage or depth (default: chromAverage)
```

