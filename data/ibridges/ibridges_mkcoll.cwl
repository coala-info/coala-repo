cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibridges mkcoll
label: ibridges_mkcoll
doc: "Create a new collecion with all its parent collections.\n\nTool homepage: https://github.com/iBridges-for-iRODS/iBridges"
inputs:
  - id: remote_coll
    type: string
    doc: Path to a new collection, should start with 'irods:'.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
stdout: ibridges_mkcoll.out
