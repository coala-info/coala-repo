cwlVersion: v1.2
class: CommandLineTool
baseCommand: faithpd
label: unifrac_faithpd
doc: "Calculates Faith's Phylogenetic Diversity (PD) for each sample in a BIOM table
  using a provided phylogeny.\n\nTool homepage: https://github.com/biocore/unifrac"
inputs:
  - id: biom_table
    type: File
    doc: The input BIOM table.
    inputBinding:
      position: 101
      prefix: -i
  - id: newick_tree
    type: File
    doc: The input phylogeny in newick format.
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_file
    type: File
    doc: The output file path.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unifrac:1.5.1--py39hff726c5_0
