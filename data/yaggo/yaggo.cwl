cwlVersion: v1.2
class: CommandLineTool
baseCommand: yaggo
label: yaggo
doc: "Error: some yaggo files and/or --lib switch is required\n\nTool homepage: https://github.com/gmarcais/yaggo"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input yaggo file
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug yaggo
    inputBinding:
      position: 102
      prefix: --debug
  - id: extended_syntax
    type:
      - 'null'
      - boolean
    doc: Use extended syntax
    inputBinding:
      position: 102
      prefix: --extended-syntax
  - id: license_file
    type:
      - 'null'
      - File
    doc: License file to copy in header
    inputBinding:
      position: 102
      prefix: --license
  - id: man_file
    type:
      - 'null'
      - File
    doc: Display or write manpage
    inputBinding:
      position: 102
      prefix: --man
  - id: stub
    type:
      - 'null'
      - boolean
    doc: Output a stub yaggo file
    inputBinding:
      position: 102
      prefix: --stub
  - id: zsh_completion_file
    type:
      - 'null'
      - File
    doc: Write zsh completion file
    inputBinding:
      position: 102
      prefix: --zc
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
    dockerPull: quay.io/biocontainers/yaggo:1.5.10--0
