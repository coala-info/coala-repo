# poretools CWL Generation Report

## poretools_combine

### Tool Description
Combine FAST5 files into a TAR archive.

### Metadata
- **Docker Image**: quay.io/biocontainers/poretools:0.6.1a0--py27_0
- **Homepage**: https://github.com/arq5x/poretools
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/poretools/overview
- **Total Downloads**: 43.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/arq5x/poretools
- **Stars**: N/A
### Original Help Text
```text
usage: poretools combine [-h] [-q] -o STRING FILES [FILES ...]

positional arguments:
  FILES        The input FAST5 files.

optional arguments:
  -h, --help   show this help message and exit
  -q, --quiet  Do not output warnings to stderr
  -o STRING    The name of the output TAR archive for the set of FAST5 files.
```


## poretools_fastq

### Tool Description
Extract FASTQ data from FAST5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/poretools:0.6.1a0--py27_0
- **Homepage**: https://github.com/arq5x/poretools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: poretools fastq [-h] [-q] [--type STRING] [--start START_TIME]
                       [--end END_TIME] [--min-length MIN_LENGTH]
                       [--max-length MAX_LENGTH] [--high-quality]
                       [--normal-quality] [--group GROUP]
                       FILES [FILES ...]

positional arguments:
  FILES                 The input FAST5 files.

optional arguments:
  -h, --help            show this help message and exit
  -q, --quiet           Do not output warnings to stderr
  --type STRING         Which type of FASTQ entries should be reported?
                        Def.=all
  --start START_TIME    Only report reads from after start timestamp
  --end END_TIME        Only report reads from before end timestamp
  --min-length MIN_LENGTH
                        Minimum read length for FASTQ entry to be reported.
  --max-length MAX_LENGTH
                        Maximum read length for FASTQ entry to be reported.
  --high-quality        Only report reads with more complement events than
                        template.
  --normal-quality      Only report reads with fewer complement events than
                        template.
  --group GROUP         Base calling group serial number to extract, default
                        000
```


## poretools_fasta

### Tool Description
Extract FASTA sequences from FAST5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/poretools:0.6.1a0--py27_0
- **Homepage**: https://github.com/arq5x/poretools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: poretools fasta [-h] [-q] [--type STRING] [--start START_TIME]
                       [--end END_TIME] [--min-length MIN_LENGTH]
                       [--max-length MAX_LENGTH] [--high-quality]
                       [--normal-quality] [--group GROUP]
                       FILES [FILES ...]

positional arguments:
  FILES                 The input FAST5 files.

optional arguments:
  -h, --help            show this help message and exit
  -q, --quiet           Do not output warnings to stderr
  --type STRING         Which type of FASTQ entries should be reported?
                        Def.=all
  --start START_TIME    Only report reads from after start timestamp
  --end END_TIME        Only report reads from before end timestamp
  --min-length MIN_LENGTH
                        Minimum read length for FASTA entry to be reported.
  --max-length MAX_LENGTH
                        Maximum read length for FASTA entry to be reported.
  --high-quality        Only report reads with more complement events than
                        template.
  --normal-quality      Only report reads with fewer complement events than
                        template.
  --group GROUP         Base calling group serial number to extract, default
                        000
```


## poretools_stats

### Tool Description
Calculate and report statistics from FAST5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/poretools:0.6.1a0--py27_0
- **Homepage**: https://github.com/arq5x/poretools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: poretools stats [-h] [-q] [--type STRING] [--full-tsv]
                       FILES [FILES ...]

positional arguments:
  FILES          The input FAST5 files.

optional arguments:
  -h, --help     show this help message and exit
  -q, --quiet    Do not output warnings to stderr
  --type STRING  Which type of FASTQ entries should be reported? Def.=all
  --full-tsv     Verbose output in tab-separated format.
```


## poretools_hist

### Tool Description
Generate histograms of read lengths from FAST5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/poretools:0.6.1a0--py27_0
- **Homepage**: https://github.com/arq5x/poretools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: poretools hist [-h] [-q] [--min-length MIN_LENGTH]
                      [--max-length MAX_LENGTH] [--num-bins NUM_BINS]
                      [--saveas STRING] [--theme-bw] [--watch]
                      FILES [FILES ...]

positional arguments:
  FILES                 The input FAST5 files.

optional arguments:
  -h, --help            show this help message and exit
  -q, --quiet           Do not output warnings to stderr
  --min-length MIN_LENGTH
                        Minimum read length to be included in histogram.
  --max-length MAX_LENGTH
                        Maximum read length to be included in histogram.
  --num-bins NUM_BINS   The number of histogram bins.
  --saveas STRING       Save the plot to a file.
  --theme-bw            Use a black and white theme.
  --watch               Monitor a directory.
```


## poretools_events

### Tool Description
Report pre-basecalled events

### Metadata
- **Docker Image**: quay.io/biocontainers/poretools:0.6.1a0--py27_0
- **Homepage**: https://github.com/arq5x/poretools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: poretools events [-h] [-q] [--pre-basecalled] FILES [FILES ...]

positional arguments:
  FILES             The input FAST5 files.

optional arguments:
  -h, --help        show this help message and exit
  -q, --quiet       Do not output warnings to stderr
  --pre-basecalled  Report pre-basecalled events
```


## poretools_readstats

### Tool Description
Calculate and display read statistics from FAST5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/poretools:0.6.1a0--py27_0
- **Homepage**: https://github.com/arq5x/poretools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: poretools readstats [-h] [-q] FILES [FILES ...]

positional arguments:
  FILES        The input FAST5 files.

optional arguments:
  -h, --help   show this help message and exit
  -q, --quiet  Do not output warnings to stderr
```


## poretools_tabular

### Tool Description
Report FASTA entries from FAST5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/poretools:0.6.1a0--py27_0
- **Homepage**: https://github.com/arq5x/poretools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: poretools tabular [-h] [-q] [--type STRING] FILES [FILES ...]

positional arguments:
  FILES          The input FAST5 files.

optional arguments:
  -h, --help     show this help message and exit
  -q, --quiet    Do not output warnings to stderr
  --type STRING  Which type of FASTA entries should be reported? Def.=all
```


## poretools_nucdist

### Tool Description
Calculate nucleotide distribution from FAST5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/poretools:0.6.1a0--py27_0
- **Homepage**: https://github.com/arq5x/poretools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: poretools nucdist [-h] [-q] FILES [FILES ...]

positional arguments:
  FILES        The input FAST5 files.

optional arguments:
  -h, --help   show this help message and exit
  -q, --quiet  Do not output warnings to stderr
```


## poretools_metadata

### Tool Description
Report metadata from FAST5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/poretools:0.6.1a0--py27_0
- **Homepage**: https://github.com/arq5x/poretools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: poretools metadata [-h] [-q] [--read] FILES [FILES ...]

positional arguments:
  FILES        The input FAST5 files.

optional arguments:
  -h, --help   show this help message and exit
  -q, --quiet  Do not output warnings to stderr
  --read       Report read level metadata
```


## poretools_index

### Tool Description
Index FAST5 files for faster access.

### Metadata
- **Docker Image**: quay.io/biocontainers/poretools:0.6.1a0--py27_0
- **Homepage**: https://github.com/arq5x/poretools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: poretools index [-h] [-q] FILES [FILES ...]

positional arguments:
  FILES        The input FAST5 files.

optional arguments:
  -h, --help   show this help message and exit
  -q, --quiet  Do not output warnings to stderr
```


## poretools_qualdist

### Tool Description
Calculate and plot quality score distribution for Nanopore sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/poretools:0.6.1a0--py27_0
- **Homepage**: https://github.com/arq5x/poretools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: poretools qualdist [-h] [-q] FILES [FILES ...]

positional arguments:
  FILES        The input FAST5 files.

optional arguments:
  -h, --help   show this help message and exit
  -q, --quiet  Do not output warnings to stderr
```


## poretools_qualpos

### Tool Description
Analyze read quality and position in FAST5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/poretools:0.6.1a0--py27_0
- **Homepage**: https://github.com/arq5x/poretools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: poretools qualpos [-h] [-q] [--min-length MIN_LENGTH]
                         [--max-length MAX_LENGTH] [--bin-width BIN_WIDTH]
                         [--type STRING] [--start START_TIME] [--end END_TIME]
                         [--high-quality] [--saveas STRING]
                         FILES [FILES ...]

positional arguments:
  FILES                 The input FAST5 files.

optional arguments:
  -h, --help            show this help message and exit
  -q, --quiet           Do not output warnings to stderr
  --min-length MIN_LENGTH
                        Minimum read length to be included in analysis.
  --max-length MAX_LENGTH
                        Maximum read length to be included in analysis.
  --bin-width BIN_WIDTH
                        The width of bins (default: 1000 bp).
  --type STRING         Which type of reads should be analyzed? Def.=all,
                        choices=[all, fwd, rev, 2D, fwd,rev, best]
  --start START_TIME    Only analyze reads from after start timestamp
  --end END_TIME        Only analyze reads from before end timestamp
  --high-quality        Only analyze reads with more complement events than
                        template.
  --saveas STRING       Save the plot to a file named filename.extension (e.g.
                        pdf, jpg)
```


## poretools_winner

### Tool Description
Reports the winner read from each FAST5 file.

### Metadata
- **Docker Image**: quay.io/biocontainers/poretools:0.6.1a0--py27_0
- **Homepage**: https://github.com/arq5x/poretools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: poretools winner [-h] [-q] [--type STRING] FILES [FILES ...]

positional arguments:
  FILES          The input FAST5 files.

optional arguments:
  -h, --help     show this help message and exit
  -q, --quiet    Do not output warnings to stderr
  --type STRING  Which type of FASTA entries should be reported? Def.=all
```


## poretools_squiggle

### Tool Description
Generate squiggle plots from FAST5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/poretools:0.6.1a0--py27_0
- **Homepage**: https://github.com/arq5x/poretools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: poretools squiggle [-h] [-q] [--saveas STRING] [--num-facets INTEGER]
                          [--theme-bw]
                          FILES [FILES ...]

positional arguments:
  FILES                 The input FAST5 files.

optional arguments:
  -h, --help            show this help message and exit
  -q, --quiet           Do not output warnings to stderr
  --saveas STRING       Save the squiggle plot to a file.
  --num-facets INTEGER  The number of plot facets (sub-plots). More is better
                        for long reads. (def=6)
  --theme-bw            Use a black and white theme.
```


## poretools_times

### Tool Description
Extract timing information from FAST5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/poretools:0.6.1a0--py27_0
- **Homepage**: https://github.com/arq5x/poretools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: poretools times [-h] [-q] FILES [FILES ...]

positional arguments:
  FILES        The input FAST5 files.

optional arguments:
  -h, --help   show this help message and exit
  -q, --quiet  Do not output warnings to stderr
```


## poretools_yield_plot

### Tool Description
Generates a plot of yield per read from FAST5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/poretools:0.6.1a0--py27_0
- **Homepage**: https://github.com/arq5x/poretools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: poretools yield_plot [-h] [-q] [--saveas STRING] [--plot-type STRING]
                            [--theme-bw] [--skip INTEGER] [--savedf STRING]
                            FILES [FILES ...]

positional arguments:
  FILES               The input FAST5 files.

optional arguments:
  -h, --help          show this help message and exit
  -q, --quiet         Do not output warnings to stderr
  --saveas STRING     Save the plot to a file. Extension (.pdf or .png) drives
                      type.
  --plot-type STRING  Save the wiggle plot to a file (def=reads).
  --theme-bw          Use a black and white theme.
  --skip INTEGER      Only plot every n points to reduce size
  --savedf STRING     Save the data frame used to construct plot to a file.
```


## poretools_occupancy

### Tool Description
Calculate and plot the occupancy of pores over time.

### Metadata
- **Docker Image**: quay.io/biocontainers/poretools:0.6.1a0--py27_0
- **Homepage**: https://github.com/arq5x/poretools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: poretools occupancy [-h] [-q] [--saveas STRING] [--plot-type STRING]
                           FILES [FILES ...]

positional arguments:
  FILES               The input FAST5 files.

optional arguments:
  -h, --help          show this help message and exit
  -q, --quiet         Do not output warnings to stderr
  --saveas STRING     Save the plot to a file. Extension (.pdf or .png) drives
                      type.
  --plot-type STRING  The type of plot to generate
```


## poretools_organise

### Tool Description
Organise FAST5 files into a directory structure.

### Metadata
- **Docker Image**: quay.io/biocontainers/poretools:0.6.1a0--py27_0
- **Homepage**: https://github.com/arq5x/poretools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: poretools organise [-h] [-q] [--copy] FILES [FILES ...] STRING

positional arguments:
  FILES        The input FAST5 files.
  STRING       The destination directory.

optional arguments:
  -h, --help   show this help message and exit
  -q, --quiet  Do not output warnings to stderr
  --copy       Make a copy of files instead of moving
```


## Metadata
- **Skill**: generated
