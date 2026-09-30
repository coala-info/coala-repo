cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phylorank
  - rank_res
label: phylorank_rank_res
doc: "Calculate rank results based on an input tree and taxonomy.\n\nTool homepage:
  https://github.com/dparks1134/PhyloRank"
inputs:
  - id: input_tree
    type: File
    doc: Input tree file
    inputBinding:
      position: 1
  - id: taxonomy_file
    type: File
    doc: Taxonomy file
    inputBinding:
      position: 2
  - id: output_file
    type: string
    doc: Output file
    inputBinding:
      position: 3
  - id: taxa_file
    type:
      - 'null'
      - File
    doc: Optional taxa file
    inputBinding:
      position: 103
      prefix: --taxa_file
outputs:
  - id: out_output_file
    type: File
    doc: Output file
    outputBinding:
      glob: '$(inputs.output_file)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylorank:0.1.12--pyhdfd78af_0
