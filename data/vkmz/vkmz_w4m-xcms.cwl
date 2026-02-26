cwlVersion: v1.2
class: CommandLineTool
baseCommand: vkmz w4m-xcms
label: vkmz_w4m-xcms
doc: "Process XCMS data with various metadata and output options.\n\nTool homepage:
  https://github.com/HegemanLab/VKMZ"
inputs:
  - id: alternate
    type:
      - 'null'
      - boolean
    doc: Set flag to keep features with multiple predictions
    inputBinding:
      position: 101
      prefix: --alternate
  - id: data_matrix
    type: File
    doc: Path to XCMS data matrix file
    inputBinding:
      position: 101
      prefix: --data-matrix
  - id: database
    type:
      - 'null'
      - Directory
    doc: Define path to custom database of known formula-mass pairs
    inputBinding:
      position: 101
      prefix: --database
  - id: error
    type: float
    doc: Mass error of MS data in parts-per-million
    inputBinding:
      position: 101
      prefix: --error
  - id: impute_charge
    type:
      - 'null'
      - boolean
    doc: Set flag to impute "1" for missing charge information
    inputBinding:
      position: 101
      prefix: --impute-charge
  - id: json
    type:
      - 'null'
      - boolean
    doc: Set JSON flag to save JSON output
    inputBinding:
      position: 101
      prefix: --json
  - id: metadata
    type:
      - 'null'
      - boolean
    doc: Set metadata flag to save argument metadata
    inputBinding:
      position: 101
      prefix: --metadata
  - id: neutral
    type:
      - 'null'
      - boolean
    doc: Set flag if input data contains neutral feature mass instead of mz
    inputBinding:
      position: 101
      prefix: --neutral
  - id: polarity
    type:
      - 'null'
      - string
    doc: Set flag to force polarity of all features to positive or negative
    inputBinding:
      position: 101
      prefix: --polarity
  - id: prefix
    type:
      - 'null'
      - string
    doc: Define path prefix to support files ("d3.html" and database directory)
    inputBinding:
      position: 101
      prefix: --prefix
  - id: sample_metadata
    type: File
    doc: Path to XCMS sample metadata file
    inputBinding:
      position: 101
      prefix: --sample-metadata
  - id: sql
    type:
      - 'null'
      - boolean
    doc: Set SQL flag to save SQL output
    inputBinding:
      position: 101
      prefix: --sql
  - id: variable_metadata
    type: File
    doc: Path to XCMS variable metadata file
    inputBinding:
      position: 101
      prefix: --variable-metadata
outputs:
  - id: output
    type: File
    doc: Specify output file path
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vkmz:1.4.6--py_0
