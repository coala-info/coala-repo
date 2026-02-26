cwlVersion: v1.2
class: CommandLineTool
baseCommand: yamllint
label: yamllint
doc: "A linter for YAML files. yamllint does not only check for syntax validity, but
  for weirdnesses like key repetition and cosmetic problems such as lines length,
  trailing spaces, indentation, etc.\n\nTool homepage: https://github.com/adrienverge/yamllint"
inputs:
  - id: file_or_dir
    type:
      type: array
      items: File
    doc: files to check
    inputBinding:
      position: 1
  - id: config_data
    type:
      - 'null'
      - string
    doc: custom configuration (as YAML source)
    inputBinding:
      position: 102
      prefix: --config-data
  - id: config_file
    type:
      - 'null'
      - File
    doc: path to a custom configuration
    inputBinding:
      position: 102
      prefix: --config-file
  - id: format
    type:
      - 'null'
      - string
    doc: format for parsing output
    inputBinding:
      position: 102
      prefix: --format
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yamllint:1.2.1--py35_0
stdout: yamllint.out
