cwlVersion: v1.2
class: CommandLineTool
baseCommand: pybel neo
label: pybel_neo
doc: "Upload to neo4j.\n\nTool homepage: https://pybel.readthedocs.io"
inputs:
  - id: path
    type: string
    doc: Path to upload
    inputBinding:
      position: 1
  - id: connection
    type:
      - 'null'
      - string
    doc: Connection string for neo4j upload.
    inputBinding:
      position: 102
      prefix: --connection
  - id: password
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: --password
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybel:0.13.2--py_0
stdout: pybel_neo.out
