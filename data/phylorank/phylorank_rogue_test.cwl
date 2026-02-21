cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phylorank
  - rogue_test
label: phylorank_rogue_test
doc: "Perform rogue taxon testing within the phylorank suite.\n\nTool homepage: https://github.com/dparks1134/PhyloRank"
inputs:
  - id: input_tree_dir
    type: Directory
    doc: Directory containing input tree files
    inputBinding:
      position: 1
  - id: taxonomy_file
    type: File
    doc: File containing taxonomy information
    inputBinding:
      position: 2
  - id: decorate
    type:
      - 'null'
      - boolean
    doc: Decorate the output
    inputBinding:
      position: 103
      prefix: --decorate
  - id: outgroup_taxon
    type:
      - 'null'
      - string
    doc: Specify the outgroup taxon
    inputBinding:
      position: 103
      prefix: --outgroup_taxon
outputs:
  - id: output_dir
    type: Directory
    doc: Directory to write output files
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylorank:0.1.12--pyhdfd78af_0
