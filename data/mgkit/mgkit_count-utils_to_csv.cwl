cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - count-utils
  - to_csv
label: mgkit_count-utils_to_csv
doc: "Convert Parquet tables into CSV\n\nTool homepage: https://github.com/frubino/mgkit"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output (debug messages).
    inputBinding:
      position: 101
      prefix: -v
  - id: parquet_file
    type: File
    doc: Parquet table to convert.
    inputBinding:
      position: 102
  - id: csv_file
    type: string
    doc: Output CSV file name.
    inputBinding:
      position: 103
outputs:
  - id: output_csv
    type: File
    doc: CSV table.
    outputBinding:
      glob: $(inputs.csv_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
