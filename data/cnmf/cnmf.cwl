cwlVersion: v1.2
class: CommandLineTool
baseCommand: cnmf
label: cnmf
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error logs related to a container runtime failure.\n\n
  Tool homepage: https://github.com/dylkot/cNMF"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnmf:1.7.0--pyhdfd78af_0
stdout: cnmf.out
