cwlVersion: v1.2
class: CommandLineTool
baseCommand: faFilter
label: ucsc-fafiltern
doc: "Filter a fasta file based on various criteria such as name, size, or N content.\n\
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_fa
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: max_n
    type:
      - 'null'
      - int
    doc: Keep sequences with at most this many N's
    inputBinding:
      position: 102
      prefix: -maxN
  - id: max_size
    type:
      - 'null'
      - int
    doc: Keep sequences at most this big
    inputBinding:
      position: 102
      prefix: -maxSize
  - id: min_size
    type:
      - 'null'
      - int
    doc: Keep sequences at least this big
    inputBinding:
      position: 102
      prefix: -minSize
  - id: name
    type:
      - 'null'
      - string
    doc: Keep sequences with this name
    inputBinding:
      position: 102
      prefix: -name
  - id: not_name
    type:
      - 'null'
      - string
    doc: Keep sequences not with this name
    inputBinding:
      position: 102
      prefix: -notName
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: output_fa
    type: File
    doc: Output filtered FASTA file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fafiltern:482--h0b57e2e_0
