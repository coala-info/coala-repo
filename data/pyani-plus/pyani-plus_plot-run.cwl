cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyani-plus
  - plot-run
label: pyani-plus_plot-run
doc: "Plot heatmaps and distributions for any single run.\n\nTool homepage: https://github.com/pyani-plus/pyani-plus"
inputs:
  - id: database
    type: File
    doc: "Path to pyANI-plus SQLite3 database (a writable copy is used)."
    inputBinding:
      position: 1
      prefix: --database
      valueFrom: $(self.basename)
  - id: outdir
    type: string
    doc: "Output directory. Created if does not already exist."
    inputBinding:
      position: 1
      prefix: --outdir
  - id: run_id
    type:
      - 'null'
      - int
    doc: "Which run from the database (defaults to latest)."
    inputBinding:
      position: 10
      prefix: --run-id
  - id: label
    type:
      - 'null'
      - type: enum
        symbols: [md5, filename, stem]
    doc: "How to label the genomes. (default: stem)"
    inputBinding:
      position: 10
      prefix: --label
  - id: log
    type:
      - 'null'
      - string
    doc: "Where to record log(s). Use '-' for no logging."
    inputBinding:
      position: 10
      prefix: --log
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Show debugging level logging at the terminal (in addition to the log file)."
    inputBinding:
      position: 10
      prefix: --debug
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file (written when log is set)
    outputBinding:
      glob: $(inputs.log)
  - id: stdout_text
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.database)
        writable: true
      - entryname: $(inputs.outdir)
        entry: "$({class: 'Directory', listing: []})"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyani-plus:1.0.0--pyhdfd78af_0
stdout: pyani-plus_plot-run.out
