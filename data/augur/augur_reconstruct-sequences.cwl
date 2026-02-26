cwlVersion: v1.2
class: CommandLineTool
baseCommand: augur reconstruct-sequences
label: augur_reconstruct-sequences
doc: "Reconstruct alignments from mutations inferred on the tree\n\nTool homepage:
  https://github.com/nextstrain/augur"
inputs:
  - id: gene
    type:
      - 'null'
      - type: array
        items: string
    doc: gene to translate (list or file containing list)
    default: None
    inputBinding:
      position: 101
      prefix: --gene
  - id: internal_nodes
    type:
      - 'null'
      - boolean
    doc: include sequences of internal nodes in output
    default: false
    inputBinding:
      position: 101
      prefix: --internal-nodes
  - id: mutations
    type: File
    doc: json file containing mutations mapped to each branch and the sequence 
      of the root.
    default: None
    inputBinding:
      position: 101
      prefix: --mutations
  - id: tree
    type: File
    doc: tree as Newick file
    default: None
    inputBinding:
      position: 101
      prefix: --tree
  - id: vcf_aa_reference
    type:
      - 'null'
      - File
    doc: fasta file of the reference gene translations for VCF format
    default: None
    inputBinding:
      position: 101
      prefix: --vcf-aa-reference
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
