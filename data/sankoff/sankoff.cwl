cwlVersion: v1.2
class: CommandLineTool
baseCommand: sankoff
label: sankoff
doc: "Fast Sankoff algorithm with parallel options.\n\nTool homepage: https://github.com/hzi-bifo/sankoff"
inputs:
  - id: aln
    type:
      - 'null'
      - File
    doc: aligned sequence file
    inputBinding:
      position: 101
      prefix: --aln
  - id: cost
    type:
      - 'null'
      - File
    doc: cost function file name
    inputBinding:
      position: 101
      prefix: --cost
  - id: cost_identity_aa
    type:
      - 'null'
      - string
    doc: Cost matrix is for chars of amino acids in addition to X and -. The 
      parameters are cost of A-B where A and B are either amino acids (aa) X or 
      gap with following order [identical aa] [non-identical aa] [aa-X] [X-X] 
      [gap-X] [aa-gap] [gap-gap].
    inputBinding:
      position: 101
      prefix: --cost-identity-aa
  - id: cost_identity_dna
    type:
      - 'null'
      - string
    doc: Cost matrix is for chars of nucleic acid in addition to X and -. The 
      parameters are cost of A-B where A and B are either nucleid acids (na) X 
      or gap with following order [identical na] [non-identical na] [na-X] [X-X]
      [gap-X] [na-gap] [gap-gap].
    inputBinding:
      position: 101
      prefix: --cost-identity-dna
  - id: ilabel
    type:
      - 'null'
      - string
    doc: Assign label to internal nodes. The argument is the prefix.
    default: inode
    inputBinding:
      position: 101
      prefix: --ilabel
  - id: induce_tree_over_samples
    type:
      - 'null'
      - int
    doc: remove nodes not in the alignment
    default: 1
    inputBinding:
      position: 101
      prefix: --induce_tree_over_samples
  - id: nexus
    type:
      - 'null'
      - File
    doc: input nexus file.
    inputBinding:
      position: 101
      prefix: --nexus
  - id: nthread
    type:
      - 'null'
      - int
    doc: change number of default threads
    default: 20
    inputBinding:
      position: 101
      prefix: --nthread
  - id: omit_leaf_mutations
    type:
      - 'null'
      - boolean
    doc: omit mutations happen at leaf nodes
    inputBinding:
      position: 101
      prefix: --omit-leaf-mutations
  - id: tree
    type:
      - 'null'
      - File
    doc: input tree file.
    inputBinding:
      position: 101
      prefix: --tree
outputs:
  - id: out_as
    type:
      - 'null'
      - File
    doc: print sequences of ancestral and leaf nodes to this file.
    outputBinding:
      glob: $(inputs.out_as)
  - id: out_tree
    type:
      - 'null'
      - File
    doc: The tree to this file. Some times it is useful, for example when to 
      internal nodes of the input tree no label is assigned.
    outputBinding:
      glob: $(inputs.out_tree)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sankoff:0.2--h9948957_5
