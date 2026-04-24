cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methylartist
  - locus
label: methylartist_locus
doc: "Plot methylation data for a specific genomic locus, including alignments, smoothed
  methylation profiles, and gene annotations.\n\nTool homepage: https://github.com/adamewing/methylartist"
inputs:
  - id: allreads
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
  - id: can_thresh
    type:
      - 'null'
      - float
    doc: canonical base threshold
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
  - id: color_by_phase
    type:
      - 'null'
      - boolean
    doc: color samples by phase (req --phased)
    inputBinding:
      position: 101
      prefix: --color_by_phase
  - id: colormap
    type:
      - 'null'
      - string
    doc: map annotations to colours, can be file with mapping or "auto"
    inputBinding:
      position: 101
      prefix: --colormap
  - id: cover_ymin
    type:
      - 'null'
      - float
    doc: y-axis minimum for coverage plot
    inputBinding:
      position: 101
      prefix: --cover_ymin
  - id: coverpalette
    type:
      - 'null'
      - string
    doc: colour palette name for coverage plot
    inputBinding:
      position: 101
      prefix: --coverpalette
  - id: coverprocs
    type:
      - 'null'
      - int
    doc: processes to use for coverage function
    inputBinding:
      position: 101
      prefix: --coverprocs
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
      line (whitespace-delimited)
    inputBinding:
      position: 101
      prefix: --data
  - id: excl_ambig
    type:
      - 'null'
      - boolean
    doc: exclude ambiguous calls
    inputBinding:
      position: 101
      prefix: --excl_ambig
  - id: exonheight
    type:
      - 'null'
      - float
    doc: set exon height
    inputBinding:
      position: 101
      prefix: --exonheight
  - id: genepalette
    type:
      - 'null'
      - string
    doc: colour palette name for highlights
    inputBinding:
      position: 101
      prefix: --genepalette
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
    doc: image height (inches)
    inputBinding:
      position: 101
      prefix: --height
  - id: hidebedlabel
    type:
      - 'null'
      - boolean
    doc: hide lables from .bed track
    inputBinding:
      position: 101
      prefix: --hidebedlabel
  - id: hidelegend
    type:
      - 'null'
      - boolean
    doc: hide legends
    inputBinding:
      position: 101
      prefix: --hidelegend
  - id: highlight
    type:
      - 'null'
      - string
    doc: 'format: start-end, (can be chrom:start-end but chrom is ignored) can comma-delimit
      multiple highlights'
    inputBinding:
      position: 101
      prefix: --highlight
  - id: highlight_alpha
    type:
      - 'null'
      - float
    doc: alpha for highlighting in panels (between 0 and 1)
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
  - id: highlight_subplot
    type:
      - 'null'
      - boolean
    doc: make sub-plots for highlighted regions of smoothed plots grouped by 
      colormap (incl --phasediff plot), requires --highlight and --colormap
    inputBinding:
      position: 101
      prefix: --highlight_subplot
  - id: highlightpalette
    type:
      - 'null'
      - string
    doc: colour palette name for highlights
    inputBinding:
      position: 101
      prefix: --highlightpalette
  - id: ignore_ps
    type:
      - 'null'
      - boolean
    doc: do not use phase set (PS) when plotting phased data (HP only)
    inputBinding:
      position: 101
      prefix: --ignore_ps
  - id: include_unphased
    type:
      - 'null'
      - boolean
    doc: include an "unphased" category if called with --phased
    inputBinding:
      position: 101
      prefix: --include_unphased
  - id: interval
    type: string
    doc: chrom:start-end
    inputBinding:
      position: 101
      prefix: --interval
  - id: labelgenes
    type:
      - 'null'
      - boolean
    doc: plot gene names
    inputBinding:
      position: 101
      prefix: --labelgenes
  - id: logcover
    type:
      - 'null'
      - boolean
    doc: apply log2(count+1) to coverage data (--plot_coverage)
    inputBinding:
      position: 101
      prefix: --logcover
  - id: markeralpha
    type:
      - 'null'
      - float
    doc: alpha (transparency) for (un)methylation marker
    inputBinding:
      position: 101
      prefix: --markeralpha
  - id: maskcutoff
    type:
      - 'null'
      - int
    doc: read count masking cutoff
    inputBinding:
      position: 101
      prefix: --maskcutoff
  - id: max_read_density
    type:
      - 'null'
      - float
    doc: filter reads with call density greater >= value
    inputBinding:
      position: 101
      prefix: --max_read_density
  - id: maxmaskedfrac
    type:
      - 'null'
      - float
    doc: skip smoothed plot if fraction of sample masked > this value
    inputBinding:
      position: 101
      prefix: --maxmaskedfrac
  - id: meth_thresh
    type:
      - 'null'
      - float
    doc: modified base threshold
    inputBinding:
      position: 101
      prefix: --meth_thresh
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: minimum mapping quality (mapq)
    inputBinding:
      position: 101
      prefix: --min_mapq
  - id: mincalls
    type:
      - 'null'
      - int
    doc: drop modspace positions if call count (meth+unmeth) < --mincalls
    inputBinding:
      position: 101
      prefix: --mincalls
  - id: mods
    type:
      - 'null'
      - string
    doc: mods, comma-delimited for >1 (default to all available mods)
    inputBinding:
      position: 101
      prefix: --mods
  - id: modspace
    type:
      - 'null'
      - string
    doc: spacing between links in top panel
    inputBinding:
      position: 101
      prefix: --modspace
  - id: motif
    type:
      - 'null'
      - string
    doc: expected modification motif (e.g. CG for 5mCpG required for mod bams)
    inputBinding:
      position: 101
      prefix: --motif
  - id: motifsize
    type:
      - 'null'
      - int
    doc: mod motif size, only used with -b/--bams
    inputBinding:
      position: 101
      prefix: --motifsize
  - id: nomask
    type:
      - 'null'
      - boolean
    doc: skip drawing segment masks
    inputBinding:
      position: 101
      prefix: --nomask
  - id: notext
    type:
      - 'null'
      - boolean
    doc: remove all text from figure
    inputBinding:
      position: 101
      prefix: --notext
  - id: nticks
    type:
      - 'null'
      - int
    doc: tick count
    inputBinding:
      position: 101
      prefix: --nticks
  - id: panel_ratios
    type:
      - 'null'
      - string
    doc: 'Alter panel ratios: needs to be 5 comma-seperated integers'
    inputBinding:
      position: 101
      prefix: --panelratios
  - id: phase_labels
    type:
      - 'null'
      - string
    doc: if --color_by_hp substitute HP tags for labels. Format HP:Label 
      comma-delimited
    inputBinding:
      position: 101
      prefix: --phase_labels
  - id: phased
    type:
      - 'null'
      - boolean
    doc: split samples into phases
    inputBinding:
      position: 101
      prefix: --phased
  - id: phasediff
    type:
      - 'null'
      - boolean
    doc: add absolute difference between phases as output
    inputBinding:
      position: 101
      prefix: --phasediff
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
  - id: readlinealpha
    type:
      - 'null'
      - float
    doc: alpha (transparency) for read mapping lines
    inputBinding:
      position: 101
      prefix: --readlinealpha
  - id: readlinewidth
    type:
      - 'null'
      - float
    doc: width for lines representing read alignments
    inputBinding:
      position: 101
      prefix: --readlinewidth
  - id: readmarker
    type:
      - 'null'
      - string
    doc: marker for (un)methylated glpyhs in read panel (matplotlib markers)
    inputBinding:
      position: 101
      prefix: --readmarker
  - id: readmarkersize
    type:
      - 'null'
      - float
    doc: marker size for (un)methylated glpyhs in read panel
    inputBinding:
      position: 101
      prefix: --readmarkersize
  - id: readmask
    type:
      - 'null'
      - string
    doc: mask reads from being shown in interval(s) (start-end or 
      chrom:start-end; chrom ignored). Can be comma-delimited.
    inputBinding:
      position: 101
      prefix: --readmask
  - id: readopenmarkeredgecolor
    type:
      - 'null'
      - string
    doc: edge color for open (unmethylated) markers in read plot (default = 
      sample color)
    inputBinding:
      position: 101
      prefix: --readopenmarkeredgecolor
  - id: ref
    type:
      - 'null'
      - File
    doc: reference genome .fa (build .fai index with samtools faidx) (required 
      for mod bams)
    inputBinding:
      position: 101
      prefix: --ref
  - id: samplebox
    type:
      - 'null'
      - boolean
    doc: draw sample box with labels next to alignments
    inputBinding:
      position: 101
      prefix: --samplebox
  - id: samplepalette
    type:
      - 'null'
      - string
    doc: palette for samples
    inputBinding:
      position: 101
      prefix: --samplepalette
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
    doc: do not plot alignments
    inputBinding:
      position: 101
      prefix: --skip_align_plot
  - id: skip_raw_plot
    type:
      - 'null'
      - boolean
    doc: do not plot raw signal
    inputBinding:
      position: 101
      prefix: --skip_raw_plot
  - id: sliding_window_step
    type:
      - 'null'
      - int
    doc: step size for initial sliding window
    inputBinding:
      position: 101
      prefix: --slidingwindowstep
  - id: slidingwindowsize
    type:
      - 'null'
      - int
    doc: size of initial sliding window for coverage check
    inputBinding:
      position: 101
      prefix: --slidingwindowsize
  - id: smooth_window_size
    type:
      - 'null'
      - string
    doc: size of window for smoothing
    inputBinding:
      position: 101
      prefix: --smoothwindowsize
  - id: smoothalpha
    type:
      - 'null'
      - float
    doc: alpha (transparency) value for smoothed plot
    inputBinding:
      position: 101
      prefix: --smoothalpha
  - id: smoothfunc
    type:
      - 'null'
      - string
    doc: 'smoothing function, one of: flat,hanning,hamming,bartlett,blackman'
    inputBinding:
      position: 101
      prefix: --smoothfunc
  - id: smoothlinewidth
    type:
      - 'null'
      - float
    doc: smooth line width
    inputBinding:
      position: 101
      prefix: --smoothlinewidth
  - id: splitvar
    type:
      - 'null'
      - string
    doc: split variant on variant with ID (uses ID field from --variants VCF)
    inputBinding:
      position: 101
      prefix: --splitvar
  - id: statname
    type:
      - 'null'
      - string
    doc: label for raw statistic plot
    inputBinding:
      position: 101
      prefix: --statname
  - id: svg
    type:
      - 'null'
      - boolean
    doc: output in SVG format
    inputBinding:
      position: 101
      prefix: --svg
  - id: unambig_highlight
    type:
      - 'null'
      - boolean
    doc: highlight unambiguous calls
    inputBinding:
      position: 101
      prefix: --unambig_highlight
  - id: variantpalette
    type:
      - 'null'
      - string
    doc: colour palette for variant ticks
    inputBinding:
      position: 101
      prefix: --variantpalette
  - id: variants
    type:
      - 'null'
      - File
    doc: variants to highlight, bgzipped/tabix VCF
    inputBinding:
      position: 101
      prefix: --variants
  - id: variantsize
    type:
      - 'null'
      - int
    doc: size of variant ticks
    inputBinding:
      position: 101
      prefix: --variantsize
  - id: width
    type:
      - 'null'
      - float
    doc: image width (inches)
    inputBinding:
      position: 101
      prefix: --width
  - id: ymax
    type:
      - 'null'
      - float
    doc: y-axis maximum for smoothed plot
    inputBinding:
      position: 101
      prefix: --ymax
  - id: ymin
    type:
      - 'null'
      - float
    doc: y-axis minimum for smoothed plot
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
  - id: smoothed_csv
    type:
      - 'null'
      - File
    doc: output values from smoothed plot to CSV format (can specify filename or
      "auto")
    outputBinding:
      glob: $(inputs.smoothed_csv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylartist:1.5.3--pyhdfd78af_0
