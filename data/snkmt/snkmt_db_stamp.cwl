cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snkmt
  - db
  - stamp
label: snkmt_db_stamp
doc: "Manually stamp database with a schema revision without running migrations.\n\nTool homepage: https://github.com/cademirch/snkmt"
inputs:
  - id: revision
    type:
      - 'null'
      - string
    doc: "Alembic revision to stamp (default: latest)."
    inputBinding:
      position: 1
  - id: database
    type: File
    doc: "Database file; it is staged writable and the changed copy is returned (passed with --db-path)"
    inputBinding:
      position: 101
      prefix: --db-path
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Enable debug logging."
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (messages of snkmt are written here)
  - id: database_out
    type: File
    doc: The database file after the command
    outputBinding:
      glob: $(inputs.database.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.database)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snkmt:0.2.4--pyhdfd78af_0
stdout: snkmt_db_stamp.out
stderr: snkmt_db_stamp.err
