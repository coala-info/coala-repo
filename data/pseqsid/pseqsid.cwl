cwlVersion: v1.2
class: CommandLineTool
baseCommand: pseqsid
label: pseqsid
doc: "Calculates pairwise sequence identity, similarity and normalized similarity
  score of proteins in a multiple sequence alignment.\n\nTool homepage: https://github.com/amaurypm/pseqsid"
inputs:
  - id: msa
    type: File
    doc: Multiple Sequence Alignment file
    inputBinding:
      position: 1
  - id: grouping
    type:
      - 'null'
      - File
    doc: Similarity amino acid grouping definition file. A default one is 
      created if required and not provided
    inputBinding:
      position: 102
      prefix: --grouping
  - id: identity
    type:
      - 'null'
      - boolean
    doc: Calculate pairwise sequence identity
    inputBinding:
      position: 102
      prefix: --identity
  - id: length
    type:
      - 'null'
      - string
    doc: 'Sequence length to be use for identity and similarity calculations [possible
      values: smallest, mean, largest, alignment]'
    default: smallest
    inputBinding:
      position: 102
      prefix: --length
  - id: matrix
    type:
      - 'null'
      - string
    doc: 'Type of matrix to be used for Normalized Similarity Score [possible values:
      blosum62, pam250, gonnet]'
    default: blosum62
    inputBinding:
      position: 102
      prefix: --matrix
  - id: nss
    type:
      - 'null'
      - boolean
    doc: Calculate pairwise sequence Normalized Similarity Score
    inputBinding:
      position: 102
      prefix: --nss
  - id: pe
    type:
      - 'null'
      - float
    doc: Gap extending penalty (Pe)
    default: 0.5
    inputBinding:
      position: 102
      prefix: --pe
  - id: po
    type:
      - 'null'
      - float
    doc: Gap opening penalty (Po)
    default: 10.0
    inputBinding:
      position: 102
      prefix: --po
  - id: similarity
    type:
      - 'null'
      - boolean
    doc: Calculate pairwise sequence similarity
    inputBinding:
      position: 102
      prefix: --similarity
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use. 0 use all available threads
    default: 0
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pseqsid:1.1.0--h4349ce8_0
stdout: pseqsid.out
