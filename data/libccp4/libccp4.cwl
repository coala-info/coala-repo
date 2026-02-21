cwlVersion: v1.2
class: CommandLineTool
baseCommand: libccp4
label: libccp4
doc: "The provided text does not contain help information for the tool; it contains
  container runtime error messages regarding disk space and environment variables.\n
  \nTool homepage: https://www.ccp4.ac.uk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libccp4:8.0.0--hb2a3317_0
stdout: libccp4.out
