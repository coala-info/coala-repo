cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phizz
  - delete
label: phizz_delete
doc: "Delete the database.\n\nTool homepage: https://github.com/moonso/phizz"
inputs:
  - id: db_name
    type: File
    doc: The database file to delete (staged writable in the working directory)
    inputBinding:
      position: 101
      prefix: --db_name
      valueFrom: $(self.basename)
  - id: db_path
    type:
      - 'null'
      - string
    doc: Path to store the database
    inputBinding:
      position: 102
      prefix: --path
outputs:
  - id: log
    type: stderr
    doc: Log with the deletion message
stderr: phizz_delete.log
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.db_name)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phizz:0.2.3--py_0
