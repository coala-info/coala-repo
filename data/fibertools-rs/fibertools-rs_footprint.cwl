cwlVersion: v1.2
class: CommandLineTool
baseCommand: [ft, footprint]
label: fibertools-rs_footprint
doc: "Infer footprints from fiberseq data\n\nTool homepage: https://github.com/fiberseq/fibertools-rs"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fibertools-rs:0.8.2--h3b373d1_0
inputs:
  - id: bed
    type: File
    doc: "BED file with the regions to footprint. Should all contain the same motif with proper strand information, and ideally be ChIP-seq peaks."
    inputBinding:
      position: 1
      prefix: --bed
  - id: yaml
    type: File
    doc: "YAML file describing the modules of the footprint."
    inputBinding:
      position: 1
      prefix: --yaml
  - id: out_file
    type: string
    doc: "Output file name. The help says BAM, but ft 0.8.2 writes a tab-separated footprint table."
    default: "footprints.tsv"
    inputBinding:
      position: 1
      prefix: --out
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
    doc: "Input BAM file. For m6A prediction this should be a HiFi BAM file with kinetics data. For other commands this should be a BAM file with m6A calls. Needs a BAM index (.bai) beside it."
    secondaryFiles:
      - pattern: .bai
        required: true
    inputBinding:
      position: 10
outputs:
  - id: footprints
    type: File
    doc: "Tab-separated table with one row per BED region: spanning fibers, per-module footprint counts, footprint codes, fire qualities and fiber names."
    outputBinding:
      glob: $(inputs.out_file)
