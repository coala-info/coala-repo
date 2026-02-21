cwlVersion: v1.2
class: CommandLineTool
baseCommand: fununifrac_create_edge_matrix.py
label: fununifrac_create_edge_matrix.py
doc: "A tool to create an edge matrix for FunUniFrac analysis.\n\nTool homepage: https://github.com/KoslickiLab/FunUniFrac"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fununifrac:0.0.1--pyh7cba7a3_0
stdout: fununifrac_create_edge_matrix.py.out
