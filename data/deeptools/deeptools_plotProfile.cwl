cwlVersion: v1.2
class: CommandLineTool
baseCommand: plotProfile
label: deeptools_plotProfile
doc: "The provided text is an error log indicating a system failure (no space left
  on device) and does not contain the help documentation for deeptools_plotProfile.
  As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/deeptools/deepTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deeptools:3.5.6--pyhdfd78af_0
stdout: deeptools_plotProfile.out
