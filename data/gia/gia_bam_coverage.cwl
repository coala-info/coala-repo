cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gia
  - bam
  - coverage
label: gia_bam_coverage
doc: "Measure coverage of BAM records over interval regions\n\nTool homepage: https://github.com/noamteyssier/gia"
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
  - id: sorted
    type:
      - 'null'
      - boolean
    doc: "Assert that the intervals are presorted in BOTH files"
    inputBinding:
      position: 101
      prefix: --sorted
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use when reading BAM file"
    inputBinding:
      position: 101
      prefix: --threads
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
  - id: compression_level
    type:
      - 'null'
      - int
    doc: "Compression level to use for output files if applicable"
    inputBinding:
      position: 101
      prefix: --compression-level
  - id: compression_threads
    type:
      - 'null'
      - int
    doc: "Compression threads to use for output files if applicable"
    inputBinding:
      position: 101
      prefix: --compression-threads
  - id: output_path
    type: string
    doc: "Output file to write to"
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: BED file with coverage
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gia:0.2.23--h588a25a_0
