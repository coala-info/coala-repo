cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyani-plus
  - export-run
label: pyani-plus_export-run
doc: "Export any single run from the given pyANI-plus SQLite3 database.\n\nTool homepage:
  https://github.com/pyani-plus/pyani-plus"
inputs:
  - id: database
    type: File
    doc: Path to pyANI-plus SQLite3 database.
    inputBinding:
      position: 101
      prefix: --database
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Show debugging level logging at the terminal (in addition to the log 
      file).
    inputBinding:
      position: 101
      prefix: --debug
  - id: label
    type:
      - 'null'
      - string
    doc: How to label the genomes.
    inputBinding:
      position: 101
      prefix: --label
  - id: log
    type:
      - 'null'
      - File
    doc: Where to record log(s). Use '-' for no logging.
    inputBinding:
      position: 101
      prefix: --log
  - id: outdir
    type: Directory
    doc: Output directory. Created if does not already exist.
    inputBinding:
      position: 101
      prefix: --outdir
  - id: run_id
    type:
      - 'null'
      - int
    doc: Which run from the database (defaults to latest).
    inputBinding:
      position: 101
      prefix: --run-id
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyani-plus:1.0.0--pyhdfd78af_0
stdout: pyani-plus_export-run.out
