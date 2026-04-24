cwlVersion: v1.2
class: CommandLineTool
baseCommand: distle
label: distle
doc: "Calculate pairwise distances between sequences.\n\nTool homepage: https://github.com/KHajji/distle"
inputs:
  - id: input
    type: File
    doc: The input file or '-' for stdin
    inputBinding:
      position: 1
  - id: input_format
    type:
      - 'null'
      - string
    doc: The format of the input file
    inputBinding:
      position: 102
      prefix: --input-format
  - id: input_sep
    type:
      - 'null'
      - string
    doc: The separator character for the input file. Relevant for tabular input 
      files
    inputBinding:
      position: 102
      prefix: --input-sep
  - id: maxdist
    type:
      - 'null'
      - float
    doc: If set, distance calculations will be stopped when this distance is 
      reached. Useful for large datasets
    inputBinding:
      position: 102
      prefix: --maxdist
  - id: output_format
    type:
      - 'null'
      - string
    doc: The format of the output file
    inputBinding:
      position: 102
      prefix: --output-format
  - id: output_mode
    type:
      - 'null'
      - string
    doc: The output mode
    inputBinding:
      position: 102
      prefix: --output-mode
  - id: output_sep
    type:
      - 'null'
      - string
    doc: The separator character for the output file
    inputBinding:
      position: 102
      prefix: --output-sep
  - id: precomputed_distances
    type:
      - 'null'
      - File
    doc: A file with precomputed distances that don't have to be calculated 
      again. The file should be in tabular long format and have the separator as
      specified by the output-sep flag
    inputBinding:
      position: 102
      prefix: --precomputed-distances
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet mode. Suppresses all output except for errors
    inputBinding:
      position: 102
      prefix: --quiet
  - id: skip_header
    type:
      - 'null'
      - boolean
    doc: Skip the header line of the input file. Relevant for tabular input 
      files
    inputBinding:
      position: 102
      prefix: --skip-header
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use. If not set, all available threads will be 
      used
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose mode. Outputs debug messages and calculation times
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output
    type: File
    doc: The output file or '-' for stdout
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/distle:0.3.0--h54198d6_1
