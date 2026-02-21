cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamCompare
label: deeptools_bamCompare
doc: "The provided text does not contain help information for the tool. It contains
  container runtime log messages and a fatal error regarding disk space.\n\nTool homepage:
  https://github.com/deeptools/deepTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deeptools:3.5.6--pyhdfd78af_0
stdout: deeptools_bamCompare.out
