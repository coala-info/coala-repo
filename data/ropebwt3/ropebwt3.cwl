cwlVersion: v1.2
class: CommandLineTool
baseCommand: ropebwt3
label: ropebwt3
doc: "The provided text is a container runtime error log and does not contain the
  help documentation or usage instructions for the tool.\n\nTool homepage: https://github.com/lh3/ropebwt3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
stdout: ropebwt3.out
