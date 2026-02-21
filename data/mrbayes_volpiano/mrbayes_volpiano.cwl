cwlVersion: v1.2
class: CommandLineTool
baseCommand: mb
label: mrbayes_volpiano
doc: "MrBayes is a program for Bayesian inference of phylogeny. (Note: The provided
  help text contains system error messages and does not list specific command-line
  arguments.)\n\nTool homepage: https://github.com/gaballench/mrbayes_volpiano"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrbayes:3.2.7--hd0d793b_7
stdout: mrbayes_volpiano.out
