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
    inputBinding:
      position: 102
      prefix: --length
  - id: matrix
    type:
      - 'null'
      - string
    doc: 'Type of matrix to be used for Normalized Similarity Score [possible values:
      blosum62, pam250, gonnet]'
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
    inputBinding:
      position: 102
      prefix: --pe
  - id: po
    type:
      - 'null'
      - float
    doc: Gap opening penalty (Po)
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
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: identity_table
    type:
      - 'null'
      - File
    doc: Pairwise sequence identity matrix (with --identity)
    outputBinding:
      glob: $(inputs.msa.nameroot)_identity.csv
  - id: similarity_table
    type:
      - 'null'
      - File
    doc: Pairwise sequence similarity matrix (with --similarity)
    outputBinding:
      glob: $(inputs.msa.nameroot)_similarity.csv
  - id: nss_table
    type:
      - 'null'
      - File
    doc: Pairwise normalized similarity score matrix (with --nss)
    outputBinding:
      glob: $(inputs.msa.nameroot)_nss.csv
  - id: long_table
    type:
      - 'null'
      - File
    doc: Long-form table of all requested pairwise values
    outputBinding:
      glob: $(inputs.msa.nameroot)_table.tsv
  - id: default_grouping
    type:
      - 'null'
      - File
    doc: Default amino acid similarity groups file, created when needed and not given
    outputBinding:
      glob: default_aa_similarity_groups.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pseqsid:1.1.0--h4349ce8_0
