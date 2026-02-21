cwlVersion: v1.2
class: CommandLineTool
baseCommand: treebest_spec
label: treebest_spec
doc: "A species tree in Newick format used by TreeBest for gene tree reconstruction
  and species tree reconciliation. It defines the phylogenetic relationships and taxonomy
  IDs for various eukaryotic species.\n\nTool homepage: https://github.com/lh3/treebest"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
stdout: treebest_spec.out
