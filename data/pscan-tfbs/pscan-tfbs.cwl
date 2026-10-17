cwlVersion: v1.2
class: CommandLineTool
baseCommand: pscan-tfbs
label: pscan-tfbs
doc: "Pscan: detection of over-represented transcription factor binding sites in
  promoter sequences, or scanning of sequences with one matrix. Results are written
  next to the input files (<query>.res, <query>.ris, <background>.short_matrix,
  <background>.index).\n\nTool homepage: http://159.149.160.88/pscan/"
inputs:
  - id: query
    type:
      - 'null'
      - File
    doc: Multifasta file with the foreground sequences
    inputBinding:
      position: 1
      prefix: -q
  - id: background
    type:
      - 'null'
      - File
    doc: Multifasta file with the background sequences
    inputBinding:
      position: 2
      prefix: -p
  - id: short_matrix
    type:
      - 'null'
      - File
    doc: Background data already calculated (written by -g or -bi)
    inputBinding:
      position: 3
      prefix: -m
  - id: matrix_file
    type:
      - 'null'
      - File
    doc: Scan the foreground sequences only with the Jaspar/Transfac matrix in this
      file
    inputBinding:
      position: 4
      prefix: -M
  - id: matrix_list
    type:
      - 'null'
      - File
    doc: File with the matrices to use (.wil format)
    inputBinding:
      position: 5
      prefix: -l
  - id: matrix_name
    type:
      - 'null'
      - string
    doc: Use only the matrix with this name (only with matrix_list)
    inputBinding:
      position: 6
      prefix: -N
  - id: single_strand
    type:
      - 'null'
      - boolean
    doc: Perform single strand only analysis
    inputBinding:
      position: 7
      prefix: -ss
  - id: reverse_strand
    type:
      - 'null'
      - boolean
    doc: Perform single strand only analysis on the reverse strand
    inputBinding:
      position: 8
      prefix: -rs
  - id: split
    type:
      - 'null'
      - type: array
        items: int
    doc: Scan sequences only from position num1 and for num2 nucleotides (two
      integers)
    inputBinding:
      position: 9
      prefix: -split
  - id: trash_n
    type:
      - 'null'
      - boolean
    doc: Discard sequences containing N
    inputBinding:
      position: 10
      prefix: -trashn
  - id: keep_n
    type:
      - 'null'
      - boolean
    doc: Oligos containing N are not discarded; N gets an average score
    inputBinding:
      position: 11
      prefix: -n
  - id: write_background
    type:
      - 'null'
      - boolean
    doc: Write a file with the data calculated for the background sequences
    inputBinding:
      position: 12
      prefix: -g
  - id: use_index
    type:
      - 'null'
      - File
    doc: Index of the background file, used to avoid duplicated sequences
    inputBinding:
      position: 13
      prefix: -ui
  - id: build_index
    type:
      - 'null'
      - boolean
    doc: Build an index of the background sequences file
    inputBinding:
      position: 14
      prefix: -bi
outputs:
  - id: results
    type:
      - 'null'
      - type: array
        items: File
    doc: Result tables (.res, .ris), background data (.short_matrix) and index files
    outputBinding:
      glob:
        - '*.res'
        - '*.ris'
        - '*.short_matrix'
        - '*.index'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.query)
        writable: true
      - entry: $(inputs.background)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pscan-tfbs:v1.2.2-3-deb_cv1
