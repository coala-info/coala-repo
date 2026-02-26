cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - tbl-sum
label: fuc_tbl-sum
doc: "Summarize a table file.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: table_file
    type: File
    doc: Table file.
    inputBinding:
      position: 1
  - id: columns
    type:
      - 'null'
      - type: array
        items: string
    doc: Columns to be summarized
    inputBinding:
      position: 102
      prefix: --columns
  - id: dtypes
    type:
      - 'null'
      - File
    doc: File of column names and their data types (either 'categorical' or 
      'numeric'); one tab-delimited pair of column name and data type per line.
    inputBinding:
      position: 102
      prefix: --dtypes
  - id: expr
    type:
      - 'null'
      - string
    doc: Query the columns of a pandas.DataFrame with a boolean expression
    inputBinding:
      position: 102
      prefix: --expr
  - id: keep_default_na
    type:
      - 'null'
      - boolean
    doc: Whether or not to include the default NaN values when parsing the data
    inputBinding:
      position: 102
      prefix: --keep_default_na
  - id: na_values
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional strings to recognize as NA/NaN
    inputBinding:
      position: 102
      prefix: --na_values
  - id: separator
    type:
      - 'null'
      - string
    doc: Delimiter to use
    default: "'\\t'"
    inputBinding:
      position: 102
      prefix: --sep
  - id: skiprows
    type:
      - 'null'
      - string
    doc: Comma-separated line numbers to skip (0-indexed) or number of lines to 
      skip at the start of the file
    inputBinding:
      position: 102
      prefix: --skiprows
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_tbl-sum.out
