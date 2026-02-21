cwlVersion: v1.2
class: CommandLineTool
baseCommand: sparcc_PseudoPvals.py
label: sparcc_PseudoPvals.py
doc: "Calculate pseudo p-values for SparCC correlations. (Note: The provided help
  text contains only container runtime error messages and no usage information was
  available in the input.)\n\nTool homepage: https://bitbucket.org/yonatanf/sparcc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sparcc:0.1.0--0
stdout: sparcc_PseudoPvals.py.out
