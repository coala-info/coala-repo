cwlVersion: v1.2
class: CommandLineTool
baseCommand: crux extract-columns
label: crux_extract-columns
doc: "Extracts specified columns from a tab-delimited file.\n\nTool homepage: https://github.com/redbadger/crux"
inputs:
  - id: tsv_file
    type: File
    doc: A tab-delimited file, with column headers in the first row. Use "-" to 
      read from standard input.
    inputBinding:
      position: 1
  - id: column_names
    type: string
    doc: A comma-delimited list of column names.
    inputBinding:
      position: 2
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Specify the input and output delimiter to use when processing the 
      delimited file. The argument can be either a single character or the 
      keyword 'tab.'
    default: tab
    inputBinding:
      position: 103
      prefix: --delimiter
  - id: header
    type:
      - 'null'
      - boolean
    doc: Print the header line of the file, in addition to the columns that 
      match.
    default: true
    inputBinding:
      position: 103
      prefix: --header
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Specify the verbosity of the current processes. Each level prints the following
      messages, including all those at lower verbosity levels: 0-fatal errors, 10-non-fatal
      errors, 20-warnings, 30-information on the progress of execution, 40-more progress
      information, 50-debug info, 60-detailed debug info.'
    default: 30
    inputBinding:
      position: 103
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crux:v3.2_cv3
stdout: crux_extract-columns.out
