cwlVersion: v1.2
class: CommandLineTool
baseCommand: kitsune dmatrix
label: kitsune_dmatrix
doc: "Create a dmatrix for XGBoost\n\nTool homepage: https://github.com/natapol/kitsune"
inputs:
  - id: train_file
    type: File
    doc: Training data file (CSV, TSV, or Parquet)
    inputBinding:
      position: 1
  - id: categorical_features
    type:
      - 'null'
      - type: array
        items: string
    doc: List of categorical feature column names
    inputBinding:
      position: 102
      prefix: --categorical
  - id: enable_categorical
    type:
      - 'null'
      - boolean
    doc: Enable categorical feature support (requires XGBoost >= 1.6)
    inputBinding:
      position: 102
      prefix: --enable-categorical
  - id: feature_columns
    type:
      - 'null'
      - type: array
        items: string
    doc: 'List of feature column names (default: all columns except label, group,
      and weight)'
    inputBinding:
      position: 102
      prefix: --features
  - id: format
    type:
      - 'null'
      - string
    doc: Output format (binary, libsvm)
    inputBinding:
      position: 102
      prefix: --format
  - id: group_column
    type:
      - 'null'
      - string
    doc: Name of the group column (for group-wise cross-validation)
    inputBinding:
      position: 102
      prefix: --group
  - id: label_column
    type: string
    doc: Name of the label column
    inputBinding:
      position: 102
      prefix: --label
  - id: missing_value
    type:
      - 'null'
      - string
    doc: Value to represent missing data
    inputBinding:
      position: 102
      prefix: --missing
  - id: test_file
    type:
      - 'null'
      - File
    doc: Test data file (CSV, TSV, or Parquet)
    inputBinding:
      position: 102
      prefix: --test
  - id: weight_column
    type:
      - 'null'
      - string
    doc: Name of the weight column
    inputBinding:
      position: 102
      prefix: --weight
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'Output file path for the dmatrix (default: stdout)'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kitsune:1.3.5--pyhdfd78af_0
