cwlVersion: v1.2
class: CommandLineTool
baseCommand: abawaca
label: abawaca
doc: "A tool for processing .names, .lrn, and fasta files into an output directory.\n
  \nTool homepage: https://github.com/CK7/abawaca"
inputs:
  - id: names_file
    type: File
    doc: The .names file
    inputBinding:
      position: 1
  - id: lrn_file
    type: File
    doc: The .lrn file
    inputBinding:
      position: 2
  - id: fasta_file
    type: File
    doc: The FASTA file
    inputBinding:
      position: 3
outputs:
  - id: output_directory
    type: Directory
    doc: The output directory
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abawaca:1.00--h7d875b9_3
