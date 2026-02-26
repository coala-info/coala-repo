cwlVersion: v1.2
class: CommandLineTool
baseCommand: faSplit
label: ucsc-fasplit
doc: "Split a FASTA file into several smaller files.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: how
    type: string
    doc: "Split method: 'about', 'byname', 'gap', 'base', or 'size'"
    inputBinding:
      position: 1
  - id: input_file
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 2
  - id: count_or_size
    type: int
    doc: Number of files to create or size of each split
    inputBinding:
      position: 3
  - id: extra
    type:
      - 'null'
      - boolean
    doc: Include extra information in output names
    inputBinding:
      position: 104
      prefix: -extra
  - id: one_file
    type:
      - 'null'
      - boolean
    doc: Put all sequences in one file
    inputBinding:
      position: 104
      prefix: -oneFile
  - id: verbose
    type:
      - 'null'
      - int
    doc: Set verbosity level
    default: 1
    inputBinding:
      position: 104
      prefix: -verbose
outputs:
  - id: out_root
    type: File
    doc: Prefix for output file names
    outputBinding:
      glob: '*.out'
  - id: lift
    type:
      - 'null'
      - File
    doc: Create a lift file
    outputBinding:
      glob: $(inputs.lift)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fasplit:482--h0b57e2e_0
