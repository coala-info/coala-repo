cwlVersion: v1.2
class: CommandLineTool
baseCommand: radte
label: radte
doc: "RAD-seq Tool for Ecology (Note: The provided text contains build logs and error
  messages rather than help documentation; no arguments could be extracted from the
  input.)\n\nTool homepage: https://github.com/kfuku52/radte"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/radte:0.2.3--r44hdfd78af_0
stdout: radte.out
