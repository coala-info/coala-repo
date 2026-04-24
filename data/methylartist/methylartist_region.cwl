cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methylartist
  - region
label: methylartist_region
doc: "Plot methylation data for a specific genomic region, including alignment tracks,
  smoothed methylation profiles, and gene annotations.\n\nTool homepage: https://github.com/adamewing/methylartist"
inputs:
  - id: all_reads
    type:
      - 'null'
      - boolean
    doc: show all alignments (secondary/supplementary alignments hidden by 
      default)
    inputBinding:
      position: 101
      prefix: --allreads
  - id: bams
    type:
      - 'null'
      - type: array
        items: File
    doc: one or more .bams with MM and ML tags for modification calls
    inputBinding:
      position: 101
      prefix: --bams
  - id: bed
    type:
      - 'null'
      - File
    doc: '.bed file for additional annotations (BED3+3: chrom, start, end, label,
      strand, color)'
    inputBinding:
      position: 101
      prefix: --bed
  - id: bedmethyl
    type:
      - 'null'
      - boolean
    doc: input is (tabix-indexed) bedMethyl
    inputBinding:
      position: 101
      prefix: --bedmethyl
  - id: can_thresh
    type:
      - 'null'
      - float
    doc: canonical base threshold (default=0.8)
    inputBinding:
      position: 101
      prefix: --can_thresh
  - id: color_by_hp
    type:
      - 'null'
      - boolean
    doc: color samples by HP value (req --phased)
    inputBinding:
      position: 101
      prefix: --color_by_hp
  - id: colormap
    type:
      - 'null'
      - string
    doc: map annotations to colours, can be file with mapping or "auto"
    inputBinding:
      position: 101
      prefix: --colormap
  - id: cover_palette
    type:
      - 'null'
      - string
    doc: colour palette name for coverage plot
    inputBinding:
      position: 101
      prefix: --coverpalette
  - id: cover_ymin
    type:
      - 'null'
      - float
    doc: y-axis minimum for coverage plot (default = 0)
    inputBinding:
      position: 101
      prefix: --cover_ymin
  - id: csi
    type:
      - 'null'
      - File
    doc: csi index for the gtf, optional
    inputBinding:
      position: 101
      prefix: --csi
  - id: ctbam
    type:
      - 'null'
      - string
    doc: specify which .bam(s) are C/T substitution data (can be 
      comma-delimited)
    inputBinding:
      position: 101
      prefix: --ctbam
  - id: data
    type:
      - 'null'
      - File
    doc: text file with .bam filename and corresponding methylation database per
      line(whitespace-delimited)
    inputBinding:
      position: 101
      prefix: --data
  - id: dmr_max_overlap
    type:
      - 'null'
      - float
    doc: max overlap between distributions (default = 0.0)
    inputBinding:
      position: 101
      prefix: --dmr_maxoverlap
  - id: dmr_min_diff
    type:
      - 'null'
      - float
    doc: minimum difference between means (default = 0.4)
    inputBinding:
      position: 101
      prefix: --dmr_mindiff
  - id: dmr_min_motifs
    type:
      - 'null'
      - int
    doc: minimum motif count for DMR prediction (default = 20)
    inputBinding:
      position: 101
      prefix: --dmr_minmotifs
  - id: dmr_min_ratio
    type:
      - 'null'
      - float
    doc: minimum reads ratio for DMR prediction (default=0.3)
    inputBinding:
      position: 101
      prefix: --dmr_minratio
  - id: dmr_min_reads
    type:
      - 'null'
      - int
    doc: minimum reads per group for DMR prediction (default=8)
    inputBinding:
      position: 101
      prefix: --dmr_minreads
  - id: eff
    type:
      - 'null'
      - string
    doc: conversion efficiency (for e.g. bs-seq or em-seq), input as 
      comma-delimited sample:eff
    inputBinding:
      position: 101
      prefix: --eff
  - id: exon_height
    type:
      - 'null'
      - float
    doc: set exon height (default=0.8)
    inputBinding:
      position: 101
      prefix: --exonheight
  - id: force_align_plot
    type:
      - 'null'
      - boolean
    doc: retain alignment plot even over regions > 5Mbp
    inputBinding:
      position: 101
      prefix: --force_align_plot
  - id: gene_palette
    type:
      - 'null'
      - string
    doc: colour palette name for highlights
    inputBinding:
      position: 101
      prefix: --genepalette
  - id: gene_track_height
    type:
      - 'null'
      - int
    doc: maximum number of gene track layers
    inputBinding:
      position: 101
      prefix: --gene_track_height
  - id: genes
    type:
      - 'null'
      - string
    doc: genes of interest (comma delimited)
    inputBinding:
      position: 101
      prefix: --genes
  - id: gtf
    type:
      - 'null'
      - File
    doc: genes or intervals to display in gtf format
    inputBinding:
      position: 101
      prefix: --gtf
  - id: height
    type:
      - 'null'
      - float
    doc: image width (inches, default=8)
    inputBinding:
      position: 101
      prefix: --height
  - id: hide_bed_label
    type:
      - 'null'
      - boolean
    doc: hide lables from .bed track
    inputBinding:
      position: 101
      prefix: --hidebedlabel
  - id: highlight
    type:
      - 'null'
      - string
    doc: 'format: start-end, can comma-delimit multiple highlights'
    inputBinding:
      position: 101
      prefix: --highlight
  - id: highlight_alpha
    type:
      - 'null'
      - float
    doc: alpha for highlighting in panels (between 0 and 1, default = 0.25)
    inputBinding:
      position: 101
      prefix: --highlight_alpha
  - id: highlight_bed
    type:
      - 'null'
      - File
    doc: BED3+1 format (chrom, start, end, optional_colour) where colour 
      (optional) must be intelligible to matplotlib
    inputBinding:
      position: 101
      prefix: --highlight_bed
  - id: highlight_centerline
    type:
      - 'null'
      - float
    doc: change highlight to line (specify width)
    inputBinding:
      position: 101
      prefix: --highlight_centerline
  - id: highlight_palette
    type:
      - 'null'
      - string
    doc: colour palette name for highlights
    inputBinding:
      position: 101
      prefix: --highlightpalette
  - id: interval
    type: string
    doc: chrom:start-end
    inputBinding:
      position: 101
      prefix: --interval
  - id: label_genes
    type:
      - 'null'
      - boolean
    doc: plot gene names
    inputBinding:
      position: 101
      prefix: --labelgenes
  - id: log_cover
    type:
      - 'null'
      - boolean
    doc: apply log2(count+1) to coverage data (--plot_coverage)
    inputBinding:
      position: 101
      prefix: --logcover
  - id: max_read_density
    type:
      - 'null'
      - float
    doc: filter reads with call density greater >= value
    inputBinding:
      position: 101
      prefix: --max_read_density
  - id: max_uncovered
    type:
      - 'null'
      - float
    doc: maximum percentage of uncovered windows tolerated (default = 50.0)
    inputBinding:
      position: 101
      prefix: --maxuncovered
  - id: meth_thresh
    type:
      - 'null'
      - float
    doc: modified base threshold (default=0.8)
    inputBinding:
      position: 101
      prefix: --meth_thresh
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: minimum mapping quality (mapq), default = 10
    inputBinding:
      position: 101
      prefix: --min_mapq
  - id: min_window_calls
    type:
      - 'null'
      - int
    doc: minimum reads per window to include in plot (default = 1)
    inputBinding:
      position: 101
      prefix: --min_window_calls
  - id: mod_space
    type:
      - 'null'
      - int
    doc: increase to increase spacing between links in top panel (default=auto)
    inputBinding:
      position: 101
      prefix: --modspace
  - id: mods
    type:
      - 'null'
      - string
    doc: mods to consider (comma-delimited, default = all available)
    inputBinding:
      position: 101
      prefix: --mods
  - id: motif
    type: string
    doc: normalise window sizes to motif occurance
    inputBinding:
      position: 101
      prefix: --motif
  - id: motif_size
    type:
      - 'null'
      - int
    doc: mod motif size, only used with -b/--bams (default is 2 as "CG" is most 
      common use case)
    inputBinding:
      position: 101
      prefix: --motifsize
  - id: nticks
    type:
      - 'null'
      - int
    doc: tick count (default=10)
    inputBinding:
      position: 101
      prefix: --nticks
  - id: panel_ratios
    type:
      - 'null'
      - string
    doc: 'Alter panel ratios: needs to be 4 (or 5 if --plot_coverage) comma-seperated
      integers.'
    inputBinding:
      position: 101
      prefix: --panelratios
  - id: phased
    type:
      - 'null'
      - boolean
    doc: currently only considers two phases (diploid)
    inputBinding:
      position: 101
      prefix: --phased
  - id: plot_coverage
    type:
      - 'null'
      - string
    doc: plot coverage from bam(s) (can be comma-delimited list)
    inputBinding:
      position: 101
      prefix: --plot_coverage
  - id: primary_only
    type:
      - 'null'
      - boolean
    doc: ignore non-primary alignments
    inputBinding:
      position: 101
      prefix: --primary_only
  - id: procs
    type:
      - 'null'
      - int
    doc: multiprocessing
    inputBinding:
      position: 101
      prefix: --procs
  - id: read_mask
    type:
      - 'null'
      - string
    doc: mask reads from being shown in interval(s). Can be comma-delimited.
    inputBinding:
      position: 101
      prefix: --readmask
  - id: ref
    type: File
    doc: ref genome fasta, required if normalising windows with -n/--norm_motif
    inputBinding:
      position: 101
      prefix: --ref
  - id: sample_palette
    type:
      - 'null'
      - string
    doc: palette for samples
    inputBinding:
      position: 101
      prefix: --samplepalette
  - id: scale_fullwidth
    type:
      - 'null'
      - float
    doc: scale plot output relative to value (e.g. use length of chrom 1)
    inputBinding:
      position: 101
      prefix: --scale_fullwidth
  - id: show_transcripts
    type:
      - 'null'
      - boolean
    doc: plot all transcripts, use transcript_id/transcript_name attrs
    inputBinding:
      position: 101
      prefix: --show_transcripts
  - id: shuffle
    type:
      - 'null'
      - boolean
    doc: shuffle sample order for smoothed plot
    inputBinding:
      position: 101
      prefix: --shuffle
  - id: skip_align_plot
    type:
      - 'null'
      - boolean
    doc: blank alignment plot, useful if unneeded or for runtime.
    inputBinding:
      position: 101
      prefix: --skip_align_plot
  - id: smooth_alpha
    type:
      - 'null'
      - float
    doc: alpha (transparency) value for smoothed plot (default = 1.0)
    inputBinding:
      position: 101
      prefix: --smoothalpha
  - id: smooth_func
    type:
      - 'null'
      - string
    doc: 'smoothing function, one of: flat,hanning,hamming,bartlett,blackman'
    inputBinding:
      position: 101
      prefix: --smoothfunc
  - id: smooth_line_width
    type:
      - 'null'
      - float
    doc: smooth line width (default = 4.0)
    inputBinding:
      position: 101
      prefix: --smoothlinewidth
  - id: smooth_window_size
    type:
      - 'null'
      - int
    doc: size of window for smoothing (default=auto)
    inputBinding:
      position: 101
      prefix: --smoothwindowsize
  - id: svg
    type:
      - 'null'
      - boolean
    doc: output in SVG format
    inputBinding:
      position: 101
      prefix: --svg
  - id: width
    type:
      - 'null'
      - float
    doc: image width (inches, default=16)
    inputBinding:
      position: 101
      prefix: --width
  - id: windows
    type:
      - 'null'
      - int
    doc: set window count, default=auto
    inputBinding:
      position: 101
      prefix: --windows
  - id: write_dmrs
    type:
      - 'null'
      - boolean
    doc: record differentially methylated windows to a file
    inputBinding:
      position: 101
      prefix: --write_dmrs
  - id: ymax
    type:
      - 'null'
      - float
    doc: y-axis maximum for smoothed plot (default = 1.05)
    inputBinding:
      position: 101
      prefix: --ymax
  - id: ymin
    type:
      - 'null'
      - float
    doc: y-axis minimum for smoothed plot (default = -0.05)
    inputBinding:
      position: 101
      prefix: --ymin
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: 'output file name (default: generated from input)'
    outputBinding:
      glob: $(inputs.outfile)
  - id: segment_csv
    type:
      - 'null'
      - File
    doc: output values from smoothed segment plot to specified filename in CSV 
      format
    outputBinding:
      glob: $(inputs.segment_csv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylartist:1.5.3--pyhdfd78af_0
