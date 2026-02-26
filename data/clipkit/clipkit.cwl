cwlVersion: v1.2
class: CommandLineTool
baseCommand: clipkit
label: clipkit
doc: "ClipKIT trims multiple sequence alignments and maintains phylogenetically informative
  sites.\n\nTool homepage: https://github.com/jlsteenwyk/clipkit"
inputs:
  - id: input
    type: File
    doc: input file
    inputBinding:
      position: 1
  - id: auxiliary_file
    type:
      - 'null'
      - File
    doc: auxiliary file with meta-information for various trimming modes (e.g., 
      user-specified)
    inputBinding:
      position: 102
      prefix: --auxiliary_file
  - id: codon
    type:
      - 'null'
      - boolean
    doc: conduct trimming of codons
    inputBinding:
      position: 102
      prefix: --codon
  - id: complementary
    type:
      - 'null'
      - boolean
    doc: creates complementary alignment of trimmed sequences
    inputBinding:
      position: 102
      prefix: --complementary
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: run trimming and report stats without writing output files
    inputBinding:
      position: 102
      prefix: --dry_run
  - id: ends_only
    type:
      - 'null'
      - boolean
    doc: trim only from the ends of the alignment
    inputBinding:
      position: 102
      prefix: --ends_only
  - id: gap_characters
    type:
      - 'null'
      - string
    doc: specifies gap characters used in input file
    inputBinding:
      position: 102
      prefix: --gap_characters
  - id: gaps_threshold
    type:
      - 'null'
      - float
    doc: specifies gaps threshold
    default: 0.9
    inputBinding:
      position: 102
      prefix: --gaps
  - id: input_file_format
    type:
      - 'null'
      - string
    doc: specifies input file format
    default: auto-detect
    inputBinding:
      position: 102
      prefix: --input_file_format
  - id: log
    type:
      - 'null'
      - boolean
    doc: creates a log file
    inputBinding:
      position: 102
      prefix: --log
  - id: mode
    type:
      - 'null'
      - string
    doc: trimming mode
    default: smart-gap
    inputBinding:
      position: 102
      prefix: --mode
  - id: output_file_format
    type:
      - 'null'
      - string
    doc: specifies output file format
    inputBinding:
      position: 102
      prefix: --output_file_format
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: disables all logging to stdout
    inputBinding:
      position: 102
      prefix: --quiet
  - id: sequence_type
    type:
      - 'null'
      - string
    doc: specifies sequence type of input file
    default: auto-detect
    inputBinding:
      position: 102
      prefix: --sequence_type
  - id: threads
    type:
      - 'null'
      - int
    doc: requested number of threads to use for parallel processing
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: validate_only
    type:
      - 'null'
      - boolean
    doc: validate input/settings and exit without trimming
    inputBinding:
      position: 102
      prefix: --validate_only
outputs:
  - id: output_file_name
    type:
      - 'null'
      - File
    doc: output file name
    outputBinding:
      glob: $(inputs.output_file_name)
  - id: report_json
    type:
      - 'null'
      - File
    doc: write run summary as JSON
    outputBinding:
      glob: $(inputs.report_json)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clipkit:2.10.2--pyhdfd78af_0
