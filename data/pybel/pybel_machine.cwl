cwlVersion: v1.2
class: CommandLineTool
baseCommand: pybel
label: pybel_machine
doc: "Get content from the INDRA machine and upload to BEL Commons.\n\nTool homepage: https://pybel.readthedocs.io"
arguments:
  - position: 2
    valueFrom: machine
inputs:
  - id: database
    type: string
    doc: "SQLite database file name used as the connection (sqlite:///NAME); created when it does not exist"
    inputBinding:
      position: 1
      prefix: -c
      valueFrom: sqlite:///$(self)
  - id: database_in
    type:
      - 'null'
      - File
    doc: Existing database to use (staged as a writable copy under the name given by database).
  - id: agents
    type:
      - 'null'
      - type: array
        items: string
    doc: INDRA agents to query
    inputBinding:
      position: 10
  - id: local
    type:
      - 'null'
      - boolean
    doc: "Upload to local database."
    inputBinding:
      position: 10
      prefix: --local
  - id: host
    type:
      - 'null'
      - string
    doc: "URL of BEL Commons."
    inputBinding:
      position: 10
      prefix: --host
outputs:
  - id: database_out
    type: File
    doc: Database file after the command
    outputBinding:
      glob: $(inputs.database)
  - id: stdout_text
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.database)
        entry: $(inputs.database_in)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybel:0.13.2--py_0
stdout: pybel_machine.out
