cwlVersion: v1.2
class: CommandLineTool
baseCommand: libcarna
label: libcarna
doc: "The provided text is a system error message regarding a container build failure
  and does not contain help documentation or usage instructions for the tool.\n\n
  Tool homepage: https://github.com/kostrykin/Carna"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libcarna:3.4.0--h9948957_0
stdout: libcarna.out
