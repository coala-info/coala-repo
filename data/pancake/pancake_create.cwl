cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pancake
  - create
label: pancake_create
doc: "Create a PanCake Object from sequences and alignments\n\nTool homepage: https://github.com/pancakeswap/pancake-frontend"
inputs:
  - id: ali
    type:
      - 'null'
      - type: array
        items: File
    doc: pairwise alignments (BLAST or nucmer output) to include in PanCake Object
    inputBinding:
      position: 101
      prefix: --ali
  - id: email
    type:
      - 'null'
      - string
    doc: if downloading your sequences via gi ids, please specify your email address;
      in case of excessive usage, NCBI will attempt to contact a user at the e-mail
      address provided prior to blocking access to the E-utilities
    inputBinding:
      position: 101
      prefix: --email
  - id: ids
    type:
      - 'null'
      - type: array
        items: string
    doc: gi ids of sequences to download from NCBI
    inputBinding:
      position: 101
      prefix: --ids
  - id: min_len
    type:
      - 'null'
      - int
    doc: minimum length of pairwise alignments to include
    default: 25
    inputBinding:
      position: 101
      prefix: --min_len
  - id: no_self_alignments
    type:
      - 'null'
      - boolean
    doc: if set, skip pairwise alignments between regions on identical chromosomes
      as input
    default: false
    inputBinding:
      position: 101
      prefix: --no_self_alignments
  - id: sequences
    type:
      - 'null'
      - type: array
        items: File
    doc: fasta or multiple fasta file providing input chromosome sequences
    inputBinding:
      position: 101
      prefix: --sequences
outputs:
  - id: pan_file
    type:
      - 'null'
      - File
    doc: File name of new PanCake Object
    outputBinding:
      glob: $(inputs.pan_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pancake:1.1.2--py35_0
