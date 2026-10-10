cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dict-utils
  - reverse
label: mgkit_dict-utils_reverse
doc: "Reverse Key/Value in a dictionary file\n\nTool homepage: https://github.com/frubino/mgkit"
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
  - id: output_separator
    type:
      - 'null'
      - string
    doc: 'Field separator for Output map file Key/Value (default: tab)'
    inputBinding:
      position: 101
      prefix: -os
  - id: randomise
    type:
      - 'null'
      - boolean
    doc: Randomise the output.
    inputBinding:
      position: 101
      prefix: -r
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
    doc: Reversed dictionary file.
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
