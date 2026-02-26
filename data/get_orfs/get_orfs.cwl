cwlVersion: v1.2
class: CommandLineTool
baseCommand: get_orfs
label: get_orfs
doc: "Finds Open Reading Frames (ORFs) in a given FASTA file.\n\nTool homepage: https://github.com/linsalrob/get_orfs"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: print debugging help
    inputBinding:
      position: 101
      prefix: --debug
  - id: fasta_file
    type: File
    doc: fasta file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: jobs
    type:
      - 'null'
      - int
    doc: number of parallel threads to use. We use 6 for the translation 
      regardless of -j
    default: 8
    inputBinding:
      position: 101
      prefix: --jobs
  - id: min_length
    type:
      - 'null'
      - int
    doc: minimum length
    default: 1
    inputBinding:
      position: 101
      prefix: --length
  - id: translation_table
    type:
      - 'null'
      - int
    doc: translation table
    default: 11
    inputBinding:
      position: 101
      prefix: --translation_table
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/get_orfs:1.1.0--hdcf5f25_0
stdout: get_orfs.out
