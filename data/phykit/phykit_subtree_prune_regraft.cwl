cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - subtree_prune_regraft
label: phykit_subtree_prune_regraft
doc: Generate all possible SPR (Subtree Pruning and Regrafting) rearrangements 
  for a specified subtree on a tree. The subtree is identified by specifying one
  or more taxa whose MRCA defines the clade to prune. The pruned subtree is then
  regrafted onto every other branch in the remaining tree, producing one Newick 
  tree per regraft position.
inputs:
  - id: tree
    type: File
    doc: input tree file in Newick format
    inputBinding:
      position: 101
      prefix: --tree
  - id: subtree
    type: string
    doc: comma-separated list of taxa defining the subtree to prune (MRCA 
      resolved), or a single-column file with one taxon per line
    inputBinding:
      position: 101
      prefix: --subtree
  - id: output
    type: string
    doc: output file for SPR trees (one Newick per line). If omitted, prints to 
      stdout.
    inputBinding:
      position: 101
      prefix: --output
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output results as JSON
    inputBinding:
      position: 101
      prefix: --json
outputs:
  - id: output_output
    type:
      - 'null'
      - File
    doc: output file for SPR trees (one Newick per line). If omitted, prints to 
      stdout.
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
