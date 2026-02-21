cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyopt
label: pyopt
doc: "A Python-based framework for formulating and solving optimization problems.\n
  \nTool homepage: https://github.com/boyac/pyOptionPricing"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyopt:1.2.0--py27_1
stdout: pyopt.out
