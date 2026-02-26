cwlVersion: v1.2
class: CommandLineTool
baseCommand: beamspy annotate-mf
label: beamspy_annotate-mf
doc: "Annotate molecular formulas for peaks.\n\nTool homepage: https://github.com/computational-metabolomics/beamspy"
inputs:
  - id: adducts_library
    type:
      - 'null'
      - File
    doc: List of adducts to search for.
    inputBinding:
      position: 101
      prefix: --adducts-library
  - id: db
    type: File
    doc: Sqlite database to write results.
    inputBinding:
      position: 101
      prefix: --db
  - id: db_mf
    type:
      - 'null'
      - File
    doc: Molecular formulae database (reference).
    inputBinding:
      position: 101
      prefix: --db-mf
  - id: intensity_matrix
    type:
      - 'null'
      - File
    doc: Tab-delimited intensity matrix.
    inputBinding:
      position: 101
      prefix: --intensity-matrix
  - id: ion_mode
    type: string
    doc: Ion mode of the libraries.
    inputBinding:
      position: 101
      prefix: --ion-mode
  - id: max_mz
    type:
      - 'null'
      - float
    doc: Maximum m/z value to assign molecular formula(e).
    inputBinding:
      position: 101
      prefix: --max-mz
  - id: peaklist
    type: File
    doc: Tab-delimited peaklist.
    inputBinding:
      position: 101
      prefix: --peaklist
  - id: ppm
    type: float
    doc: Mass tolerance in parts per million.
    inputBinding:
      position: 101
      prefix: --ppm
  - id: skip_patterns
    type:
      - 'null'
      - boolean
    doc: Skip applying/using peak patterns (e.g. adduct and isotope patterns) to
      filter annotations.
    inputBinding:
      position: 101
      prefix: --skip-patterns
  - id: skip_rules
    type:
      - 'null'
      - boolean
    doc: Skip heuritic rules to filter annotations.
    inputBinding:
      position: 101
      prefix: --skip-rules
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/beamspy:1.2.0--pyhdfd78af_0
stdout: beamspy_annotate-mf.out
