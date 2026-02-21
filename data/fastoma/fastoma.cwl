cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastoma
label: fastoma
doc: "FastOMA is a tool for orthology inference. (Note: The provided text contains
  container runtime error messages and does not include the actual help documentation
  or argument definitions).\n\nTool homepage: https://github.com/DessimozLab/FastOMA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastoma:0.5.1--pyhdfd78af_0
stdout: fastoma.out
