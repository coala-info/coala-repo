cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_mem_lipyphilic_order
label: biobb_mem_lipyphilic_order
doc: "Calculate the order parameter of lipid tails from a trajectory using the Lipyphilic
  library.\n\nTool homepage: https://github.com/bioexcel/biobb_mem"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_mem:5.2.1--pyh7e72e81_0
stdout: biobb_mem_lipyphilic_order.out
