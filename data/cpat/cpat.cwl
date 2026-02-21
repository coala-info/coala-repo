cwlVersion: v1.2
class: CommandLineTool
baseCommand: cpat
label: cpat
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build or pull a container image
  due to insufficient disk space.\n\nTool homepage: https://cpat.readthedocs.io/en/latest/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpat:3.0.5--py312hc9302aa_4
stdout: cpat.out
