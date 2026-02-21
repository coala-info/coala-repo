cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxopy
label: taxopy
doc: "The provided text is a system error log from a container build process and does
  not contain help documentation or usage instructions for the taxopy tool.\n\nTool
  homepage: https://apcamargo.github.io/taxopy/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxopy:0.14.0--pyhdfd78af_0
stdout: taxopy.out
