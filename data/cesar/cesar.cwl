cwlVersion: v1.2
class: CommandLineTool
baseCommand: cesar
label: cesar
doc: "Align a pair of sequences using HMM.\n\nTool homepage: https://github.com/hillerlab/CESAR2.0"
inputs:
  - id: fasta_file
    type: File
    doc: FASTA file containing sequences to align
    inputBinding:
      position: 1
  - id: clade
    type:
      - 'null'
      - string
    doc: Clade to use (human or mouse)
    inputBinding:
      position: 102
      prefix: --clade
  - id: first_exon
    type:
      - 'null'
      - boolean
    doc: Consider the first exon
    inputBinding:
      position: 102
      prefix: --firstexon
  - id: last_exon
    type:
      - 'null'
      - boolean
    doc: Consider the last exon
    inputBinding:
      position: 102
      prefix: --lastexon
  - id: matrix_file
    type: File
    doc: Codon substitution matrix file (e.g. eth_codon_sub.txt); the image 
      does not ship the default tables
    inputBinding:
      position: 102
      prefix: --matrix
  - id: max_memory
    type:
      - 'null'
      - int
    doc: Maximum memory to use (GB)
    inputBinding:
      position: 102
      prefix: --max-memory
  - id: profiles
    type:
      type: array
      items: File
    doc: Acceptor profile and donor profile (two files, e.g. acc_profile.txt 
      do_profile.txt); the image does not ship the default tables
    inputBinding:
      position: 102
      prefix: --profiles
  - id: sanity_checks
    type:
      - 'null'
      - boolean
    doc: Enable sanity checks and exit on failure
    inputBinding:
      position: 102
      prefix: --sanityChecks
  - id: set_options
    type:
      - 'null'
      - type: array
        items: string
    doc: Set custom options (name=value pairs)
    inputBinding:
      position: 200
      prefix: --set
  - id: split_codon_emissions
    type:
      - 'null'
      - type: array
        items: File
    doc: Accumulation split codon emissions and deletion-only split codon 
      emissions
    inputBinding:
      position: 102
      prefix: --split_codon_emissions
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Verbosity level (0 to 2)
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cesar:1.01--h503566f_3
stdout: cesar.out
