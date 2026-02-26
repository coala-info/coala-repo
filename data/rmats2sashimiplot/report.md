# rmats2sashimiplot CWL Generation Report

## rmats2sashimiplot

### Tool Description
Generate sashimi plots from rMATS output or coordinate and annotation input.

### Metadata
- **Docker Image**: quay.io/biocontainers/rmats2sashimiplot:3.0.0--py39hdff8610_2
- **Homepage**: https://github.com/Xinglab/rmats2sashimiplot
- **Package**: https://anaconda.org/channels/bioconda/packages/rmats2sashimiplot/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rmats2sashimiplot/overview
- **Total Downloads**: 24.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Xinglab/rmats2sashimiplot
- **Stars**: N/A
### Original Help Text
```text
usage: rmats2sashimiplot [-h] -o OUT_DIR [--l1 L1] [--l2 L2]
                         [--event-type {SE,A5SS,A3SS,MXE,RI}] [-e EVENTS_FILE]
                         [-c COORDINATE] [--s1 S1] [--s2 S2] [--b1 B1]
                         [--b2 B2] [--exon_s EXON_S] [--intron_s INTRON_S]
                         [--group-info GROUP_INFO] [--min-counts MIN_COUNTS]
                         [--color COLOR] [--font-size FONT_SIZE]
                         [--fig-height FIG_HEIGHT] [--fig-width FIG_WIDTH]
                         [--hide-number] [--no-text-background]
                         [--keep-event-chr-prefix] [--remove-event-chr-prefix]

optional arguments:
  -h, --help            show this help message and exit

Required:
  -o OUT_DIR            The output directory.

Labels:
  --l1 L1               The label for the first sample.
  --l2 L2               The label for the second sample.

rMATS event input:
  Use either (rMATS event input) or (Coordinate and annotation input)

  --event-type {SE,A5SS,A3SS,MXE,RI}
                        Type of event from rMATS result used in the analysis.
                        'SE': skipped exon, 'A5SS': alternative 5' splice
                        site, 'A3SS' alternative 3' splice site, 'MXE':
                        mutually exclusive exons, 'RI': retained intron. (Only
                        if using rMATS event input)
  -e EVENTS_FILE        The rMATS output event file (Only if using rMATS event
                        input)

Coordinate and annotation input:
  Use either (Coordinate and annotation input) or (rMATS event input)

  -c COORDINATE         The genome region coordinates and a GFF3 (not GTF)
                        annotation file of genes and transcripts. The format
                        is -c
                        {chromosome}:{strand}:{start}:{end}:{/path/to/gff3}
                        (Only if using Coordinate and annotation input)

SAM Files:
  Mapping results for sample_1 & sample_2 in SAM format. Replicates must be
  in a comma separated list. A path to a file containing the comma separated
  list can also be given. (Only if using SAM)

  --s1 S1               sample_1 sam files: s1_rep1.sam[,s1_rep2.sam]
  --s2 S2               sample_2 sam files: s2_rep1.sam[,s2_rep2.sam]

BAM Files:
  Mapping results for sample_1 & sample_2 in BAM format. Replicates must be
  in a comma separated list. A path to a file containing the comma separated
  list can also be given. (Only if using BAM)

  --b1 B1               sample_1 bam files: s1_rep1.bam[,s1_rep2.bam]
  --b2 B2               sample_2 bam files: s2_rep1.bam[,s2_rep2.bam]

Optional:
  --exon_s EXON_S       How much to scale down exons. Default: 1
  --intron_s INTRON_S   How much to scale down introns. For example,
                        --intron_s 5 results in an intron with real length of
                        100 being plotted as 100/5 = 20. Default: 1
  --group-info GROUP_INFO
                        The path to a *.gf file which groups the replicates.
                        One sashimi plot will be generated for each group
                        instead of the default behavior of one plot per
                        replicate
  --min-counts MIN_COUNTS
                        Individual junctions with read count below --min-
                        counts will be omitted from the plot. Default: 0
  --color COLOR         Specify a list of colors with one color per plot.
                        Without grouping there is one plot per replicate. With
                        grouping there is one plot per group: --color
                        '#CC0011[,#FF8800]'
  --font-size FONT_SIZE
                        Set the font size. Default: 8
  --fig-height FIG_HEIGHT
                        Set the output figure height (in inches). Default is 7
                        if sample size < 5 and 14 if sample size is 5 or more
  --fig-width FIG_WIDTH
                        Set the output figure width (in inches). Default: 8
  --hide-number         Do not display the read count on the junctions
  --no-text-background  Do not put a white box behind the junction read count
  --keep-event-chr-prefix
                        force the contig name in the provided events file to
                        be used
  --remove-event-chr-prefix
                        remove any leading "chr" from contig names in the
                        provided events file
```

