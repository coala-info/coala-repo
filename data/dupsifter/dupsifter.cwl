cwlVersion: v1.2
class: CommandLineTool
baseCommand: dupsifter
label: dupsifter
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log indicating a failure to pull or build the container
  image due to insufficient disk space.\n\nTool homepage: https://github.com/huishenlab/dupsifter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dupsifter:1.3.0.20241113--h566b1c6_1
stdout: dupsifter.out
