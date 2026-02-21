cwlVersion: v1.2
class: CommandLineTool
baseCommand: htstream
label: htstream
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log indicating a failure to build a container image due to
  insufficient disk space.\n\nTool homepage: https://ibest.github.io/HTStream"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htstream:1.4.1--hbefcdb2_2
stdout: htstream.out
