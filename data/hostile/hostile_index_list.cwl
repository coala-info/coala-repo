cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hostile
  - index
  - list
label: hostile_index_list
doc: "List available remote and local cached indexes\n\nTool homepage: https://github.com/bede/hostile"
inputs:
  - id: airplane
    type:
      - 'null'
      - boolean
    doc: list only local cached indexes (offline mode)
    inputBinding:
      position: 101
      prefix: --airplane
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hostile:2.0.2--pyhdfd78af_0
stdout: hostile_index_list.out
