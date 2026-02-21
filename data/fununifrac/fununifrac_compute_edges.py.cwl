cwlVersion: v1.2
class: CommandLineTool
baseCommand: fununifrac_compute_edges.py
label: fununifrac_compute_edges.py
doc: "A tool for computing edges in the FunUniFrac workflow. (Note: The provided help
  text contains only system error messages and does not list specific arguments.)\n
  \nTool homepage: https://github.com/KoslickiLab/FunUniFrac"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fununifrac:0.0.1--pyh7cba7a3_0
stdout: fununifrac_compute_edges.py.out
