cwlVersion: v1.2
class: CommandLineTool
baseCommand: octopusv
label: octopusv
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log indicating a failure to build or pull the container
  image due to insufficient disk space.\n\nTool homepage: https://github.com/ylab-hi/octopusV"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/octopusv:0.2.3--pyhdfd78af_0
stdout: octopusv.out
