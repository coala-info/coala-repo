cwlVersion: v1.2
class: CommandLineTool
baseCommand: primer3_core
label: primer3_primer3_core
doc: "This is primer3 (libprimer3 release 2.6.1)\n\nTool homepage: https://github.com/primer3-org/primer3"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input file with the Boulder-IO records (the sequence and the primer picking settings). If not provided, input is read from standard input."
    inputBinding:
      position: 2
  - id: default_version
    type:
      - 'null'
      - int
    doc: "Set default version to 1 or 2"
    inputBinding:
      position: 1
      prefix: --default_version=
      separate: false
  - id: io_version
    type:
      - 'null'
      - int
    doc: "Set IO version (4)"
    inputBinding:
      position: 1
      prefix: --io_version=
      separate: false
  - id: p3_settings_file
    type:
      - 'null'
      - File
    doc: "Path to primer3 settings file"
    inputBinding:
      position: 1
      prefix: --p3_settings_file=
      separate: false
  - id: echo_settings_file
    type:
      - 'null'
      - boolean
    doc: "Echo settings file"
    inputBinding:
      position: 1
      prefix: --echo_settings_file
  - id: format_output
    type:
      - 'null'
      - boolean
    doc: "Format output"
    inputBinding:
      position: 1
      prefix: --format_output
  - id: strict_tags
    type:
      - 'null'
      - boolean
    doc: "Enforce strict tag checking"
    inputBinding:
      position: 1
      prefix: --strict_tags
  - id: error_path
    type:
      - 'null'
      - string
    doc: "Error file path"
    inputBinding:
      position: 1
      prefix: --error=
      separate: false
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Output file path"
    inputBinding:
      position: 1
      prefix: --output=
      separate: false
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file path
    outputBinding:
      glob: $(inputs.output_path)
  - id: error
    type:
      - 'null'
      - File
    doc: Error file path
    outputBinding:
      glob: $(inputs.error_path)
  - id: stdout
    type: stdout
    doc: Standard output (primer picking result when --output is not given)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primer3:2.6.1--pl5262h1b792b2_0
stdout: primer3_primer3_core.out
