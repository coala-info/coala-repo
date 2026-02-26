cwlVersion: v1.2
class: CommandLineTool
baseCommand: fatslim
label: fatslim_biobb_fatslim
doc: "Fast Analysis Toolbox for Simulations of Lipid Membranes\n\nTool homepage: https://fatslim.github.io/"
inputs:
  - id: command
    type: string
    doc: 'Available commands: aggregates, apl, benchmark, help, membranes, self-test,
      thickness, version'
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the selected command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fatslim_biobb:0.2.2--py39hbcbf7aa_1
stdout: fatslim_biobb_fatslim.out
