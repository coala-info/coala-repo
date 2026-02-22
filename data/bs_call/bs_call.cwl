cwlVersion: v1.2
class: CommandLineTool
baseCommand: bs_call
label: bs_call
doc: "The provided text does not contain help information or usage instructions; it
  consists of system error messages regarding disk space and container image retrieval.\n\
  \nTool homepage: https://github.com/heathsc/bs_call"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bs-seeker2:2.1.7--0
stdout: bs_call.out
