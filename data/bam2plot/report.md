# bam2plot CWL Generation Report

## bam2plot_from_bam

### Tool Description
Plot your bam files!

### Metadata
- **Docker Image**: quay.io/biocontainers/bam2plot:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/willros/bam2plot
- **Package**: https://anaconda.org/channels/bioconda/packages/bam2plot/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bam2plot/overview
- **Total Downloads**: 834
- **Last updated**: 2026-02-20
- **GitHub**: https://github.com/willros/bam2plot
- **Stars**: N/A
### Original Help Text
```text
usage: bam2plot [-h] -b BAM -o OUTPATH [-w WHITELIST] [-t THRESHOLD]
                [-r ROLLING_WINDOW] [-i | --index | --no-index]
                [-s | --sort_and_index | --no-sort_and_index] [-z ZOOM]
                [-c | --cum_plot | --no-cum_plot] [-p {png,svg,both}]
                [-n NUMBER_OF_REFS]
                sub_command

Plot your bam files!

positional arguments:
  sub_command

options:
  -h, --help            show this help message and exit
  -b BAM, --bam BAM     bam file
  -o OUTPATH, --outpath OUTPATH
                        Where to save the plots.
  -w WHITELIST, --whitelist WHITELIST
                        Only include these references/chromosomes.
  -t THRESHOLD, --threshold THRESHOLD
                        Threshold of mean coverage depth
  -r ROLLING_WINDOW, --rolling_window ROLLING_WINDOW
                        Rolling window size
  -i, --index, --no-index
                        Index bam file
  -s, --sort_and_index, --no-sort_and_index
                        Index and sort bam file
  -z ZOOM, --zoom ZOOM  Zoom into this region. Example: -z='100 2000'
  -c, --cum_plot, --no-cum_plot
                        Generate cumulative plots of all chromosomes
  -p {png,svg,both}, --plot_type {png,svg,both}
                        How to save the plots
  -n NUMBER_OF_REFS, --number_of_refs NUMBER_OF_REFS
                        How many references (chromosomes) to plot
```


## bam2plot_from_reads

### Tool Description
Align your reads and plot the coverage!

### Metadata
- **Docker Image**: quay.io/biocontainers/bam2plot:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/willros/bam2plot
- **Package**: https://anaconda.org/channels/bioconda/packages/bam2plot/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bam2plot [-h] -r1 READ_1 [-r2 READ_2] -ref REFERENCE
                [-gc | --guci | --no-guci] -o OUT_FOLDER [-r ROLLING_WINDOW]
                [-p {png,svg,both}]
                sub_command

Align your reads and plot the coverage!

positional arguments:
  sub_command

options:
  -h, --help            show this help message and exit
  -r1 READ_1, --read_1 READ_1
                        Fastq file 1 (Required)
  -r2 READ_2, --read_2 READ_2
                        Fastq file 2 (Optional)
  -ref REFERENCE, --reference REFERENCE
                        Reference fasta
  -gc, --guci, --no-guci
                        Plot GC content?
  -o OUT_FOLDER, --out_folder OUT_FOLDER
                        Where to save the plots.
  -r ROLLING_WINDOW, --rolling_window ROLLING_WINDOW
                        Rolling window size
  -p {png,svg,both}, --plot_type {png,svg,both}
                        How to save the plots
```


## bam2plot_guci

### Tool Description
Plot GC content of your reference fasta!

### Metadata
- **Docker Image**: quay.io/biocontainers/bam2plot:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/willros/bam2plot
- **Package**: https://anaconda.org/channels/bioconda/packages/bam2plot/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bam2plot [-h] -ref REFERENCE -w WINDOW -o OUT_FOLDER
                [-p {png,svg,both}]
                sub_command

Plot GC content of your reference fasta!

positional arguments:
  sub_command

options:
  -h, --help            show this help message and exit
  -ref REFERENCE, --reference REFERENCE
                        Reference fasta
  -w WINDOW, --window WINDOW
                        Rolling window size
  -o OUT_FOLDER, --out_folder OUT_FOLDER
                        Where to save the plots.
  -p {png,svg,both}, --plot_type {png,svg,both}
                        How to save the plots
```


## Metadata
- **Skill**: generated
