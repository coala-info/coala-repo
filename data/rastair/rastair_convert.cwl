cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rastair
  - convert
label: rastair_convert
doc: "Convert between different file formats\n\nTool homepage: https://bitbucket.org/bsblabludwig/rastair/src/v0.8.2/"
inputs:
  - id: all_positions
    type:
      - 'null'
      - boolean
    doc: Output all positions, even if they do not pass filters.
    inputBinding:
      position: 101
      prefix: --all
  - id: bed_include_empty
    type:
      - 'null'
      - boolean
    doc: Include CpG positions with zero coverage
    inputBinding:
      position: 101
      prefix: --bed-include-empty
  - id: bed_ml_threshold
    type:
      - 'null'
      - float
    doc: Minimum ML score to consider a position as variant
    inputBinding:
      position: 101
      prefix: --bed-ml
  - id: cpgs_only
    type:
      - 'null'
      - boolean
    doc: Report CpGs only and default to BED output
    inputBinding:
      position: 101
      prefix: --cpgs-only
  - id: error_model
    type:
      - 'null'
      - string
    doc: Error model to use for processing
    inputBinding:
      position: 101
      prefix: --error-model
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file
    inputBinding:
      position: 101
      prefix: --input
  - id: input_format
    type:
      - 'null'
      - string
    doc: Input file format, guessed from file extension if not specified
    inputBinding:
      position: 101
      prefix: --input-format
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output file format, guessed from file extension if not specified
    inputBinding:
      position: 101
      prefix: --output-format
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable more logging
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rastair:2.0.0--h03e3cfe_0
