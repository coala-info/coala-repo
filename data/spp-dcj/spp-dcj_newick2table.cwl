cwlVersion: v1.2
class: CommandLineTool
baseCommand: spp-dcj newick2table
label: spp-dcj_newick2table
doc: "Converts a Newick tree to a table format.\n\nTool homepage: https://github.com/codialab/spp-dcj"
inputs:
  - id: tree
    type: string
    doc: tree in newick format
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spp-dcj:2.0.0--pyh7e72e81_0
stdout: spp-dcj_newick2table.out
