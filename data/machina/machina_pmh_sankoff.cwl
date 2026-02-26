cwlVersion: v1.2
class: CommandLineTool
baseCommand: pmh_sankoff
label: machina_pmh_sankoff
doc: "Performs the Sankoff algorithm on a phylogenetic tree with leaf labelings.\n\
  \nTool homepage: https://github.com/raphael-group/machina"
inputs:
  - id: clone_tree
    type: string
    doc: Clone tree
    inputBinding:
      position: 1
  - id: leaf_labeling
    type: string
    doc: Leaf labeling
    inputBinding:
      position: 2
  - id: color_map_file
    type:
      - 'null'
      - string
    doc: Color map file
    inputBinding:
      position: 103
      prefix: -c
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output prefix
    inputBinding:
      position: 103
      prefix: -o
  - id: primary_sites
    type:
      - 'null'
      - string
    doc: Primary anatomical sites separated by commas (if omitted, every 
      anatomical site will be considered iteratively as the primary)
    inputBinding:
      position: 103
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/machina:1.2--h21ec9f0_7
stdout: machina_pmh_sankoff.out
