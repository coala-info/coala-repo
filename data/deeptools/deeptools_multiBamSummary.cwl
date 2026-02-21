cwlVersion: v1.2
class: CommandLineTool
baseCommand: multiBamSummary
label: deeptools_multiBamSummary
doc: "The provided text is an error log indicating a failure to build or run a container
  (no space left on device) and does not contain the help text or argument definitions
  for multiBamSummary.\n\nTool homepage: https://github.com/deeptools/deepTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deeptools:3.5.6--pyhdfd78af_0
stdout: deeptools_multiBamSummary.out
