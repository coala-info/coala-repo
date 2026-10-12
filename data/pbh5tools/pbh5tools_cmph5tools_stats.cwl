cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cmph5tools.py
  - stats
label: pbh5tools_cmph5tools_stats
doc: "Emit statistics from a cmp.h5 file.\n\nTool homepage: https://github.com/PacificBiosciences/pbh5tools"
inputs:
  - id: input_cmp_h5
    type: File
    doc: input filename
    inputBinding:
      position: 1
  - id: out_file
    type:
      - 'null'
      - string
    doc: output csv filename
    inputBinding:
      position: 100
      prefix: --outFile
  - id: what
    type:
      - 'null'
      - string
    doc: what expression, e.g., Reference,ReadLength
    inputBinding:
      position: 101
      prefix: --what
  - id: where
    type:
      - 'null'
      - string
    doc: where expression
    inputBinding:
      position: 102
      prefix: --where
  - id: group_by
    type:
      - 'null'
      - string
    doc: groupBy expression
    inputBinding:
      position: 103
      prefix: --groupBy
  - id: sort_by
    type:
      - 'null'
      - string
    doc: sortBy expression
    inputBinding:
      position: 104
      prefix: --sortBy
  - id: limit
    type:
      - 'null'
      - int
    doc: maximum number of records
    inputBinding:
      position: 105
      prefix: --limit
outputs:
  - id: stats_csv
    type:
      - 'null'
      - File
    doc: Statistics in csv format (when --outFile is used)
    outputBinding:
      glob: $(inputs.out_file)
  - id: stdout
    type: stdout
    doc: Standard output
stdout: pbh5tools_cmph5tools_stats_stdout.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbh5tools:0.8.0--py27h470a237_1
