cwlVersion: v1.2
class: CommandLineTool
baseCommand: goleft
label: goleft_depth
doc: "Calculate depth of coverage for BAM files.\n\nTool homepage: https://github.com/brentp/goleft"
inputs:
  - id: bam
    type: File
    doc: bam for which to calculate depth
    inputBinding:
      position: 1
  - id: bed
    type:
      - 'null'
      - File
    doc: optional file of positions or regions to restrict depth calculations.
    inputBinding:
      position: 102
      prefix: --bed
  - id: chrom
    type:
      - 'null'
      - string
    doc: optional chromosome to limit analysis
    inputBinding:
      position: 102
      prefix: --chrom
  - id: maxmeandepth
    type:
      - 'null'
      - float
    doc: windows with depth > than this are high-depth. The default reports the 
      depth of all regions.
    inputBinding:
      position: 102
      prefix: --maxmeandepth
  - id: mincov
    type:
      - 'null'
      - int
    doc: minimum depth considered callable
    default: 4
    inputBinding:
      position: 102
      prefix: --mincov
  - id: ordered
    type:
      - 'null'
      - boolean
    doc: force output to be in same order as input even with -p.
    inputBinding:
      position: 102
      prefix: --ordered
  - id: processes
    type:
      - 'null'
      - int
    doc: number of processors to parallelize.
    inputBinding:
      position: 102
      prefix: --processes
  - id: q
    type:
      - 'null'
      - int
    doc: mapping quality cutoff
    default: 1
    inputBinding:
      position: 102
      prefix: --q
  - id: reference
    type:
      - 'null'
      - File
    doc: path to reference fasta
    inputBinding:
      position: 102
      prefix: --reference
  - id: stats
    type:
      - 'null'
      - boolean
    doc: report sequence stats [GC CpG masked] for each window
    inputBinding:
      position: 102
      prefix: --stats
  - id: windowsize
    type:
      - 'null'
      - int
    doc: window size in which to calculate high-depth regions
    default: 250
    inputBinding:
      position: 102
      prefix: --windowsize
outputs:
  - id: prefix
    type:
      - 'null'
      - File
    doc: prefix for output files depth.bed and callable.bed
    outputBinding:
      glob: $(inputs.prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/goleft:0.2.6--he881be0_1
