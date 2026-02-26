cwlVersion: v1.2
class: CommandLineTool
baseCommand: beamspy annotate-compounds
label: beamspy_annotate-compounds
doc: "Annotate compounds using a peaklist and a database.\n\nTool homepage: https://github.com/computational-metabolomics/beamspy"
inputs:
  - id: adducts_library
    type: File
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
  - id: db_compounds
    type: File
    doc: Metabolite database (reference).
    inputBinding:
      position: 101
      prefix: --db-compounds
  - id: db_name
    type: string
    doc: Name compound / metabolite database (within --db-compounds).
    inputBinding:
      position: 101
      prefix: --db-name
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
  - id: rt
    type:
      - 'null'
      - float
    doc: Retention time tolerance in seconds.
    inputBinding:
      position: 101
      prefix: --rt
  - id: skip_patterns
    type:
      - 'null'
      - boolean
    doc: Skip applying/using peak patterns (e.g. adduct and isotope patterns) to
      filter annotations.
    inputBinding:
      position: 101
      prefix: --skip-patterns
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/beamspy:1.2.0--pyhdfd78af_0
stdout: beamspy_annotate-compounds.out
