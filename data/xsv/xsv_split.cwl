cwlVersion: v1.2
class: CommandLineTool
baseCommand: xsv_split
label: xsv_split
doc: "Splits the given CSV data into chunks.\n\nTool homepage: https://github.com/BurntSushi/xsv"
inputs:
  - id: outdir
    type: Directory
    doc: The directory where the files are written
    inputBinding:
      position: 1
  - id: input
    type:
      - 'null'
      - File
    doc: Input CSV data
    inputBinding:
      position: 2
  - id: delimiter
    type:
      - 'null'
      - string
    doc: The field delimiter for reading CSV data. Must be a single character.
    inputBinding:
      position: 103
      prefix: --delimiter
  - id: jobs
    type:
      - 'null'
      - int
    doc: The number of spliting jobs to run in parallel. This only works when 
      the given CSV data has an index already created. Note that a file handle 
      is opened for each job. When set to '0', the number of jobs is set to the 
      number of CPUs detected.
    inputBinding:
      position: 103
      prefix: --jobs
  - id: no_headers
    type:
      - 'null'
      - boolean
    doc: When set, the first row will NOT be interpreted as column names. 
      Otherwise, the first row will appear in all chunks as the header row.
    inputBinding:
      position: 103
      prefix: --no-headers
  - id: size
    type:
      - 'null'
      - int
    doc: The number of records to write into each chunk.
    inputBinding:
      position: 103
      prefix: --size
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
