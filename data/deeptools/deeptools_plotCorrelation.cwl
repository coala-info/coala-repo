cwlVersion: v1.2
class: CommandLineTool
baseCommand: plotCorrelation
label: deeptools_plotCorrelation
doc: "The provided text is an error message indicating a failure to run the tool due
  to insufficient disk space ('no space left on device') while handling a container
  image. No help text or arguments were found in the input.\n\nTool homepage: https://github.com/deeptools/deepTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deeptools:3.5.6--pyhdfd78af_0
stdout: deeptools_plotCorrelation.out
