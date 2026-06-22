cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - prune_tree
label: phykit_prune_tree
doc: Prune tips from a phylogeny. Provide a single column file with the names of
  the tips in the input phylogeny you would like to prune from the tree.
inputs:
  - id: tree
    type: File
    doc: first argument after function name should be a tree file
    inputBinding:
      position: 1
  - id: list_of_taxa
    type:
      - 'null'
      - File
    doc: single column file with the names of the tips to remove from the 
      phylogeny
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: name of output file for the pruned phylogeny. Default output will have 
      the same name as the input file but with the suffix ".pruned"
    inputBinding:
      position: 103
      prefix: --output
  - id: keep
    type:
      - 'null'
      - boolean
    doc: optional argument. If used instead of pruning taxa in <list_of_taxa>, 
      keep them
    inputBinding:
      position: 103
      prefix: --keep
  - id: ignore_branch_labels
    type:
      - 'null'
      - boolean
    doc: optional argument. Strip HyPhy/aBSREL-style {...} branch labels (e.g., 
      "Hydlep{FG}") from tip names when matching against <list_of_taxa>. The 
      labels are preserved in the output tree.
    inputBinding:
      position: 103
      prefix: --ignore-branch-labels
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output results as JSON
    inputBinding:
      position: 103
      prefix: --json
outputs:
  - id: output_output
    type:
      - 'null'
      - File
    doc: name of output file for the pruned phylogeny. Default output will have 
      the same name as the input file but with the suffix ".pruned"
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
