cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - make_random_contigs
label: pyfastaq_fastaq_make_random_contigs
doc: "Makes a multi-FASTA file of random sequences, all of the same length. Each base has equal chance of being A,C,G or T\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: first_number
    type:
      - 'null'
      - int
    doc: "If numbering the sequences, the first sequence gets this number [1]"
    inputBinding:
      position: 1
      prefix: --first_number
  - id: name_by_letters
    type:
      - 'null'
      - boolean
    doc: "Name the contigs A,B,C,... will start at A again if you get to Z"
    inputBinding:
      position: 2
      prefix: --name_by_letters
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prefix to add to start of every sequence name"
    inputBinding:
      position: 3
      prefix: --prefix
  - id: seed
    type:
      - 'null'
      - int
    doc: "Seed for random number generator. Default is to use python's default"
    inputBinding:
      position: 4
      prefix: --seed
  - id: contigs
    type: int
    doc: "Number of contigs to make"
    inputBinding:
      position: 20
  - id: length
    type: int
    doc: "Length of each contig"
    inputBinding:
      position: 21
  - id: outfile
    type: string
    doc: "Name of output file"
    inputBinding:
      position: 22
outputs:
  - id: output
    type: File
    doc: "Name of output file"
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
