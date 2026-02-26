cwlVersion: v1.2
class: CommandLineTool
baseCommand: beamspy annotate-peak-patterns
label: beamspy_annotate-peak-patterns
doc: "Annotate peaks with adducts, isotopes, oligomers, and neutral losses.\n\nTool
  homepage: https://github.com/computational-metabolomics/beamspy"
inputs:
  - id: adducts
    type:
      - 'null'
      - boolean
    doc: Annotate adducts.
    inputBinding:
      position: 101
      prefix: --adducts
  - id: adducts_library
    type:
      - 'null'
      - File
    doc: List of adducts.
    inputBinding:
      position: 101
      prefix: --adducts-library
  - id: gml_file
    type:
      - 'null'
      - File
    doc: Correlation graph in GraphML format.
    inputBinding:
      position: 101
      prefix: --gml-file
  - id: intensity_matrix
    type:
      - 'null'
      - File
    doc: Tab-delimited intensity matrix.
    inputBinding:
      position: 101
      prefix: --intensity-matrix
  - id: ion_mode
    type:
      - 'null'
      - string
    doc: Ion mode of the libraries.
    inputBinding:
      position: 101
      prefix: --ion-mode
  - id: isotopes
    type:
      - 'null'
      - boolean
    doc: Annotate isotopes.
    inputBinding:
      position: 101
      prefix: --isotopes
  - id: isotopes_library
    type:
      - 'null'
      - File
    doc: List of isotopes.
    inputBinding:
      position: 101
      prefix: --isotopes-library
  - id: max_monomer_units
    type:
      - 'null'
      - int
    doc: Maximum number of monomer units.
    inputBinding:
      position: 101
      prefix: --max-monomer-units
  - id: neutral_losses
    type:
      - 'null'
      - boolean
    doc: Annotate neutral losses.
    inputBinding:
      position: 101
      prefix: --neutral-losses
  - id: neutral_losses_library
    type:
      - 'null'
      - File
    doc: List of neutral losses.
    inputBinding:
      position: 101
      prefix: --neutral-losses-library
  - id: oligomers
    type:
      - 'null'
      - boolean
    doc: Annotate oligomers.
    inputBinding:
      position: 101
      prefix: --oligomers
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
outputs:
  - id: db
    type:
      - 'null'
      - File
    doc: Sqlite database to write results.
    outputBinding:
      glob: $(inputs.db)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/beamspy:1.2.0--pyhdfd78af_0
