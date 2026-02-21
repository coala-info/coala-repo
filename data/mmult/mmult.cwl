cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmult
label: mmult
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log indicating a failure to build the container image due to
  insufficient disk space.\n\nTool homepage: https://github.com/lijinbio/MMULT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmult:0.0.0.2--r40h8b68381_0
stdout: mmult.out
