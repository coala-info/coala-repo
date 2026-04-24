cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clusterfunk
  - ancestral_reconstruction
label: clusterfunk_ancestral_reconstruction
doc: "Reconstruct ancestral states on a phylogenetic tree using ACCTRAN or DELTRAN
  rules.\n\nTool homepage: https://github.com/cov-ert/clusterfunk"
inputs:
  - id: acctran
    type:
      - 'null'
      - boolean
    doc: Boolean flag to use acctran reconstruction
    inputBinding:
      position: 101
      prefix: --acctran
  - id: ancestral_state
    type:
      - 'null'
      - type: array
        items: string
    doc: Option to set the ancestral state for the tree. In same order of traits
    inputBinding:
      position: 101
      prefix: --ancestral_state
  - id: collapse_to_polytomies
    type:
      - 'null'
      - float
    doc: A optional flag to collapse branches with length <= the input before 
      running the rule.
    inputBinding:
      position: 101
      prefix: --collapse_to_polytomies
  - id: deltran
    type:
      - 'null'
      - boolean
    doc: Boolean flag to use deltran reconstruction
    inputBinding:
      position: 101
      prefix: --deltran
  - id: format
    type:
      - 'null'
      - string
    doc: what format is the tree file. This is passed to dendropy. default is 
      'nexus'
    inputBinding:
      position: 101
      prefix: --format
  - id: input
    type: File
    doc: The input tree file. Format can be specified with the format flag.
    inputBinding:
      position: 101
      prefix: --input
  - id: majority_rule
    type:
      - 'null'
      - boolean
    doc: A Boolean flag. In first stage of the Fitch algorithm, at a polytomy, 
      when there is no intersection of traits from all children should the trait
      that appears most in the children be assigned.
    inputBinding:
      position: 101
      prefix: --majority_rule
  - id: traits
    type:
      type: array
      items: string
    doc: the traits whose values will be reconstructed
    inputBinding:
      position: 101
      prefix: --traits
outputs:
  - id: output
    type: File
    doc: The output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
