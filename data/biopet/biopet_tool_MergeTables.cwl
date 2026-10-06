cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - MergeTables
label: biopet_tool_MergeTables
doc: "Merge tab-delimited files on feature ID equality into one table.\n\nTool homepage: https://github.com/biopet/biopet"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_tables
    type:
      type: array
      items: File
    doc: Input tables to merge
    inputBinding:
      position: 102
  - id: id_column_index
    type: string
    doc: Index of feature ID column from each input file (1-based), comma separated
    inputBinding:
      position: 101
      prefix: --id_column_index
  - id: value_column_index
    type: int
    doc: Index of column from each input file containing the value to merge (1-based)
    inputBinding:
      position: 101
      prefix: --value_column_index
  - id: output
    type:
      - 'null'
      - string
    doc: 'Path to output file (default: ''-'' <stdout>)'
    inputBinding:
      position: 101
      prefix: --output
  - id: id_column_name
    type:
      - 'null'
      - string
    doc: 'Name of feature ID column in the output merged file (default: feature)'
    inputBinding:
      position: 101
      prefix: --id_column_name
  - id: column_names
    type:
      - 'null'
      - string
    doc: 'Name of feature ID column in the output merged file (default: feature)'
    inputBinding:
      position: 101
      prefix: --column_names
  - id: strip_extension
    type:
      - 'null'
      - string
    doc: 'Common extension of all input tables to strip (default: empty string)'
    inputBinding:
      position: 101
      prefix: --strip_extension
  - id: num_header_lines
    type:
      - 'null'
      - int
    doc: 'The number of header lines present in all input files (default: 0; no header)'
    inputBinding:
      position: 101
      prefix: --num_header_lines
  - id: fallback
    type:
      - 'null'
      - string
    doc: 'The string to use when a value for a feature is missing in one or more sample(s)
      (default: ''-'')'
    inputBinding:
      position: 101
      prefix: --fallback
  - id: delimiter
    type:
      - 'null'
      - string
    doc: 'The character used for separating columns in the input files (default: tab)'
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Level of log information printed. Possible levels: ''debug'', ''info'', ''warn'',
      ''error'''
    inputBinding:
      position: 101
      prefix: --log_level
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type:
      - 'null'
      - File
    doc: Merged table
    outputBinding:
      glob: '$(inputs.output ? inputs.output : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
stdout: biopet_tool_MergeTables.out
