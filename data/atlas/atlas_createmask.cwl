cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - atlas
  - createMask
label: atlas_createmask
doc: "Creating a mask BED file from a BAM file.\n\nTool homepage: https://bitbucket.org/wegmannlab/atlas"
inputs:
  - id: bam
    type: File
    doc: "Input BAM file."
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 1
      prefix: --bam
  - id: keep_reads_without_rg
    type:
      - 'null'
      - boolean
    doc: "Keep reads without a read group (by default ATLAS filters them out)."
    inputBinding:
      position: 1
      prefix: --keepReadsWithoutRG
  - id: fasta
    type:
      - 'null'
      - File
    doc: "Reference genome FASTA (with .fai index)."
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 1
      prefix: --fasta
  - id: mask_type
    type: string
    doc: "Type of mask: depth, nonRef, invariant or variant."
    inputBinding:
      position: 1
      prefix: --type
  - id: min_depth
    type:
      - 'null'
      - int
    doc: "Minimum depth (sites below are masked with --type depth)."
    inputBinding:
      position: 1
      prefix: --minDepth
  - id: max_depth
    type:
      - 'null'
      - int
    doc: "Maximum depth (sites above are masked with --type depth)."
    inputBinding:
      position: 1
      prefix: --maxDepth
  - id: min_depth_for_mask
    type:
      - 'null'
      - int
    doc: "Minimum depth for a site to be added to the mask (nonRef, invariant, variant)."
    inputBinding:
      position: 1
      prefix: --minDepthForMask
  - id: filter_mq
    type:
      - 'null'
      - string
    doc: "Keep reads with mapping quality in this range, e.g. \"[30,256]\"."
    inputBinding:
      position: 1
      prefix: --filterMQ
  - id: chr
    type:
      - 'null'
      - string
    doc: "Comma-separated list of chromosomes to use."
    inputBinding:
      position: 1
      prefix: --chr
  - id: out_prefix
    type: string
    doc: "Prefix for all output files (ATLAS --out)."
    default: "atlas_createMask"
    inputBinding:
      position: 1
      prefix: --out
outputs:
  - id: log
    type: stdout
    doc: ATLAS progress report (standard output).
  - id: mask_bed
    type: File
    doc: "0-based BED file with the masked regions."
    outputBinding:
      glob: $(inputs.out_prefix)_*Mask.bed
  - id: parameters
    type:
      - 'null'
      - File
    doc: "Parameters used for the run."
    outputBinding:
      glob: $(inputs.out_prefix).parameters
  - id: filter_summary
    type:
      - 'null'
      - File
    doc: "Counts of reads removed by each filter."
    outputBinding:
      glob: $(inputs.out_prefix)_filterSummary.txt
  - id: rg_info
    type:
      - 'null'
      - File
    doc: "Read group information."
    outputBinding:
      glob: $(inputs.out_prefix)_RGInfo.json
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atlas:2.0.1--hadca570_0
stdout: atlas_createmask.log
