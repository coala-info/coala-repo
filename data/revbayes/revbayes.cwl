cwlVersion: v1.2
class: CommandLineTool
baseCommand: revbayes
label: revbayes
doc: "RevBayes is a software for Bayesian phylogenetic inference. (Note: The provided
  text appears to be a container build error log rather than the tool's help text,
  so no arguments could be extracted.)\n\nTool homepage: https://revbayes.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/revbayes:1.3.2--hf316886_0
stdout: revbayes.out
