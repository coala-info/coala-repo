cwlVersion: v1.2
class: CommandLineTool
baseCommand: [ft, track-decorators]
label: fibertools-rs_track-decorators
doc: "Make decorated bed files for fiberseq data\n\nTool homepage: https://github.com/fiberseq/fibertools-rs"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fibertools-rs:0.8.2--h3b373d1_0
inputs:
  - id: out_bed12
    type: string
    doc: "Output path for the bed12 file to be decorated."
    default: "tracks.bed12"
    inputBinding:
      position: 1
      prefix: --bed12
  - id: out_decorator
    type: string
    doc: "Output path for the decorator bed file."
    default: "decorators.bed"
    inputBinding:
      position: 1
      prefix: --decorator
  - id: filter
    type: ['null', int]
    doc: "BAM bit flags to filter on, equivalent to `-F` in samtools view (default 0)."
    inputBinding:
      position: 1
      prefix: -F
  - id: ftx
    type: ['null', string]
    doc: "Filtering expression to use for filtering records, for example \"len(nuc)>150\" or \"len(nuc)<150,len(msp)=30:50\". Supports len() and qual() over msp, nuc, m6a, cpg."
    inputBinding:
      position: 1
      prefix: -x
  - id: ml
    type: ['null', int]
    doc: "Minimum score in the ML tag to use or include in the output (default 125)."
    inputBinding:
      position: 1
      prefix: --ml
  - id: uncompressed
    type: ['null', boolean]
    doc: "Output uncompressed BAM files."
    inputBinding:
      position: 1
      prefix: -u
  - id: threads
    type: ['null', int]
    doc: "Threads (default 8)."
    inputBinding:
      position: 1
      prefix: -t
  - id: verbose
    type: ['null', boolean]
    doc: "Logging level: info. Use ft help for deeper levels."
    inputBinding:
      position: 1
      prefix: -v
  - id: quiet
    type: ['null', boolean]
    doc: "Turn off all logging."
    inputBinding:
      position: 1
      prefix: --quiet
  - id: bam
    type: File
    doc: "Input BAM file. For m6A prediction this should be a HiFi BAM file with kinetics data. For other commands this should be a BAM file with m6A calls."
    inputBinding:
      position: 10
outputs:
  - id: bed12
    type: File
    doc: "Bed12 file to be decorated."
    outputBinding:
      glob: $(inputs.out_bed12)
  - id: decorator
    type: File
    doc: "Decorator bed file."
    outputBinding:
      glob: $(inputs.out_decorator)
