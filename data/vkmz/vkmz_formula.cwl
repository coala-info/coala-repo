cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vkmz
  - formula
label: vkmz_formula
doc: "Parses a tabular formula file and outputs results in various formats.\n\nTool
  homepage: https://github.com/HegemanLab/VKMZ"
inputs:
  - id: alternate
    type:
      - 'null'
      - boolean
    doc: Set flag to keep features with multiple predictions
    inputBinding:
      position: 101
      prefix: --alternate
  - id: database
    type:
      - 'null'
      - File
    doc: Define path to custom database of known formula-mass pairs
    inputBinding:
      position: 101
      prefix: --database
  - id: impute_charge
    type:
      - 'null'
      - boolean
    doc: Set flag to impute "1" for missing charge information
    inputBinding:
      position: 101
      prefix: --impute-charge
  - id: input
    type: File
    doc: Path to tabular formula file.
    inputBinding:
      position: 101
      prefix: --input
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
      - Directory
    doc: Define path prefix to support files ("d3.html" and database directory)
    inputBinding:
      position: 101
      prefix: --prefix
  - id: sql
    type:
      - 'null'
      - boolean
    doc: Set SQL flag to save SQL output
    inputBinding:
      position: 101
      prefix: --sql
  - id: output_path
    type: string
    doc: Specify output file path (the tool adds the extensions)
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output_tabular
    type: File
    doc: Tabular output (output path plus .tabular)
    outputBinding:
      glob: $(inputs.output_path).tabular
  - id: output_html
    type: File
    doc: Interactive van Krevelen diagram (output path plus .html)
    outputBinding:
      glob: $(inputs.output_path).html
  - id: output_json
    type:
      - 'null'
      - File
    doc: JSON output (output path plus .json), written with --json
    outputBinding:
      glob: $(inputs.output_path).json
  - id: output_sql
    type:
      - 'null'
      - File
    doc: SQLite database (output path plus .db), written with --sql
    outputBinding:
      glob: $(inputs.output_path).db
  - id: output_metadata
    type:
      - 'null'
      - File
    doc: Argument metadata (output path plus _metadata.tabular), written with
      --metadata
    outputBinding:
      glob: $(inputs.output_path)_metadata.tabular
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vkmz:1.4.6--py_0
