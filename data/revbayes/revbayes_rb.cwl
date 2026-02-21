cwlVersion: v1.2
class: CommandLineTool
baseCommand: rb
label: revbayes_rb
doc: "RevBayes is a software for Bayesian phylogenetic inference. (Note: The provided
  help text contains container build errors and does not list specific command-line
  arguments.)\n\nTool homepage: https://revbayes.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/revbayes:1.3.2--hf316886_0
stdout: revbayes_rb.out
