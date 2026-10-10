cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dict-utils
  - split
label: mgkit_dict-utils_split
doc: "Split values in a dictionary file\n\nTool homepage: https://github.com/frubino/mgkit"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output (debug messages).
    inputBinding:
      position: 101
      prefix: -v
  - id: separator
    type:
      - 'null'
      - string
    doc: 'Field separator for map file Key/Value (default: tab)'
    inputBinding:
      position: 101
      prefix: -s
  - id: value_separator
    type:
      - 'null'
      - string
    doc: 'Field separator values (default: ,)'
    inputBinding:
      position: 101
      prefix: -vs
  - id: no_separator
    type:
      - 'null'
      - boolean
    doc: Values are string to be split by character
    inputBinding:
      position: 101
      prefix: --no-separator
  - id: output_separator
    type:
      - 'null'
      - string
    doc: 'Field separator for Output map file Key/Value (default: tab)'
    inputBinding:
      position: 101
      prefix: -os
  - id: input_file
    type: File
    doc: Dictionary file.
    inputBinding:
      position: 102
  - id: output_file
    type: string
    doc: Output file name (written instead of standard output).
    inputBinding:
      position: 103
outputs:
  - id: output
    type: File
    doc: Dictionary file with split values.
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
