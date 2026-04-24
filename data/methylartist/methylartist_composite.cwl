cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methylartist
  - composite
label: methylartist_composite
doc: "Generate composite methylation plots for transposable elements or other genomic
  features.\n\nTool homepage: https://github.com/adamewing/methylartist"
inputs:
  - id: alpha
    type:
      - 'null'
      - float
    doc: alpha
    inputBinding:
      position: 101
      prefix: --alpha
  - id: bams
    type:
      - 'null'
      - type: array
        items: File
    doc: one or more .bams with MM and ML tags for modification calls
    inputBinding:
      position: 101
      prefix: --bams
  - id: blocks
    type:
      - 'null'
      - File
    doc: blocks to highlight (txt file with start, end, name, hex colour)
    inputBinding:
      position: 101
      prefix: --blocks
  - id: can_thresh
    type:
      - 'null'
      - float
    doc: canonical base threshold
    inputBinding:
      position: 101
      prefix: --can_thresh
  - id: color_by_phase
    type:
      - 'null'
      - boolean
    doc: color samples by HP value (req --phased)
    inputBinding:
      position: 101
      prefix: --color_by_phase
  - id: data
    type:
      - 'null'
      - File
    doc: text file with .bam filename and corresponding methylation database per
      line(whitespace-delimited)
    inputBinding:
      position: 101
      prefix: --data
  - id: end
    type:
      - 'null'
      - int
    doc: end plotting at this base
    inputBinding:
      position: 101
      prefix: --end
  - id: excl_ambig
    type:
      - 'null'
      - boolean
    doc: exclude ambiguous calls
    inputBinding:
      position: 101
      prefix: --excl_ambig
  - id: lenfrac
    type:
      - 'null'
      - float
    doc: fraction of TE length that must align
    inputBinding:
      position: 101
      prefix: --lenfrac
  - id: linewidth
    type:
      - 'null'
      - float
    doc: line width
    inputBinding:
      position: 101
      prefix: --linewidth
  - id: max_read_density
    type:
      - 'null'
      - float
    doc: filter reads with call density greater >= value
    inputBinding:
      position: 101
      prefix: --max_read_density
  - id: maxelts
    type:
      - 'null'
      - int
    doc: maximum output elements
    inputBinding:
      position: 101
      prefix: --maxelts
  - id: meanplot_cutoff
    type:
      - 'null'
      - int
    doc: override site coverage cutoff for mean plot
    inputBinding:
      position: 101
      prefix: --meanplot_cutoff
  - id: meanplot_ylabel
    type:
      - 'null'
      - string
    doc: set y-axis label on mean plot
    inputBinding:
      position: 101
      prefix: --meanplot_ylabel
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
    doc: minimum call count to include elt
    inputBinding:
      position: 101
      prefix: --mincalls
  - id: minelts
    type:
      - 'null'
      - int
    doc: minimum output elements
    inputBinding:
      position: 101
      prefix: --minelts
  - id: mod
    type:
      - 'null'
      - string
    doc: modification to plot
    inputBinding:
      position: 101
      prefix: --mod
  - id: motif
    type:
      - 'null'
      - string
    doc: modified motif to highlight
    inputBinding:
      position: 101
      prefix: --motif
  - id: output_table
    type:
      - 'null'
      - boolean
    doc: output per-site data to table (.tsv)
    inputBinding:
      position: 101
      prefix: --output_table
  - id: palette
    type:
      - 'null'
      - string
    doc: palette for samples
    inputBinding:
      position: 101
      prefix: --palette
  - id: phased
    type:
      - 'null'
      - boolean
    doc: currently only considers two phases (diploid)
    inputBinding:
      position: 101
      prefix: --phased
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
  - id: ref
    type: File
    doc: ref genome fasta
    inputBinding:
      position: 101
      prefix: --ref
  - id: segdata
    type: File
    doc: 'BED3+1: chrom, start, end, strand'
    inputBinding:
      position: 101
      prefix: --segdata
  - id: slidingwindowsize
    type:
      - 'null'
      - int
    doc: size of sliding window for meth frac
    inputBinding:
      position: 101
      prefix: --slidingwindowsize
  - id: slidingwindowstep
    type:
      - 'null'
      - int
    doc: step size for meth frac
    inputBinding:
      position: 101
      prefix: --slidingwindowstep
  - id: smoothfunc
    type:
      - 'null'
      - string
    doc: 'smoothing function, one of: flat, hanning, hamming, bartlett, blackman'
    inputBinding:
      position: 101
      prefix: --smoothfunc
  - id: smoothwindowsize
    type:
      - 'null'
      - int
    doc: size of window for smoothing
    inputBinding:
      position: 101
      prefix: --smoothwindowsize
  - id: start
    type:
      - 'null'
      - int
    doc: start plotting at this base
    inputBinding:
      position: 101
      prefix: --start
  - id: svg
    type:
      - 'null'
      - boolean
    doc: output in SVG format
    inputBinding:
      position: 101
      prefix: --svg
  - id: teref
    type: File
    doc: TE ref fasta
    inputBinding:
      position: 101
      prefix: --teref
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
    doc: output file name
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylartist:1.5.3--pyhdfd78af_0
