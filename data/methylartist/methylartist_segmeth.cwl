cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methylartist
  - segmeth
label: methylartist_segmeth
doc: "Segmented methylation analysis tool for calculating methylation levels over
  specific intervals.\n\nTool homepage: https://github.com/adamewing/methylartist"
inputs:
  - id: bams
    type:
      - 'null'
      - type: array
        items: File
    doc: one or more .bams (or bedMethyl input) with Mm and Ml tags for 
      modification calls (see samtags spec)
    inputBinding:
      position: 101
      prefix: --bams
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
    default: 0.8
    inputBinding:
      position: 101
      prefix: --can_thresh
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
  - id: dmr_maxoverlap
    type:
      - 'null'
      - float
    doc: max overlap between distributions (default = 0.0)
    default: 0.0
    inputBinding:
      position: 101
      prefix: --dmr_maxoverlap
  - id: dmr_mindiff
    type:
      - 'null'
      - float
    doc: minimum difference between means (default = 0.4)
    default: 0.4
    inputBinding:
      position: 101
      prefix: --dmr_mindiff
  - id: dmr_minmotifs
    type:
      - 'null'
      - int
    doc: minimum motif count for DMR prediction (default = 20)
    default: 20
    inputBinding:
      position: 101
      prefix: --dmr_minmotifs
  - id: dmr_minratio
    type:
      - 'null'
      - float
    doc: minimum reads ratio for DMR prediction (default=0.3)
    default: 0.3
    inputBinding:
      position: 101
      prefix: --dmr_minratio
  - id: dmr_minreads
    type:
      - 'null'
      - int
    doc: minimum reads per group for DMR prediction (default=8)
    default: 8
    inputBinding:
      position: 101
      prefix: --dmr_minreads
  - id: excl_ambig
    type:
      - 'null'
      - boolean
    doc: do not consider reads that align entirely within segment
    inputBinding:
      position: 101
      prefix: --excl_ambig
  - id: highmeth_thresh
    type:
      - 'null'
      - float
    doc: threshold for high-methylated read count column (default = 0.95)
    default: 0.95
    inputBinding:
      position: 101
      prefix: --highmeth_thresh
  - id: intervals
    type: File
    doc: .bed file
    inputBinding:
      position: 101
      prefix: --intervals
  - id: lowmeth_thresh
    type:
      - 'null'
      - float
    doc: threshold for low-methylated read count column (default = 0.05)
    default: 0.05
    inputBinding:
      position: 101
      prefix: --lowmeth_thresh
  - id: max_read_density
    type:
      - 'null'
      - float
    doc: filter reads with call density greater >= value, can be helpful in 
      footprinting assays (default=None)
    inputBinding:
      position: 101
      prefix: --max_read_density
  - id: meth_thresh
    type:
      - 'null'
      - float
    doc: modified base threshold (default=0.8)
    default: 0.8
    inputBinding:
      position: 101
      prefix: --meth_thresh
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: minimum mapping quality (mapq), default = 10
    default: 10
    inputBinding:
      position: 101
      prefix: --min_mapq
  - id: mods
    type:
      - 'null'
      - string
    doc: mods, comma-delimited for >1 (default to all available mods)
    inputBinding:
      position: 101
      prefix: --mods
  - id: motif
    type:
      - 'null'
      - string
    doc: expected modification motif (e.g. CG for 5mCpG required for mod bams)
    inputBinding:
      position: 101
      prefix: --motif
  - id: phased
    type:
      - 'null'
      - boolean
    doc: currently only considers two phases (diploid)
    inputBinding:
      position: 101
      prefix: --phased
  - id: predict_dmr
    type:
      - 'null'
      - boolean
    doc: enable DMR prediction in unphased data
    inputBinding:
      position: 101
      prefix: --predict_dmr
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
    type:
      - 'null'
      - File
    doc: reference genome .fa (build .fai index with samtools faidx) (required 
      for mod bams)
    inputBinding:
      position: 101
      prefix: --ref
  - id: spanning_only
    type:
      - 'null'
      - boolean
    doc: only consider reads that span segment
    inputBinding:
      position: 101
      prefix: --spanning_only
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: 'output file name (default: generated from input)'
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylartist:1.5.3--pyhdfd78af_0
