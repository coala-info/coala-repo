cwlVersion: v1.2
class: CommandLineTool
baseCommand: fatslim
label: fatslim_biobb_fatslim
doc: "Fast Analysis Toolbox for Simulations of Lipid Membranes (Note: The provided
  text contains only system error logs and no CLI help information; therefore, no
  arguments could be extracted).\n\nTool homepage: https://fatslim.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fatslim_biobb:0.2.2--py39hbcbf7aa_1
stdout: fatslim_biobb_fatslim.out
