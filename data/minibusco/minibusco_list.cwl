cwlVersion: v1.2
class: CommandLineTool
baseCommand: minibusco list
label: minibusco_list
doc: "List BUSCO lineages\n\nTool homepage: https://github.com/huangnengCSU/minibusco"
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
    dockerPull: quay.io/biocontainers/minibusco:0.2.1--pyh7cba7a3_0
stdout: minibusco_list.out
