cwlVersion: v1.2
class: CommandLineTool
baseCommand: xsv_join
label: xsv_join
doc: "Joins two sets of CSV data on the specified columns.\n\nTool homepage: https://github.com/BurntSushi/xsv"
inputs:
  - id: columns1
    type: string
    doc: Columns to join for the first input. Can be referenced by name or index
      (starting at 1). Multiple columns separated by comma, range with '-'. Must
      specify the same number of columns as columns2.
    inputBinding:
      position: 1
  - id: input1
    type: File
    doc: First input CSV file.
    inputBinding:
      position: 2
  - id: columns2
    type: string
    doc: Columns to join for the second input. Can be referenced by name or 
      index (starting at 1). Multiple columns separated by comma, range with 
      '-'. Must specify the same number of columns as columns1.
    inputBinding:
      position: 3
  - id: input2
    type: File
    doc: Second input CSV file.
    inputBinding:
      position: 4
  - id: cross
    type:
      - 'null'
      - boolean
    doc: USE WITH CAUTION. Returns the cartesian product of the CSV data sets 
      given. The number of rows return is equal to N * M, where N and M 
      correspond to the number of rows in the given data sets, respectively.
    inputBinding:
      position: 105
      prefix: --cross
  - id: delimiter
    type:
      - 'null'
      - string
    doc: The field delimiter for reading CSV data. Must be a single character.
    default: ','
    inputBinding:
      position: 105
      prefix: --delimiter
  - id: full_outer
    type:
      - 'null'
      - boolean
    doc: Do a 'full outer' join. Returns all rows in both data sets with 
      matching records joined. If there is no match, the missing side will be 
      padded out with empty fields. (This is the combination of 'outer left' and
      'outer right'.)
    inputBinding:
      position: 105
      prefix: --full
  - id: left_outer
    type:
      - 'null'
      - boolean
    doc: Do a 'left outer' join. Returns all rows in first CSV data set, 
      including rows with no corresponding row in the second data set. When no 
      corresponding row exists, it is padded out with empty fields.
    inputBinding:
      position: 105
      prefix: --left
  - id: no_case
    type:
      - 'null'
      - boolean
    doc: When set, joins are done case insensitively.
    inputBinding:
      position: 105
      prefix: --no-case
  - id: no_headers
    type:
      - 'null'
      - boolean
    doc: When set, the first row will not be interpreted as headers. (i.e., They
      are not searched, analyzed, sliced, etc.)
    inputBinding:
      position: 105
      prefix: --no-headers
  - id: nulls
    type:
      - 'null'
      - boolean
    doc: When set, joins will work on empty fields. Otherwise, empty fields are 
      completely ignored. (In fact, any row that has an empty field in the key 
      specified is ignored.)
    inputBinding:
      position: 105
      prefix: --nulls
  - id: right_outer
    type:
      - 'null'
      - boolean
    doc: Do a 'right outer' join. Returns all rows in second CSV data set, 
      including rows with no corresponding row in the first data set. When no 
      corresponding row exists, it is padded out with empty fields. (This is the
      reverse of 'outer left'.)
    inputBinding:
      position: 105
      prefix: --right
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write output to <file> instead of stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xsv:0.10.3--0
