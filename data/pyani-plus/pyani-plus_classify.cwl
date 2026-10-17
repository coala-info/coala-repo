cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyani-plus
  - classify
label: pyani-plus_classify
doc: "Classify genomes into clusters based on ANI results.\n\nTool homepage: https://github.com/pyani-plus/pyani-plus"
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
  - id: coverage_edges
    type:
      - 'null'
      - string
    doc: "How to resolve asymmetrical ANI coverage results for edges in the graph (min, max or mean). (default: min)"
    inputBinding:
      position: 10
      prefix: --coverage-edges
  - id: score_edges
    type:
      - 'null'
      - string
    doc: "How to resolve asymmetrical ANI identity/tANI results for edges in the graph (min, max or mean). (default: mean)"
    inputBinding:
      position: 10
      prefix: --score-edges
  - id: vertical_line
    type:
      - 'null'
      - double
    doc: "Threshold for red vertical line at identity/tANI. (default: 0.95)"
    inputBinding:
      position: 10
      prefix: --vertical-line
  - id: cov_min
    type:
      - 'null'
      - double
    doc: "minimum %coverage for an edge (default: 0.5)"
    inputBinding:
      position: 10
      prefix: --cov-min
  - id: mode
    type:
      - 'null'
      - type: enum
        symbols: [identity, tANI]
    doc: "Classify mode intended to identify cliques within a set of genomes. (default: identity)"
    inputBinding:
      position: 10
      prefix: --mode
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
stdout: pyani-plus_classify.out
