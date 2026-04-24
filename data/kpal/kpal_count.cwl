cwlVersion: v1.2
class: CommandLineTool
baseCommand: kpal_count
label: kpal_count
doc: "Make k-mer profiles from FASTA files.\n\nTool homepage: https://github.com/LUMC/kPAL"
inputs:
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: input file
    inputBinding:
      position: 1
  - id: by_record
    type:
      - 'null'
      - boolean
    doc: make a k-mer profile per FASTA record instead of a k-mer profile per 
      FASTA file
    inputBinding:
      position: 102
      prefix: --by-record
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size
    inputBinding:
      position: 102
      prefix: -k
  - id: profiles
    type:
      - 'null'
      - type: array
        items: string
    doc: names for the created k-mer profiles, one per INPUT
    inputBinding:
      position: 102
      prefix: --profiles
outputs:
  - id: output
    type: File
    doc: output k-mer profile file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kpal:2.1.1--py27_0
