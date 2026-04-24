cwlVersion: v1.2
class: CommandLineTool
baseCommand: primer3_core
label: primer3_primer3_core
doc: "This is primer3 (libprimer3 release 2.6.1)\n\nTool homepage: https://github.com/primer3-org/primer3"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file path. If not provided, input is read from standard input.
    inputBinding:
      position: 1
  - id: default_version
    type:
      - 'null'
      - int
    doc: Set default version to 1 or 2
    inputBinding:
      position: 102
      prefix: --default_version
  - id: echo_settings_file
    type:
      - 'null'
      - boolean
    doc: Echo settings file
    inputBinding:
      position: 102
      prefix: --echo_settings_file
  - id: format_output
    type:
      - 'null'
      - boolean
    doc: Format output
    inputBinding:
      position: 102
      prefix: --format_output
  - id: io_version
    type:
      - 'null'
      - int
    doc: Set IO version
    inputBinding:
      position: 102
      prefix: --io_version
  - id: p3_settings_file
    type:
      - 'null'
      - File
    doc: Path to primer3 settings file
    inputBinding:
      position: 102
      prefix: --p3_settings_file
  - id: strict_tags
    type:
      - 'null'
      - boolean
    doc: Enforce strict tag checking
    inputBinding:
      position: 102
      prefix: --strict_tags
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file path
    outputBinding:
      glob: $(inputs.output)
  - id: error
    type:
      - 'null'
      - File
    doc: Error file path
    outputBinding:
      glob: $(inputs.error)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primer3:2.6.1--pl5262h1b792b2_0
