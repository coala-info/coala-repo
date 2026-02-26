cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibridges meta-del
label: ibridges_meta-del
doc: "Delete metadata for one collection or data object.\n\nTool homepage: https://github.com/iBridges-for-iRODS/iBridges"
inputs:
  - id: remote_path
    type: string
    doc: Path to delete metadata entries from.
    inputBinding:
      position: 1
  - id: ignore_blacklist
    type:
      - 'null'
      - boolean
    doc: Ignore the metadata blacklist.
    inputBinding:
      position: 102
      prefix: --ignore-blacklist
  - id: key
    type:
      - 'null'
      - string
    doc: Key for which to delete the entries.
    inputBinding:
      position: 102
      prefix: --key
  - id: units
    type:
      - 'null'
      - string
    doc: Units for which to delete the entries.
    inputBinding:
      position: 102
      prefix: --units
  - id: value
    type:
      - 'null'
      - string
    doc: Value for which to delete the entries.
    inputBinding:
      position: 102
      prefix: --value
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
stdout: ibridges_meta-del.out
