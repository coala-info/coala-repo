cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibridges_meta-add
label: ibridges_meta-add
doc: "Add a metadata item to a collection or data object.\n\nTool homepage: https://github.com/iBridges-for-iRODS/iBridges"
inputs:
  - id: remote_path
    type: string
    doc: Path to add a new metadata item to.
    inputBinding:
      position: 1
  - id: key
    type: string
    doc: Key for the new metadata item.
    inputBinding:
      position: 2
  - id: value
    type: string
    doc: Value for the new metadata item.
    inputBinding:
      position: 3
  - id: units
    type:
      - 'null'
      - string
    doc: Units for the new metadata item.
    inputBinding:
      position: 4
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
stdout: ibridges_meta-add.out
