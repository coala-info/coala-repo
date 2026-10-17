cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pybel
  - neo
label: pybel_neo
doc: "Upload to neo4j.\n\nTool homepage: https://pybel.readthedocs.io"
inputs:
  - id: path
    type: File
    doc: "Compiled graph pickle written by pybel compile (a BEL script path also works when its compiled pickle is beside it)"
    inputBinding:
      position: 1
  - id: connection
    type:
      - 'null'
      - string
    doc: "Connection string for neo4j upload."
    inputBinding:
      position: 10
      prefix: --connection
  - id: password
    type:
      - 'null'
      - string
    doc: "Neo4j password"
    inputBinding:
      position: 10
      prefix: --password
outputs:
  - id: stdout_text
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybel:0.13.2--py_0
stdout: pybel_neo.out
