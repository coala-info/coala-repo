cwlVersion: v1.2
class: CommandLineTool
baseCommand: compleasm_list
label: compleasm_list
doc: "List BUSCO lineages\n\nTool homepage: https://github.com/huangnengCSU/compleasm"
inputs:
  - id: library_path
    type:
      - 'null'
      - Directory
    doc: Folder path to stored lineages.
    inputBinding:
      position: 101
      prefix: --library_path
  - id: local
    type:
      - 'null'
      - boolean
    doc: List local BUSCO lineages
    inputBinding:
      position: 101
      prefix: --local
  - id: odb
    type:
      - 'null'
      - string
    doc: OrthoDB version
    default: odb12
    inputBinding:
      position: 101
      prefix: --odb
  - id: remote
    type:
      - 'null'
      - boolean
    doc: List remote BUSCO lineages
    inputBinding:
      position: 101
      prefix: --remote
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/compleasm:0.2.7--pyh7e72e81_1
stdout: compleasm_list.out
