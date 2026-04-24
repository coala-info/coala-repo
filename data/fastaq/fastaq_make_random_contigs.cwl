cwlVersion: v1.2
class: CommandLineTool
baseCommand: freq make_random_contigs
label: fastaq_make_random_contigs
doc: "Makes a multi-FASTA file of random sequences, all of the same length. Each base
  has equal chance of being A,C,G or T\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: contigs
    type: int
    doc: Number of contigs to make
    inputBinding:
      position: 1
  - id: length
    type: int
    doc: Length of each contig
    inputBinding:
      position: 2
  - id: first_number
    type:
      - 'null'
      - int
    doc: If numbering the sequences, the first sequence gets this number
    inputBinding:
      position: 103
      prefix: --first_number
  - id: name_by_letters
    type:
      - 'null'
      - boolean
    doc: Name the contigs A,B,C,... will start at A again if you get to Z
    inputBinding:
      position: 103
      prefix: --name_by_letters
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix to add to start of every sequence name
    inputBinding:
      position: 103
      prefix: --prefix
  - id: seed
    type:
      - 'null'
      - string
    doc: Seed for random number generator. Default is to use python's default
    inputBinding:
      position: 103
      prefix: --seed
outputs:
  - id: outfile
    type: File
    doc: Name of output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
