cwlVersion: v1.2
class: CommandLineTool
baseCommand: glimmer
label: glimmer_Vite
doc: "Glimmer (Gene Locator and Interpolated Markov ModelER) is a system for finding
  genes in microbial DNA. Note: The provided help text contains only system error
  messages regarding container execution and does not list specific command-line arguments.\n
  \nTool homepage: https://github.com/glimmerjs/glimmer-vm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/glimmer:3.02--2
stdout: glimmer_Vite.out
