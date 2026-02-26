cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibridges_meta-list
label: ibridges_meta-list
doc: "List the metadata of a data object or collection on iRODS.\n\nTool homepage:
  https://github.com/iBridges-for-iRODS/iBridges"
inputs:
  - id: remote_path
    type:
      - 'null'
      - string
    doc: iRODS path for metadata listing, starting with 'irods:'.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
stdout: ibridges_meta-list.out
