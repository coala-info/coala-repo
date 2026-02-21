cwlVersion: v1.2
class: CommandLineTool
baseCommand: isonclust
label: isonclust
doc: "The provided text is an error log indicating a failure to pull or build the
  container image for isonclust and does not contain help documentation or argument
  definitions.\n\nTool homepage: https://github.com/ksahlin/isONclust"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isonclust:0.0.6.1--py_0
stdout: isonclust.out
