cwlVersion: v1.2
class: CommandLineTool
baseCommand: xsv_stats
label: xsv_stats
doc: "Computes basic statistics on CSV data.\n\nTool homepage: https://github.com/BurntSushi/xsv"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: Input CSV file
    inputBinding:
      position: 1
  - id: delimiter
    type:
      - 'null'
      - string
    doc: The field delimiter for reading CSV data. Must be a single character.
    inputBinding:
      position: 102
      prefix: --delimiter
  - id: include_nulls
    type:
      - 'null'
      - boolean
    doc: Include NULLs in the population size for computing mean and standard 
      deviation.
    inputBinding:
      position: 102
      prefix: --nulls
  - id: jobs
    type:
      - 'null'
      - int
    doc: The number of jobs to run in parallel. This works better when the given
      CSV data has an index already created. Note that a file handle is opened 
      for each job. When set to '0', the number of jobs is set to the number of 
      CPUs detected.
    inputBinding:
      position: 102
      prefix: --jobs
  - id: no_headers
    type:
      - 'null'
      - boolean
    doc: When set, the first row will NOT be interpreted as column names. i.e., 
      They will be included in statistics.
    inputBinding:
      position: 102
      prefix: --no-headers
  - id: select_columns
    type:
      - 'null'
      - string
    doc: Select a subset of columns to compute stats for. See 'xsv select 
      --help' for the format details. This is provided here because piping 'xsv 
      select' into 'xsv stats' will disable the use of indexing.
    inputBinding:
      position: 102
      prefix: --select
  - id: show_all_statistics
    type:
      - 'null'
      - boolean
    doc: Show all statistics available.
    inputBinding:
      position: 102
      prefix: --everything
  - id: show_cardinality
    type:
      - 'null'
      - boolean
    doc: Show the cardinality. This requires storing all CSV data in memory.
    inputBinding:
      position: 102
      prefix: --cardinality
  - id: show_median
    type:
      - 'null'
      - boolean
    doc: Show the median. This requires storing all CSV data in memory.
    inputBinding:
      position: 102
      prefix: --median
  - id: show_mode
    type:
      - 'null'
      - boolean
    doc: Show the mode. This requires storing all CSV data in memory.
    inputBinding:
      position: 102
      prefix: --mode
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
