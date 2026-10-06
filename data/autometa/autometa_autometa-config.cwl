cwlVersion: v1.2
class: CommandLineTool
baseCommand: autometa-config
label: autometa_autometa-config
doc: "Update Autometa configuration using provided arguments\n\nTool homepage: https://github.com/KwanLab/Autometa"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: section
    type:
      - 'null'
      - string
    doc: "config section to update (environ, databases, ncbi, markers, gtdb)"
    inputBinding:
      position: 1
      prefix: --section
  - id: option
    type:
      - 'null'
      - string
    doc: "option in `--section` to update"
    inputBinding:
      position: 1
      prefix: --option
  - id: value
    type:
      - 'null'
      - string
    doc: "Value to update `--option`"
    inputBinding:
      position: 1
      prefix: --value
  - id: print
    type:
      - 'null'
      - boolean
    doc: "Print configuration without updating"
    inputBinding:
      position: 1
      prefix: --print
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
stdout: autometa-config.out
