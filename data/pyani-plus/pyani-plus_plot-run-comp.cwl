cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyani-plus plot-run-comp
label: pyani-plus_plot-run-comp
doc: "Plot comparisons between multiple runs.\n\nTool homepage: https://github.com/pyani-plus/pyani-plus"
inputs:
  - id: columns
    type:
      - 'null'
      - int
    doc: How many columns to use when tiling plots of multiple runs. Default 0 
      means automatically tries for square tiling.
    default: 0
    inputBinding:
      position: 101
      prefix: --columns
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
  - id: log
    type:
      - 'null'
      - File
    doc: Where to record log(s). Use '-' for no logging.
    default: '-'
    inputBinding:
      position: 101
      prefix: --log
  - id: run_ids
    type: string
    doc: Which runs (comma separated list, reference first)?
    default: None
    inputBinding:
      position: 101
      prefix: --run-ids
outputs:
  - id: outdir
    type: Directory
    doc: Output directory. Created if does not already exist.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyani-plus:1.0.0--pyhdfd78af_0
