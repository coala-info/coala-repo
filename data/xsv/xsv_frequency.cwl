cwlVersion: v1.2
class: CommandLineTool
baseCommand: xsv frequency
label: xsv_frequency
doc: "Compute a frequency table on CSV data.\n\nTool homepage: https://github.com/BurntSushi/xsv"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: Input CSV file
    inputBinding:
      position: 1
  - id: asc
    type:
      - 'null'
      - boolean
    doc: Sort the frequency tables in ascending order by count. The default is 
      descending order.
    inputBinding:
      position: 102
      prefix: --asc
  - id: delimiter
    type:
      - 'null'
      - string
    doc: The field delimiter for reading CSV data. Must be a single character.
    default: ','
    inputBinding:
      position: 102
      prefix: --delimiter
  - id: jobs
    type:
      - 'null'
      - int
    doc: The number of jobs to run in parallel. This works better when the given
      CSV data has an index already created. Note that a file handle is opened 
      for each job. When set to '0', the number of jobs is set to the number of 
      CPUs detected.
    default: 0
    inputBinding:
      position: 102
      prefix: --jobs
  - id: limit
    type:
      - 'null'
      - int
    doc: Limit the frequency table to the N most common items. Set to '0' to 
      disable a limit.
    default: 10
    inputBinding:
      position: 102
      prefix: --limit
  - id: no_headers
    type:
      - 'null'
      - boolean
    doc: When set, the first row will NOT be included in the frequency table. 
      Additionally, the 'field' column will be 1-based indices instead of header
      names.
    inputBinding:
      position: 102
      prefix: --no-headers
  - id: no_nulls
    type:
      - 'null'
      - boolean
    doc: Don't include NULLs in the frequency table.
    inputBinding:
      position: 102
      prefix: --no-nulls
  - id: select_columns
    type:
      - 'null'
      - string
    doc: Select a subset of columns to compute frequencies for. See 'xsv select 
      --help' for the format details. This is provided here because piping 'xsv 
      select' into 'xsv frequency' will disable the use of indexing.
    inputBinding:
      position: 102
      prefix: --select
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
