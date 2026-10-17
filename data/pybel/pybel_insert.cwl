cwlVersion: v1.2
class: CommandLineTool
baseCommand: pybel
label: pybel_insert
doc: "Insert a graph to the database.\n\nTool homepage: https://pybel.readthedocs.io"
arguments:
  - position: 2
    valueFrom: insert
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
  - id: path
    type: File
    doc: "Compiled graph pickle written by pybel compile"
    inputBinding:
      position: 10
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
stdout: pybel_insert.out
