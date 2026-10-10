cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - count-utils
  - map
label: mgkit_count-utils_map
doc: "Map counts with information from a dictionary file (featureCounts table to Parquet).\n\nTool homepage:\
  \ https://github.com/frubino/mgkit"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output (debug messages).
    inputBinding:
      position: 101
      prefix: -v
  - id: map_file
    type: File
    doc: Map file to use
    inputBinding:
      position: 101
      prefix: -m
  - id: taxa_map
    type:
      - 'null'
      - File
    doc: Taxa map file
    inputBinding:
      position: 101
      prefix: -t
  - id: separator
    type:
      - 'null'
      - string
    doc: 'Field separator for map file Key/Value (default: tab)'
    inputBinding:
      position: 101
      prefix: -s
  - id: split_value
    type:
      - 'null'
      - boolean
    doc: Values are string to be split
    inputBinding:
      position: 101
      prefix: -sv
  - id: count_file
    type: File
    doc: featureCounts table.
    inputBinding:
      position: 102
  - id: output_file
    type: string
    doc: Output Parquet file name.
    inputBinding:
      position: 103
outputs:
  - id: output_table
    type: File
    doc: Mapped count table (Parquet).
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
