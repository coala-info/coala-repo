cwlVersion: v1.2
class: CommandLineTool
baseCommand: gia_extend
label: gia_extend
doc: "Extends the intervals of a BED file\n\nTool homepage: https://github.com/noamteyssier/gia"
inputs:
  - id: both
    type:
      - 'null'
      - float
    doc: Amount to apply to function on both sides of intervals
    inputBinding:
      position: 101
      prefix: --both
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level to use for output files if applicable
    default: 6
    inputBinding:
      position: 101
      prefix: --compression-level
  - id: compression_threads
    type:
      - 'null'
      - int
    doc: Compression threads to use for output files if applicable
    default: 1
    inputBinding:
      position: 101
      prefix: --compression-threads
  - id: field_format
    type:
      - 'null'
      - string
    doc: Allow for non-integer chromosome names
    inputBinding:
      position: 101
      prefix: --field-format
  - id: genome
    type:
      - 'null'
      - File
    doc: Genome file to validate growth against
    inputBinding:
      position: 101
      prefix: --genome
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input BED file to process
    default: stdin
    inputBinding:
      position: 101
      prefix: --input
  - id: input_format
    type:
      - 'null'
      - string
    doc: Format of input file
    inputBinding:
      position: 101
      prefix: --input-format
  - id: left
    type:
      - 'null'
      - float
    doc: Amount to apply to function on the left side of intervals
    inputBinding:
      position: 101
      prefix: --left
  - id: percent
    type:
      - 'null'
      - boolean
    doc: Convert values provided to percentages of the interval length
    inputBinding:
      position: 101
      prefix: --percent
  - id: right
    type:
      - 'null'
      - float
    doc: Amount to apply to function on the right side of intervals
    inputBinding:
      position: 101
      prefix: --right
  - id: stranded
    type:
      - 'null'
      - boolean
    doc: "Follow strand specificity when applying growth\ni.e. if the strand is negative,
      apply growth to the right side of the interval when the left side is requested
      (and vice versa)"
    default: false
    inputBinding:
      position: 101
      prefix: --stranded
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output BED file to write to
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gia:0.2.23--h588a25a_0
