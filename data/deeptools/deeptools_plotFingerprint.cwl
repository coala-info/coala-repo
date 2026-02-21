cwlVersion: v1.2
class: CommandLineTool
baseCommand: plotFingerprint
label: deeptools_plotFingerprint
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build or run the container image
  due to lack of disk space.\n\nTool homepage: https://github.com/deeptools/deepTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deeptools:3.5.6--pyhdfd78af_0
stdout: deeptools_plotFingerprint.out
