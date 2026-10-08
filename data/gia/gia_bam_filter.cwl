cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gia
  - bam
  - filter
label: gia_bam_filter
doc: "Filter BAM records based on overlap criteria to other regions\n\nTool homepage: https://github.com/noamteyssier/gia"
inputs:
  - id: bam
    type: File
    doc: "Input BAM file to process"
    inputBinding:
      position: 101
      prefix: --bam
  - id: bed
    type: File
    doc: "Input BED file to process"
    inputBinding:
      position: 101
      prefix: --bed
  - id: fraction_query
    type:
      - 'null'
      - float
    doc: "Minimum fraction of a's interval that must be covered by b's interval"
    inputBinding:
      position: 101
      prefix: --fraction-query
  - id: fraction_target
    type:
      - 'null'
      - float
    doc: "Minimum fraction of b's interval that must be covered by a's interval"
    inputBinding:
      position: 101
      prefix: --fraction-target
  - id: reciprocal
    type:
      - 'null'
      - boolean
    doc: "Require that the fraction provided with -f is reciprocal to both query and target"
    inputBinding:
      position: 101
      prefix: --reciprocal
  - id: either
    type:
      - 'null'
      - boolean
    doc: "Requires that either fraction provided with -f or -F is met"
    inputBinding:
      position: 101
      prefix: --either
  - id: strandedness
    type:
      - 'null'
      - string
    doc: "Strand-specificity to use when comparing intervals (i, m, o)"
    inputBinding:
      position: 101
      prefix: --strandedness
  - id: invert
    type:
      - 'null'
      - boolean
    doc: "Only return the records from a that DON'T overlap with b"
    inputBinding:
      position: 101
      prefix: --invert
  - id: format
    type:
      - 'null'
      - string
    doc: "Output format (bam, sam, cram)"
    inputBinding:
      position: 101
      prefix: --format
  - id: threads
    type:
      - 'null'
      - int
    doc: "Threads to use when writing BAM files"
    inputBinding:
      position: 101
      prefix: --threads
  - id: output_path
    type: string
    doc: "Output file to write to"
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Filtered BAM/SAM/CRAM file
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gia:0.2.23--h588a25a_0
