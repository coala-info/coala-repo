cwlVersion: v1.2
class: CommandLineTool
baseCommand: multivariate
label: multivariate
doc: "A tool for multivariate analysis (Note: The provided text contains system error
  messages regarding container image building and does not include usage instructions
  or argument definitions).\n\nTool homepage: https://github.com/WenjieDu/PyPOTS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/multivariate:phenomenal-v2.3.12_cv1.3.24
stdout: multivariate.out
