cwlVersion: v1.2
class: CommandLineTool
baseCommand: randomLines
label: ucsc-randomlines
doc: "Get a random set of lines from a file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_file
    type: File
    doc: The input file to sample lines from
    inputBinding:
      position: 1
  - id: line_count
    type: int
    doc: The number of random lines to extract
    inputBinding:
      position: 2
  - id: seed
    type:
      - 'null'
      - int
    doc: Use a specific seed for the random number generator
    inputBinding:
      position: 103
      prefix: -seed
outputs:
  - id: output_file
    type: File
    doc: The output file where random lines will be written
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-randomlines:482--h0b57e2e_0
