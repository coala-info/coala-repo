cwlVersion: v1.2
class: CommandLineTool
baseCommand: crux extract-rows
label: crux_extract-rows
doc: "Extract rows from a TSV file based on a column value.\n\nTool homepage: https://github.com/redbadger/crux"
inputs:
  - id: tsv_file
    type: File
    doc: A tab-delimited file, with column headers in the first row. Use "-" to 
      read from standard input.
    inputBinding:
      position: 1
  - id: column_name
    type: string
    doc: A column name.
    inputBinding:
      position: 2
  - id: column_value
    type: string
    doc: A cell value for a column.
    inputBinding:
      position: 3
  - id: column_type
    type:
      - 'null'
      - string
    doc: Specifies the data type of the column, either an integer (int), a 
      floating point number (real), or a string.
    inputBinding:
      position: 104
      prefix: --column-type
  - id: comparison
    type:
      - 'null'
      - string
    doc: Specify the operator that is used to compare an entry in the specified 
      column to the value given on the command line.
    inputBinding:
      position: 104
      prefix: --comparison
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Specify the input and output delimiter to use when processing the 
      delimited file. The argument can be either a single character or the 
      keyword 'tab.'
    inputBinding:
      position: 104
      prefix: --delimiter
  - id: header
    type:
      - 'null'
      - boolean
    doc: Print the header line of the file, in addition to the columns that 
      match.
    inputBinding:
      position: 104
      prefix: --header
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Specify the verbosity of the current processes. Each level prints the following
      messages, including all those at lower verbosity levels: 0-fatal errors, 10-non-fatal
      errors, 20-warnings, 30-information on the progress of execution, 40-more progress
      information, 50-debug info, 60-detailed debug info.'
    inputBinding:
      position: 104
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crux:v3.2_cv3
stdout: crux_extract-rows.out
