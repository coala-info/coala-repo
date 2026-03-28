# ngsplotdb-ngsplotdb-hg19 CWL Generation Report

## ngsplotdb-ngsplotdb-hg19_ngsplotdb.py

### Tool Description
Manipulate ngs.plot's annotation database

### Metadata
- **Docker Image**: quay.io/biocontainers/ngsplotdb-ngsplotdb-hg19:3.00--r3.4.1_0
- **Homepage**: https://github.com/shenlab-sinai/ngsplot
- **Package**: https://anaconda.org/channels/bioconda/packages/ngsplotdb-ngsplotdb-hg19/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ngsplotdb-ngsplotdb-hg19/overview
- **Total Downloads**: 5.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/shenlab-sinai/ngsplot
- **Stars**: N/A
### Original Help Text
```text
usage: ngsplotdb.py [-h] [-y] {list,install,remove,chrnames} ...

Manipulate ngs.plot's annotation database

optional arguments:
  -h, --help            show this help message and exit
  -y, --yes             Say yes to all prompted questions

Subcommands:
  {list,install,remove,chrnames}
                        additional help
    list                List genomes installed in database
    install             Install genome from package file
    remove              Remove genome from database
    chrnames            List chromosome names
```


## ngsplotdb-ngsplotdb-hg19_ngs.plot.r

### Tool Description
ngs.plot.r is a tool for generating various plots related to genomic data, including coverage profiles and heatmaps. It supports multiple genomes and regions, and offers extensive customization options for data processing and visualization.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngsplotdb-ngsplotdb-hg19:3.00--r3.4.1_0
- **Homepage**: https://github.com/shenlab-sinai/ngsplot
- **Package**: https://anaconda.org/channels/bioconda/packages/ngsplotdb-ngsplotdb-hg19/overview
- **Validation**: PASS

### Original Help Text
```text
Unpaired argument and value.

Visit https://github.com/shenlab-sinai/ngsplot/wiki/ProgramArguments101 for details
Version: 2.63
Usage: ngs.plot.r -G genome -R region -C [cov|config]file
                  -O name [Options]

## Mandatory parameters:
  -G   Genome name. Use ngsplotdb.py list to show available genomes.
  -R   Genomic regions to plot: tss, tes, genebody, exon, cgi, enhancer, dhs or bed
  -C   Indexed bam file or a configuration file for multiplot
  -O   Name for output: multiple files will be generated
## Optional parameters related to configuration file:
  -E   Gene list to subset regions OR bed file for custom region
  -T   Image title
## Coverage-generation parameters:
  -F   Further information provided to select database table or plottype:
         This is a string of description separated by comma.
         E.g. protein_coding,K562,rnaseq(order of descriptors does not matter)
              means coding genes in K562 cell line drawn in rnaseq mode.
  -D   Gene database: ensembl(default), refseq
  -L   Flanking region size(will override flanking factor)
  -N   Flanking region factor
  -RB  The fraction of extreme values to be trimmed on both ends
         default=0, 0.05 means 5% of extreme values will be trimmed
  -S   Randomly sample the regions for plot, must be:(0, 1]
  -P   #CPUs to use. Set 0(default) for auto detection
  -AL  Algorithm used to normalize coverage vectors: spline(default), bin
  -CS  Chunk size for loading genes in batch(default=100)
  -MQ  Mapping quality cutoff to filter reads(default=20)
  -FL  Fragment length used to calculate physical coverage(default=150)
  -SS  Strand-specific coverage calculation: both(default), same, opposite
  -IN  Shall interval be larger than flanking in plot?(0 or 1, default=automatic)
  -FI  Forbid image output if set to 1(default=0)
## Plotting-related parameters:
### Misc. parameters:
    -FS Font size(default=12)
### Avg. profiles parameters:
    -WD Image width(default=8)
    -HG Image height(default=7)
    -SE  Shall standard errors be plotted?(0 or 1)
    -MW  Moving window width to smooth avg. profiles, must be integer
           1=no(default); 3=slightly; 5=somewhat; 9=quite; 13=super.
    -H   Opacity of shaded area, suggested value:[0, 0.5]
           default=0, i.e. no shading, just lines
    -YAS Y-axis scale: auto(default) or min_val,max_val(custom scale)
    -LEG Draw legend? 1(default) or 0
    -BOX Draw box around plot? 1(default) or 0
    -VLN Draw vertical lines? 1(default) or 0
    -XYL Draw X- and Y-axis labels? 1(default) or 0
    -LWD Line width(default=3)
### Heatmap parameters:
    -GO  Gene order algorithm used in heatmaps: total(default), hc, max,
           prod, diff, km and none(according to gene list supplied)
    -LOW Low count cutoff(default=10) in rank-based normalization
    -KNC K-means or HC number of clusters(default=5)
    -MIT Maximum number of iterations(default=20) for K-means
    -NRS Number of random starts(default=30) in K-means
    -RR  Reduce ratio(default=30). The parameter controls the heatmap height
           The smaller the value, the taller the heatmap
    -SC  Color scale used to map values to colors in a heatmap
           local(default): base on each individual heatmap
           region: base on all heatmaps belong to the same region
           global: base on all heatmaps together
           min_val,max_val: custom scale using a pair of numerics
    -FC  Flooding fraction:[0, 1), default=0.02
    -CO  Color for heatmap. For bam-pair, use color-tri(neg_color:[neu_color]:pos_color)
           Hint: must use R colors, such as darkgreen, yellow and blue2
                 The neutral color is optional(default=black)
    -CD  Color distribution for heatmap(default=0.6). Must be a positive number
           Hint: lower values give more widely spaced colors at the negative end
                 In other words, they shift the neutral color to positive values
                 If set to 1, the neutral color represents 0(i.e. no bias)
```


## Metadata
- **Skill**: generated
