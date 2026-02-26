cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyani-plus classify
label: pyani-plus_classify
doc: "Classify genomes into clusters based on ANI results.\n\nTool homepage: https://github.com/pyani-plus/pyani-plus"
inputs:
  - id: cov_min
    type:
      - 'null'
      - float
    doc: minimum %coverage for an edge
    default: 0.5
    inputBinding:
      position: 101
      prefix: --cov-min
  - id: coverage_edges
    type:
      - 'null'
      - string
    doc: How to resolve asymmetrical ANI coverage results for edges in the graph
      (min, max or mean).
    default: min
    inputBinding:
      position: 101
      prefix: --coverage-edges
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
    default: stem
    inputBinding:
      position: 101
      prefix: --label
  - id: log
    type:
      - 'null'
      - File
    doc: Where to record log(s). Use '-' for no logging.
    default: '-'
    inputBinding:
      position: 101
      prefix: --log
  - id: mode
    type:
      - 'null'
      - string
    doc: Classify mode intended to identify cliques within a set of genomes.
    default: identity
    inputBinding:
      position: 101
      prefix: --mode
  - id: run_id
    type:
      - 'null'
      - int
    doc: Which run from the database (defaults to latest).
    default: latest
    inputBinding:
      position: 101
      prefix: --run-id
  - id: score_edges
    type:
      - 'null'
      - string
    doc: How to resolve asymmetrical ANI identity/tANI results for edges in the 
      graph (min, max or mean).
    default: mean
    inputBinding:
      position: 101
      prefix: --score-edges
  - id: vertical_line
    type:
      - 'null'
      - float
    doc: Threshold for red vertical line at identity/tANI.
    default: 0.95
    inputBinding:
      position: 101
      prefix: --vertical-line
outputs:
  - id: outdir
    type: Directory
    doc: Output directory. Created if does not already exist.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyani-plus:1.0.0--pyhdfd78af_0
