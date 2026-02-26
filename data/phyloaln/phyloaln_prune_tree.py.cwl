cwlVersion: v1.2
class: CommandLineTool
baseCommand: prune_tree.py
label: phyloaln_prune_tree.py
doc: "Prunes a phylogenetic tree by removing specified sequences from clades.\n\n\
  Tool homepage: https://github.com/huangyh45/PhyloAln"
inputs:
  - id: input_nwk
    type: File
    doc: Input Newick format tree file
    inputBinding:
      position: 1
  - id: sequences_to_prune
    type:
      type: array
      items: string
    doc: Sequences to prune, specified as 'seq/seqs_in_clade_for_deletion' 
      separated by commas. Each entry represents a clade and the sequences 
      within that clade to be deleted.
    inputBinding:
      position: 2
outputs:
  - id: output_nwk
    type: File
    doc: Output Newick format tree file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloaln:1.1.0--hdfd78af_0
