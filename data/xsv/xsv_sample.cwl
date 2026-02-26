cwlVersion: v1.2
class: CommandLineTool
baseCommand: xsv_sample
label: xsv_sample
doc: "Randomly samples CSV data uniformly using memory proportional to the size of
  the sample.\n\nTool homepage: https://github.com/BurntSushi/xsv"
inputs:
  - id: sample_size
    type: int
    doc: The number of records to sample
    inputBinding:
      position: 1
  - id: input
    type:
      - 'null'
      - File
    doc: Input CSV file (reads from stdin if not specified)
    inputBinding:
      position: 2
  - id: delimiter
    type:
      - 'null'
      - string
    doc: The field delimiter for reading CSV data. Must be a single character.
    default: ','
    inputBinding:
      position: 103
      prefix: --delimiter
  - id: no_headers
    type:
      - 'null'
      - boolean
    doc: When set, the first row will be consider as part of the population to 
      sample from. (When not set, the first row is the header row and will 
      always appear in the output.)
    inputBinding:
      position: 103
      prefix: --no-headers
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
