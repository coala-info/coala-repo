cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - count-utils
  - cat
label: mgkit_count-utils_cat
doc: "Combine multiple count tables files (Parquet tables with the same index).\n\nTool homepage: https://github.com/frubino/mgkit"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output (debug messages).
    inputBinding:
      position: 101
      prefix: -v
  - id: output
    type: string
    doc: Output file
    inputBinding:
      position: 101
      prefix: -o
  - id: count_files
    type:
      type: array
      items: File
    doc: Count tables (Parquet files) to concatenate.
    inputBinding:
      position: 102
outputs:
  - id: output_table
    type: File
    doc: Combined count table (Parquet).
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
