cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kled
  - HapKled
label: kled_HapKled
doc: "The provided text does not contain help information; it is a container runtime
  error log indicating a failure to build the SIF image due to lack of disk space.\n
  \nTool homepage: https://github.com/CoREse/kled"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kled:1.2.10--h4f462e4_0
stdout: kled_HapKled.out
