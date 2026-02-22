cwlVersion: v1.2
class: CommandLineTool
baseCommand: scenicplus
label: scenicplus
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system error messages related to container image retrieval
  and storage space issues.\n\nTool homepage: https://github.com/aertslab/scenicplus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scenicplus:1.0a2--pyhdfd78af_0
stdout: scenicplus.out
