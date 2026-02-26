cwlVersion: v1.2
class: CommandLineTool
baseCommand: spp-dcj sol2adj
label: spp-dcj_sol2adj
doc: "Converts a GUROBI solution file to an adjacency list representation.\n\nTool
  homepage: https://github.com/codialab/spp-dcj"
inputs:
  - id: sol_file
    type: File
    doc: solution file of GUROBI optimizer
    inputBinding:
      position: 1
  - id: id_to_extremity_map
    type: File
    doc: mapping between node IDs and extremities
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spp-dcj:2.0.0--pyh7e72e81_0
stdout: spp-dcj_sol2adj.out
