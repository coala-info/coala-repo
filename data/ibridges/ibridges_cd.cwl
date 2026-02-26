cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibridges cd
label: ibridges_cd
doc: "Change current working collection for the iRODS server.\n\nTool homepage: https://github.com/iBridges-for-iRODS/iBridges"
inputs:
  - id: remote_coll
    type:
      - 'null'
      - string
    doc: Path to remote iRODS location.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
stdout: ibridges_cd.out
