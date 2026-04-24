cwlVersion: v1.2
class: CommandLineTool
baseCommand: gia complement
label: gia_complement
doc: "Generates the complement of a BED file\n\nThis reports the regions that are
  not covered by the input BED file but excludes regions preceding the first interval
  and following the last interval.\n\nTool homepage: https://github.com/noamteyssier/gia"
inputs:
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level to use for output files if applicable
    inputBinding:
      position: 101
      prefix: --compression-level
  - id: compression_threads
    type:
      - 'null'
      - int
    doc: Compression threads to use for output files if applicable
    inputBinding:
      position: 101
      prefix: --compression-threads
  - id: field_format
    type:
      - 'null'
      - string
    doc: "Allow for non-integer chromosome names\n          \n          [possible
      values: integer-based, string-based]"
    inputBinding:
      position: 101
      prefix: --field-format
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input BED file to process (default=stdin)
    inputBinding:
      position: 101
      prefix: --input
  - id: input_format
    type:
      - 'null'
      - string
    doc: "Format of input file\n          \n          [possible values: bed3, bed4,
      bed6, gtf, bed12, ambiguous, bed-graph]"
    inputBinding:
      position: 101
      prefix: --input-format
  - id: sorted
    type:
      - 'null'
      - boolean
    doc: Assume input is sorted (default=false)
    inputBinding:
      position: 101
      prefix: --sorted
  - id: stream
    type:
      - 'null'
      - boolean
    doc: "Stream the input file instead of loading it into memory\n          \n  \
      \        Note that this requires the input file to be sorted and will result
      in undefined behavior if it is not."
    inputBinding:
      position: 101
      prefix: --stream
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output BED file to write to (default=stdout)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gia:0.2.23--h588a25a_0
