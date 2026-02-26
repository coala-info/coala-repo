cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibridges_rm
label: ibridges_rm
doc: "Remove collection or data object.\n\nTool homepage: https://github.com/iBridges-for-iRODS/iBridges"
inputs:
  - id: remote_path
    type: string
    doc: Collection or data object to remove.
    inputBinding:
      position: 1
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Remove collections and their content recursively.
    inputBinding:
      position: 102
      prefix: --recursive
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
stdout: ibridges_rm.out
